// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2023.2 (64-bit)
// Tool Version Limit: 2023.10
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef XBUFFER_ADC_H
#define XBUFFER_ADC_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xbuffer_adc_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
#ifdef SDT
    char *Name;
#else
    u16 DeviceId;
#endif
    u64 Control_BaseAddress;
} XBuffer_adc_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XBuffer_adc;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XBuffer_adc_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XBuffer_adc_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XBuffer_adc_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XBuffer_adc_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
#ifdef SDT
int XBuffer_adc_Initialize(XBuffer_adc *InstancePtr, UINTPTR BaseAddress);
XBuffer_adc_Config* XBuffer_adc_LookupConfig(UINTPTR BaseAddress);
#else
int XBuffer_adc_Initialize(XBuffer_adc *InstancePtr, u16 DeviceId);
XBuffer_adc_Config* XBuffer_adc_LookupConfig(u16 DeviceId);
#endif
int XBuffer_adc_CfgInitialize(XBuffer_adc *InstancePtr, XBuffer_adc_Config *ConfigPtr);
#else
int XBuffer_adc_Initialize(XBuffer_adc *InstancePtr, const char* InstanceName);
int XBuffer_adc_Release(XBuffer_adc *InstancePtr);
#endif


void XBuffer_adc_Set_DDR_size(XBuffer_adc *InstancePtr, u32 Data);
u32 XBuffer_adc_Get_DDR_size(XBuffer_adc *InstancePtr);
u32 XBuffer_adc_Get_DDR_cons_addr(XBuffer_adc *InstancePtr);
u32 XBuffer_adc_Get_DDR_cons_addr_vld(XBuffer_adc *InstancePtr);
void XBuffer_adc_Set_DDR_prod_addr(XBuffer_adc *InstancePtr, u32 Data);
u32 XBuffer_adc_Get_DDR_prod_addr(XBuffer_adc *InstancePtr);
void XBuffer_adc_Set_DDR_Ready(XBuffer_adc *InstancePtr, u32 Data);
u32 XBuffer_adc_Get_DDR_Ready(XBuffer_adc *InstancePtr);
void XBuffer_adc_Set_DDR_Master(XBuffer_adc *InstancePtr, u64 Data);
u64 XBuffer_adc_Get_DDR_Master(XBuffer_adc *InstancePtr);
void XBuffer_adc_Set_ADC_buffer_error_i(XBuffer_adc *InstancePtr, u32 Data);
u32 XBuffer_adc_Get_ADC_buffer_error_i(XBuffer_adc *InstancePtr);
u32 XBuffer_adc_Get_ADC_buffer_error_o(XBuffer_adc *InstancePtr);
u32 XBuffer_adc_Get_ADC_buffer_error_o_vld(XBuffer_adc *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
