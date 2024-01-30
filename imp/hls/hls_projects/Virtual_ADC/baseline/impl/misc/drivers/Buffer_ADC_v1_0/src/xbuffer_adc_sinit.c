// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2023.2 (64-bit)
// Tool Version Limit: 2023.10
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#ifdef SDT
#include "xparameters.h"
#endif
#include "xbuffer_adc.h"

extern XBuffer_adc_Config XBuffer_adc_ConfigTable[];

#ifdef SDT
XBuffer_adc_Config *XBuffer_adc_LookupConfig(UINTPTR BaseAddress) {
	XBuffer_adc_Config *ConfigPtr = NULL;

	int Index;

	for (Index = (u32)0x0; XBuffer_adc_ConfigTable[Index].Name != NULL; Index++) {
		if (!BaseAddress || XBuffer_adc_ConfigTable[Index].Control_BaseAddress == BaseAddress) {
			ConfigPtr = &XBuffer_adc_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XBuffer_adc_Initialize(XBuffer_adc *InstancePtr, UINTPTR BaseAddress) {
	XBuffer_adc_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XBuffer_adc_LookupConfig(BaseAddress);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XBuffer_adc_CfgInitialize(InstancePtr, ConfigPtr);
}
#else
XBuffer_adc_Config *XBuffer_adc_LookupConfig(u16 DeviceId) {
	XBuffer_adc_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XBUFFER_ADC_NUM_INSTANCES; Index++) {
		if (XBuffer_adc_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XBuffer_adc_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XBuffer_adc_Initialize(XBuffer_adc *InstancePtr, u16 DeviceId) {
	XBuffer_adc_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XBuffer_adc_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XBuffer_adc_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif

#endif

