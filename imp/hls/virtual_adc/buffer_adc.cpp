#include <cstdint>
#include "buffer_adc.h"

void Buffer_ADC(ap_uint<32> DDR_size,						// I : Slave register
				ap_uint<32> & DDR_cons_addr,				// O : Slave register
				ap_uint<32> DDR_prod_addr, 					// I : Slave register
				ap_uint<32> DDR_Ready,						// I : Slave register
				ap_uint<64> * DDR_Master, 					// I : Master connection to DDR through HP Master AXI port
				ap_uint<32> * ADC_mem,	 					// O : Writing port to the BRAM
				ap_uint<1> ADC_Ready,						// I : From ADC
				ap_uint<BITS_ADC> ADC_buffer_cons_addr,		// I : From ADC (Points to the next address to be read)
				ap_uint<BITS_ADC> & ADC_buffer_prod_addr,	// O : To ADC
				ap_uint<1> & ADC_buffer_error				// If there was an error during the ADC operation
				)
{
#pragma HLS INTERFACE ap_none port=ADC_buffer_prod_addr
#pragma HLS INTERFACE ap_none port=ADC_buffer_cons_addr
#pragma HLS INTERFACE ap_none port=ADC_Ready
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS INTERFACE ap_memory storage_type=ram_s2p depth=2048 port=ADC_mem
#pragma HLS INTERFACE s_axilite port=DDR_size
#pragma HLS INTERFACE s_axilite port=DDR_cons_addr
#pragma HLS INTERFACE s_axilite port=DDR_prod_addr
#pragma HLS INTERFACE s_axilite port=DDR_Ready
#pragma HLS INTERFACE m_axi port=DDR_Master offset=slave
#pragma HLS INTERFACE s_axilite port=ADC_buffer_error

	// Code
	// Improvement opportunity: gather a stream of data based on the difference between producer and consumer
	static ap_uint<BITS_ADC> ADC_buffer_prod_addr_reg = 0;
	static ap_uint<BITS_ADC> ADC_buffer_cons_addr_reg = 0;
	static ap_uint<32> DDR_cons_addr_reg = 0;
	ap_uint<1> ADC_buffer_empty_error = 0; // Error signal if ADC tries to read non-generated address
	ap_uint<1> ADC_buffer_full;
	ap_uint<1> DDR_empty;
	ap_uint<BITS_ADC> ADC_buffer_prod_addr_next;
	ap_uint<BITS_ADC> ADC_buffer_prod_addr_next_next;

	// Buffer error check
	if(ADC_buffer_error == 1){ // Copy error if it hasnt been cleared
		ADC_buffer_empty_error = ADC_buffer_error;
	}else{
		if(ADC_buffer_prod_addr_reg <= ADC_buffer_cons_addr_reg){ // Check if there is an error in the reading
			ADC_buffer_empty_error = (ADC_buffer_cons_addr < ADC_buffer_cons_addr_reg) && (ADC_buffer_cons_addr > ADC_buffer_prod_addr_reg);
		}else{
			ADC_buffer_empty_error = (ADC_buffer_cons_addr < ADC_buffer_cons_addr_reg) || (ADC_buffer_cons_addr > ADC_buffer_prod_addr_reg);
		}
	}

	if((ADC_buffer_empty_error == 1) || (DDR_Ready == 0)){
		ADC_buffer_prod_addr_reg = 0;
		ADC_buffer_cons_addr_reg = 0;
		DDR_cons_addr_reg = 0;
	}

	ADC_buffer_cons_addr_reg = ADC_buffer_cons_addr; // Register the consumer address
	
	ADC_buffer_prod_addr_next = ADC_buffer_prod_addr_reg + 1;
	ADC_buffer_prod_addr_next_next = ADC_buffer_prod_addr_reg + 2;
	ADC_buffer_full = (ADC_buffer_prod_addr_next == ADC_buffer_cons_addr_reg) || (ADC_buffer_prod_addr_next_next == ADC_buffer_cons_addr_reg);
	DDR_empty = DDR_prod_addr == DDR_cons_addr_reg;

	if(ADC_Ready && DDR_Ready && (ADC_buffer_full == 0) && (DDR_empty == 0) && (ADC_buffer_empty_error == 0)){
		ADC_mem[ADC_buffer_prod_addr_reg] = DDR_Master[DDR_cons_addr_reg];
		ADC_mem[ADC_buffer_prod_addr_next] = DDR_Master[DDR_cons_addr_reg] >> 32;
		if(++DDR_cons_addr_reg == DDR_size) DDR_cons_addr_reg = 0;
		ADC_buffer_prod_addr_reg += 2;
	}
	DDR_cons_addr = DDR_cons_addr_reg;
	ADC_buffer_prod_addr = ADC_buffer_prod_addr_reg;

	ADC_buffer_error = ADC_buffer_empty_error;
}
