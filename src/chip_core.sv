// SPDX-FileCopyrightText: © 2025 XXX Authors
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

module chip_core #(
    parameter NUM_INPUT_PADS,
    parameter NUM_OUTPUT_PADS,
    parameter NUM_BIDIR_PADS,
    parameter NUM_ANALOG_PADS
    )(
    input  logic clk,       // clock
    input  logic rst_n,     // reset (active low)
    
    input  wire [NUM_INPUT_PADS-1 :0] input_in,   // Input value
    output wire [NUM_OUTPUT_PADS-1:0] output_out, // Output value
    input  wire [NUM_BIDIR_PADS-1 :0] bidir_in,   // Input value
    output wire [NUM_BIDIR_PADS-1 :0] bidir_out,  // Output value
    output wire [NUM_BIDIR_PADS-1 :0] bidir_oe,   // Output enable
    inout  wire [NUM_ANALOG_PADS-1:0] analog      // Analog
);

    // Set all bidir as output
    assign bidir_oe = '1;

    logic _unused;
    assign _unused = &bidir_in;

    logic [NUM_BIDIR_PADS-1:0] count;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            count <= '0;
        end else begin
            if (&input_in) begin
                count <= count + 1;
            end
        end
    end
    
    assign bidir_out  = count;
    assign output_out = count;

endmodule

`default_nettype wire
