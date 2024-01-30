// 0x00 : reserved
// 0x04 : reserved
// 0x08 : reserved
// 0x0c : reserved
// 0x10 : Data signal of DDR_size
//        bit 31~0 - DDR_size[31:0] (Read/Write)
// 0x14 : reserved
// 0x18 : Data signal of DDR_cons_addr
//        bit 31~0 - DDR_cons_addr[31:0] (Read)
// 0x1c : Control signal of DDR_cons_addr
//        bit 0  - DDR_cons_addr_ap_vld (Read/COR)
//        others - reserved
// 0x28 : Data signal of DDR_prod_addr
//        bit 31~0 - DDR_prod_addr[31:0] (Read/Write)
// 0x2c : reserved
// 0x30 : Data signal of DDR_Ready
//        bit 31~0 - DDR_Ready[31:0] (Read/Write)
// 0x34 : reserved
// 0x38 : Data signal of DDR_Master
//        bit 31~0 - DDR_Master[31:0] (Read/Write)
// 0x3c : Data signal of DDR_Master
//        bit 31~0 - DDR_Master[63:32] (Read/Write)
// 0x40 : reserved
// 0x44 : Data signal of ADC_buffer_error_i
//        bit 0  - ADC_buffer_error_i[0] (Read/Write)
//        others - reserved
// 0x48 : reserved
// 0x4c : Data signal of ADC_buffer_error_o
//        bit 0  - ADC_buffer_error_o[0] (Read)
//        others - reserved
// 0x50 : Control signal of ADC_buffer_error_o
//        bit 0  - ADC_buffer_error_o_ap_vld (Read/COR)
//        others - reserved
// (SC = Self Clear, COR = Clear on Read, TOW = Toggle on Write, COH = Clear on Handshake)

#define CONTROL_ADDR_DDR_SIZE_DATA           0x10
#define CONTROL_BITS_DDR_SIZE_DATA           32
#define CONTROL_ADDR_DDR_CONS_ADDR_DATA      0x18
#define CONTROL_BITS_DDR_CONS_ADDR_DATA      32
#define CONTROL_ADDR_DDR_CONS_ADDR_CTRL      0x1c
#define CONTROL_ADDR_DDR_PROD_ADDR_DATA      0x28
#define CONTROL_BITS_DDR_PROD_ADDR_DATA      32
#define CONTROL_ADDR_DDR_READY_DATA          0x30
#define CONTROL_BITS_DDR_READY_DATA          32
#define CONTROL_ADDR_DDR_MASTER_DATA         0x38
#define CONTROL_BITS_DDR_MASTER_DATA         64
#define CONTROL_ADDR_ADC_BUFFER_ERROR_I_DATA 0x44
#define CONTROL_BITS_ADC_BUFFER_ERROR_I_DATA 1
#define CONTROL_ADDR_ADC_BUFFER_ERROR_O_DATA 0x4c
#define CONTROL_BITS_ADC_BUFFER_ERROR_O_DATA 1
#define CONTROL_ADDR_ADC_BUFFER_ERROR_O_CTRL 0x50
