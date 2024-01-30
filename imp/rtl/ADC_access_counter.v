/*
* Author: Ruben Rodriguez Alvarez - ruben.rodriguezalvarez@epfl.ch
*/

module adc_access_counter #
(
    parameter integer ADC_BITS = 10,
    parameter integer BRAM_ADDR_BITS = 32
)(
    // Clock and reset
    input wire clk,
    input wire reset,

    // Virtual ADC producer and consumer
    input wire [ADC_BITS-1:0] ADC_buffer_prod_in,
    output wire [ADC_BITS-1:0] ADC_buffer_cons_out,

    // BRAM port
    input wire [BRAM_ADDR_BITS-1 : 0] bram_addr,
    input wire en,
    input wire [3 : 0] we
);

    reg [ADC_BITS-1:0] ADC_buffer_cons_reg;

    assign ADC_buffer_cons_out = ADC_buffer_cons_reg;

    // Update consumer address
    always @( posedge clk )
    begin
    if ( reset == 1'b0 )
        begin
            ADC_buffer_cons_reg = 0;
        end
    else
        begin
        if (en && (we == 4'b0000))
            begin
                ADC_buffer_cons_reg <= bram_addr[ADC_BITS+1:2]; // It is supposed to be +1, but this wy we have an extra security
            end
        end
    end

endmodule