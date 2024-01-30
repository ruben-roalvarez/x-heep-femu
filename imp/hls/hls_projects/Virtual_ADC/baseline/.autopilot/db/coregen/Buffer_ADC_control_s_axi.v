// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2023.2 (64-bit)
// Tool Version Limit: 2023.10
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
`timescale 1ns/1ps
module Buffer_ADC_control_s_axi
#(parameter
    C_S_AXI_ADDR_WIDTH = 7,
    C_S_AXI_DATA_WIDTH = 32
)(
    input  wire                          ACLK,
    input  wire                          ARESET,
    input  wire                          ACLK_EN,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] AWADDR,
    input  wire                          AWVALID,
    output wire                          AWREADY,
    input  wire [C_S_AXI_DATA_WIDTH-1:0] WDATA,
    input  wire [C_S_AXI_DATA_WIDTH/8-1:0] WSTRB,
    input  wire                          WVALID,
    output wire                          WREADY,
    output wire [1:0]                    BRESP,
    output wire                          BVALID,
    input  wire                          BREADY,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] ARADDR,
    input  wire                          ARVALID,
    output wire                          ARREADY,
    output wire [C_S_AXI_DATA_WIDTH-1:0] RDATA,
    output wire [1:0]                    RRESP,
    output wire                          RVALID,
    input  wire                          RREADY,
    output wire [31:0]                   DDR_size,
    input  wire [31:0]                   DDR_cons_addr,
    input  wire                          DDR_cons_addr_ap_vld,
    output wire [31:0]                   DDR_prod_addr,
    output wire [31:0]                   DDR_Ready,
    output wire [63:0]                   DDR_Master,
    output wire [0:0]                    ADC_buffer_error_i,
    input  wire [0:0]                    ADC_buffer_error_o,
    input  wire                          ADC_buffer_error_o_ap_vld
);
//------------------------Address Info-------------------
// Protocol Used: ap_ctrl_none
//
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

//------------------------Parameter----------------------
localparam
    ADDR_DDR_SIZE_DATA_0           = 7'h10,
    ADDR_DDR_SIZE_CTRL             = 7'h14,
    ADDR_DDR_CONS_ADDR_DATA_0      = 7'h18,
    ADDR_DDR_CONS_ADDR_CTRL        = 7'h1c,
    ADDR_DDR_PROD_ADDR_DATA_0      = 7'h28,
    ADDR_DDR_PROD_ADDR_CTRL        = 7'h2c,
    ADDR_DDR_READY_DATA_0          = 7'h30,
    ADDR_DDR_READY_CTRL            = 7'h34,
    ADDR_DDR_MASTER_DATA_0         = 7'h38,
    ADDR_DDR_MASTER_DATA_1         = 7'h3c,
    ADDR_DDR_MASTER_CTRL           = 7'h40,
    ADDR_ADC_BUFFER_ERROR_I_DATA_0 = 7'h44,
    ADDR_ADC_BUFFER_ERROR_I_CTRL   = 7'h48,
    ADDR_ADC_BUFFER_ERROR_O_DATA_0 = 7'h4c,
    ADDR_ADC_BUFFER_ERROR_O_CTRL   = 7'h50,
    WRIDLE                         = 2'd0,
    WRDATA                         = 2'd1,
    WRRESP                         = 2'd2,
    WRRESET                        = 2'd3,
    RDIDLE                         = 2'd0,
    RDDATA                         = 2'd1,
    RDRESET                        = 2'd2,
    ADDR_BITS                = 7;

//------------------------Local signal-------------------
    reg  [1:0]                    wstate = WRRESET;
    reg  [1:0]                    wnext;
    reg  [ADDR_BITS-1:0]          waddr;
    wire [C_S_AXI_DATA_WIDTH-1:0] wmask;
    wire                          aw_hs;
    wire                          w_hs;
    reg  [1:0]                    rstate = RDRESET;
    reg  [1:0]                    rnext;
    reg  [C_S_AXI_DATA_WIDTH-1:0] rdata;
    wire                          ar_hs;
    wire [ADDR_BITS-1:0]          raddr;
    // internal registers
    reg  [31:0]                   int_DDR_size = 'b0;
    reg                           int_DDR_cons_addr_ap_vld;
    reg  [31:0]                   int_DDR_cons_addr = 'b0;
    reg  [31:0]                   int_DDR_prod_addr = 'b0;
    reg  [31:0]                   int_DDR_Ready = 'b0;
    reg  [63:0]                   int_DDR_Master = 'b0;
    reg  [0:0]                    int_ADC_buffer_error_i = 'b0;
    reg                           int_ADC_buffer_error_o_ap_vld;
    reg  [0:0]                    int_ADC_buffer_error_o = 'b0;

//------------------------Instantiation------------------


//------------------------AXI write fsm------------------
assign AWREADY = (wstate == WRIDLE);
assign WREADY  = (wstate == WRDATA);
assign BRESP   = 2'b00;  // OKAY
assign BVALID  = (wstate == WRRESP);
assign wmask   = { {8{WSTRB[3]}}, {8{WSTRB[2]}}, {8{WSTRB[1]}}, {8{WSTRB[0]}} };
assign aw_hs   = AWVALID & AWREADY;
assign w_hs    = WVALID & WREADY;

// wstate
always @(posedge ACLK) begin
    if (ARESET)
        wstate <= WRRESET;
    else if (ACLK_EN)
        wstate <= wnext;
end

// wnext
always @(*) begin
    case (wstate)
        WRIDLE:
            if (AWVALID)
                wnext = WRDATA;
            else
                wnext = WRIDLE;
        WRDATA:
            if (WVALID)
                wnext = WRRESP;
            else
                wnext = WRDATA;
        WRRESP:
            if (BREADY)
                wnext = WRIDLE;
            else
                wnext = WRRESP;
        default:
            wnext = WRIDLE;
    endcase
end

// waddr
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (aw_hs)
            waddr <= AWADDR[ADDR_BITS-1:0];
    end
end

//------------------------AXI read fsm-------------------
assign ARREADY = (rstate == RDIDLE);
assign RDATA   = rdata;
assign RRESP   = 2'b00;  // OKAY
assign RVALID  = (rstate == RDDATA);
assign ar_hs   = ARVALID & ARREADY;
assign raddr   = ARADDR[ADDR_BITS-1:0];

// rstate
always @(posedge ACLK) begin
    if (ARESET)
        rstate <= RDRESET;
    else if (ACLK_EN)
        rstate <= rnext;
end

// rnext
always @(*) begin
    case (rstate)
        RDIDLE:
            if (ARVALID)
                rnext = RDDATA;
            else
                rnext = RDIDLE;
        RDDATA:
            if (RREADY & RVALID)
                rnext = RDIDLE;
            else
                rnext = RDDATA;
        default:
            rnext = RDIDLE;
    endcase
end

// rdata
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (ar_hs) begin
            rdata <= 'b0;
            case (raddr)
                ADDR_DDR_SIZE_DATA_0: begin
                    rdata <= int_DDR_size[31:0];
                end
                ADDR_DDR_CONS_ADDR_DATA_0: begin
                    rdata <= int_DDR_cons_addr[31:0];
                end
                ADDR_DDR_CONS_ADDR_CTRL: begin
                    rdata[0] <= int_DDR_cons_addr_ap_vld;
                end
                ADDR_DDR_PROD_ADDR_DATA_0: begin
                    rdata <= int_DDR_prod_addr[31:0];
                end
                ADDR_DDR_READY_DATA_0: begin
                    rdata <= int_DDR_Ready[31:0];
                end
                ADDR_DDR_MASTER_DATA_0: begin
                    rdata <= int_DDR_Master[31:0];
                end
                ADDR_DDR_MASTER_DATA_1: begin
                    rdata <= int_DDR_Master[63:32];
                end
                ADDR_ADC_BUFFER_ERROR_I_DATA_0: begin
                    rdata <= int_ADC_buffer_error_i[0:0];
                end
                ADDR_ADC_BUFFER_ERROR_O_DATA_0: begin
                    rdata <= int_ADC_buffer_error_o[0:0];
                end
                ADDR_ADC_BUFFER_ERROR_O_CTRL: begin
                    rdata[0] <= int_ADC_buffer_error_o_ap_vld;
                end
            endcase
        end
    end
end


//------------------------Register logic-----------------
assign DDR_size           = int_DDR_size;
assign DDR_prod_addr      = int_DDR_prod_addr;
assign DDR_Ready          = int_DDR_Ready;
assign DDR_Master         = int_DDR_Master;
assign ADC_buffer_error_i = int_ADC_buffer_error_i;
// int_DDR_size[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_DDR_size[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_DDR_SIZE_DATA_0)
            int_DDR_size[31:0] <= (WDATA[31:0] & wmask) | (int_DDR_size[31:0] & ~wmask);
    end
end

// int_DDR_cons_addr
always @(posedge ACLK) begin
    if (ARESET)
        int_DDR_cons_addr <= 0;
    else if (ACLK_EN) begin
        if (DDR_cons_addr_ap_vld)
            int_DDR_cons_addr <= DDR_cons_addr;
    end
end

// int_DDR_cons_addr_ap_vld
always @(posedge ACLK) begin
    if (ARESET)
        int_DDR_cons_addr_ap_vld <= 1'b0;
    else if (ACLK_EN) begin
        if (DDR_cons_addr_ap_vld)
            int_DDR_cons_addr_ap_vld <= 1'b1;
        else if (ar_hs && raddr == ADDR_DDR_CONS_ADDR_CTRL)
            int_DDR_cons_addr_ap_vld <= 1'b0; // clear on read
    end
end

// int_DDR_prod_addr[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_DDR_prod_addr[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_DDR_PROD_ADDR_DATA_0)
            int_DDR_prod_addr[31:0] <= (WDATA[31:0] & wmask) | (int_DDR_prod_addr[31:0] & ~wmask);
    end
end

// int_DDR_Ready[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_DDR_Ready[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_DDR_READY_DATA_0)
            int_DDR_Ready[31:0] <= (WDATA[31:0] & wmask) | (int_DDR_Ready[31:0] & ~wmask);
    end
end

// int_DDR_Master[31:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_DDR_Master[31:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_DDR_MASTER_DATA_0)
            int_DDR_Master[31:0] <= (WDATA[31:0] & wmask) | (int_DDR_Master[31:0] & ~wmask);
    end
end

// int_DDR_Master[63:32]
always @(posedge ACLK) begin
    if (ARESET)
        int_DDR_Master[63:32] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_DDR_MASTER_DATA_1)
            int_DDR_Master[63:32] <= (WDATA[31:0] & wmask) | (int_DDR_Master[63:32] & ~wmask);
    end
end

// int_ADC_buffer_error_i[0:0]
always @(posedge ACLK) begin
    if (ARESET)
        int_ADC_buffer_error_i[0:0] <= 0;
    else if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_ADC_BUFFER_ERROR_I_DATA_0)
            int_ADC_buffer_error_i[0:0] <= (WDATA[31:0] & wmask) | (int_ADC_buffer_error_i[0:0] & ~wmask);
    end
end

// int_ADC_buffer_error_o
always @(posedge ACLK) begin
    if (ARESET)
        int_ADC_buffer_error_o <= 0;
    else if (ACLK_EN) begin
        if (ADC_buffer_error_o_ap_vld)
            int_ADC_buffer_error_o <= ADC_buffer_error_o;
    end
end

// int_ADC_buffer_error_o_ap_vld
always @(posedge ACLK) begin
    if (ARESET)
        int_ADC_buffer_error_o_ap_vld <= 1'b0;
    else if (ACLK_EN) begin
        if (ADC_buffer_error_o_ap_vld)
            int_ADC_buffer_error_o_ap_vld <= 1'b1;
        else if (ar_hs && raddr == ADDR_ADC_BUFFER_ERROR_O_CTRL)
            int_ADC_buffer_error_o_ap_vld <= 1'b0; // clear on read
    end
end


//------------------------Memory logic-------------------

endmodule
