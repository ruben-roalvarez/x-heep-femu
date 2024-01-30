// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2023.2 (64-bit)
// Tool Version Limit: 2023.10
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
/***************************** Include Files *********************************/
#include "xbuffer_adc.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XBuffer_adc_CfgInitialize(XBuffer_adc *InstancePtr, XBuffer_adc_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XBuffer_adc_Set_DDR_size(XBuffer_adc *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XBuffer_adc_WriteReg(InstancePtr->Control_BaseAddress, XBUFFER_ADC_CONTROL_ADDR_DDR_SIZE_DATA, Data);
}

u32 XBuffer_adc_Get_DDR_size(XBuffer_adc *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XBuffer_adc_ReadReg(InstancePtr->Control_BaseAddress, XBUFFER_ADC_CONTROL_ADDR_DDR_SIZE_DATA);
    return Data;
}

u32 XBuffer_adc_Get_DDR_cons_addr(XBuffer_adc *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XBuffer_adc_ReadReg(InstancePtr->Control_BaseAddress, XBUFFER_ADC_CONTROL_ADDR_DDR_CONS_ADDR_DATA);
    return Data;
}

u32 XBuffer_adc_Get_DDR_cons_addr_vld(XBuffer_adc *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XBuffer_adc_ReadReg(InstancePtr->Control_BaseAddress, XBUFFER_ADC_CONTROL_ADDR_DDR_CONS_ADDR_CTRL);
    return Data & 0x1;
}

void XBuffer_adc_Set_DDR_prod_addr(XBuffer_adc *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XBuffer_adc_WriteReg(InstancePtr->Control_BaseAddress, XBUFFER_ADC_CONTROL_ADDR_DDR_PROD_ADDR_DATA, Data);
}

u32 XBuffer_adc_Get_DDR_prod_addr(XBuffer_adc *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XBuffer_adc_ReadReg(InstancePtr->Control_BaseAddress, XBUFFER_ADC_CONTROL_ADDR_DDR_PROD_ADDR_DATA);
    return Data;
}

void XBuffer_adc_Set_DDR_Ready(XBuffer_adc *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XBuffer_adc_WriteReg(InstancePtr->Control_BaseAddress, XBUFFER_ADC_CONTROL_ADDR_DDR_READY_DATA, Data);
}

u32 XBuffer_adc_Get_DDR_Ready(XBuffer_adc *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XBuffer_adc_ReadReg(InstancePtr->Control_BaseAddress, XBUFFER_ADC_CONTROL_ADDR_DDR_READY_DATA);
    return Data;
}

void XBuffer_adc_Set_DDR_Master(XBuffer_adc *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XBuffer_adc_WriteReg(InstancePtr->Control_BaseAddress, XBUFFER_ADC_CONTROL_ADDR_DDR_MASTER_DATA, (u32)(Data));
    XBuffer_adc_WriteReg(InstancePtr->Control_BaseAddress, XBUFFER_ADC_CONTROL_ADDR_DDR_MASTER_DATA + 4, (u32)(Data >> 32));
}

u64 XBuffer_adc_Get_DDR_Master(XBuffer_adc *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XBuffer_adc_ReadReg(InstancePtr->Control_BaseAddress, XBUFFER_ADC_CONTROL_ADDR_DDR_MASTER_DATA);
    Data += (u64)XBuffer_adc_ReadReg(InstancePtr->Control_BaseAddress, XBUFFER_ADC_CONTROL_ADDR_DDR_MASTER_DATA + 4) << 32;
    return Data;
}

void XBuffer_adc_Set_ADC_buffer_error_i(XBuffer_adc *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XBuffer_adc_WriteReg(InstancePtr->Control_BaseAddress, XBUFFER_ADC_CONTROL_ADDR_ADC_BUFFER_ERROR_I_DATA, Data);
}

u32 XBuffer_adc_Get_ADC_buffer_error_i(XBuffer_adc *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XBuffer_adc_ReadReg(InstancePtr->Control_BaseAddress, XBUFFER_ADC_CONTROL_ADDR_ADC_BUFFER_ERROR_I_DATA);
    return Data;
}

u32 XBuffer_adc_Get_ADC_buffer_error_o(XBuffer_adc *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XBuffer_adc_ReadReg(InstancePtr->Control_BaseAddress, XBUFFER_ADC_CONTROL_ADDR_ADC_BUFFER_ERROR_O_DATA);
    return Data;
}

u32 XBuffer_adc_Get_ADC_buffer_error_o_vld(XBuffer_adc *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XBuffer_adc_ReadReg(InstancePtr->Control_BaseAddress, XBUFFER_ADC_CONTROL_ADDR_ADC_BUFFER_ERROR_O_CTRL);
    return Data & 0x1;
}

