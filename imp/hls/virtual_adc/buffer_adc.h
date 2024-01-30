#ifndef	BUFFER_ADC_H
#define	BUFFER_ADC_H

#include <ap_int.h>

#define	BITS_ADC 10
#define	STREAM_SIZE 8

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
				);

#endif
