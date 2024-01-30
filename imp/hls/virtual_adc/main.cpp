#include <stdint.h>
#include <stdio.h>
#include "buffer_adc.h"
#include <stdlib.h>
#include <cstdint>
#include <math.h>

#define ADC_SIZE (int)pow(2,BITS_ADC)
#define DDR_SIZE ADC_SIZE * 2
#define DATA_SIZE ADC_SIZE * 2 * 8

int virtual_adc_test(int ddr_rate, int buff_rate, int adc_rate, int skip_control)
{
	uint16_t global_data[DATA_SIZE];
	uint64_t * global_data64;
	uint16_t * global_check16;
	ap_uint<32> ADC_mem[ADC_SIZE];
	ap_uint<64> DDR_mem[DDR_SIZE];
	ap_uint<BITS_ADC> ADC_cons_addr = 0;
	ap_uint<BITS_ADC> ADC_prod_addr = 0; // Modified by the module
	ap_uint<32> DDR_cons_addr = 0; // Modified by the module
	ap_uint<32> DDR_prod_addr = 0;
	ap_uint<32> DDR_prod_addr_next = 0;
	uint32_t ADC_buffer_consumer = 0;
	int ADC_global_check = 0;
	int ADC_global_read = 0;
	int errors = 0;
	int checks = 0;
	int finish = 0;
	ap_uint<1> ADC_error = 0; // Modified by the module
	int out_of_bound_read = 0;

	printf("Starting Test...\n");

	/* Generate global data */
	for(uint32_t ii = 0 ; ii < DATA_SIZE ; ii++){
		global_data[ii] = ii % 227;
	}
	global_data64 = (uint64_t *)global_data;
	global_check16 = (uint16_t *)ADC_mem;

	// Reset
	Buffer_ADC(DDR_SIZE,DDR_cons_addr,DDR_prod_addr,0,DDR_mem,ADC_mem,0,ADC_cons_addr,ADC_prod_addr, ADC_error);

	while(!finish){
		/* Fill DDR memory with data */
		for(uint32_t ii = 0 ; ii < ddr_rate ; ii++){
			DDR_prod_addr_next = DDR_prod_addr + 1;
			if(DDR_prod_addr_next >= DDR_SIZE) DDR_prod_addr_next = 0;
			if(DDR_prod_addr_next != DDR_cons_addr){
				DDR_mem[DDR_prod_addr] = global_data64[ADC_global_read];
				if(ADC_global_read < DATA_SIZE/4 - 1) ADC_global_read++;
				if(++DDR_prod_addr == DDR_SIZE) DDR_prod_addr = 0;
			}
		}

		/* Manage buffer */
		for(uint32_t ii = 0 ; ii < buff_rate ; ii++){
			Buffer_ADC(DDR_SIZE,DDR_cons_addr,DDR_prod_addr,1,DDR_mem,ADC_mem,1,ADC_cons_addr,ADC_prod_addr, ADC_error);
		}

		// Check out of bound read access
		if(out_of_bound_read == 1){
			if(ADC_error == 1){
				printf("Tests results: out of bound detected (checks = %d , errors = %d)\n",checks, errors);
				return 0; // The out of bound read was detected by the virtual ADC module
			}else{
				printf("Tests results: out of bound NOT detected (checks = %d , errors = %d)\n",checks, errors);
				return -1; // The out of bound read was NOT detected by the virtual ADC module
			}
		}

		/* Read from the ADC (Check for errors) */
		for(uint32_t ii = 0 ; ii < adc_rate ; ii++){
			if((ADC_cons_addr != ADC_prod_addr) && (out_of_bound_read == 0)){
				if(global_data[ADC_global_check] != global_check16[ADC_buffer_consumer]){
					printf("[%d|%d] %d != %d\n", ADC_global_check,ADC_buffer_consumer, global_data[ADC_global_check], global_check16[ADC_buffer_consumer]);
					errors++;
				}else{
//					printf("[%d|%d] %d == %d\n", ADC_global_check, ADC_buffer_consumer, global_data[ADC_global_check], global_check16[ADC_buffer_consumer]);
					checks++;
				}
				if(++ADC_buffer_consumer >= (ADC_SIZE*2)) ADC_buffer_consumer = 0;
				ADC_cons_addr = (ap_uint<BITS_ADC>)(ADC_buffer_consumer/2);
				if(++ADC_global_check >= DATA_SIZE){
					finish = 1;
					break;
				}
			}else{
				if(skip_control){
					out_of_bound_read = 1;
					if(++ADC_buffer_consumer >= (ADC_SIZE*2)) ADC_buffer_consumer = 0;
					ADC_cons_addr = (ap_uint<BITS_ADC>)ADC_buffer_consumer/2;
				}
			}
		}
	}

	printf("Tests results: checks = %d , errors = %d\n",checks, errors);
	printf("Detected errors: %d\n", ADC_error);
	return errors;
}

int main(int , char ** ){

	int test_error = 0;

	printf("Tests begins\n");
	if(virtual_adc_test(16, 4, 1, 0) != 0){ // DDR faster (normal operation) (OK)
		test_error++;
		printf("Test DDR faster FAILED\n");
	}
	if(virtual_adc_test(4, 16, 1, 1) != 0){ // DDR slower (Test virtual ADC prod/cons logic) (OK)
		test_error++;
		printf("Test DDR slower FAILED\n");
	}
	if(virtual_adc_test(2, 1, 64, 1) != 0){ // Faster consumer error detection (OK)
		test_error++;
		printf("Test Faster consumer error detection FAILED\n");
	}
	if(virtual_adc_test(2, 1, 64, 0) != 0){ // Faster consumer without error (OK)
		test_error++;
		printf("Test Faster consumer without error FAILED\n");
	}

	if (test_error == 0){
		printf("Tests PASSED (test failed = %d)\n",test_error);
	}else{
		printf("Tests FAILED (test failed = %d)\n",test_error);
	}

	return 0;
}
