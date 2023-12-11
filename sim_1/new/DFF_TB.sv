`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Dynamic Duo INC
// Engineer: Robbie Riviere
// 
// Create Date: 12/05/2023 11:14:10 PM
// Design Name: 
// Module Name: DFF_TB
// Project Name: CMPE 361 Project 2
// Target Devices: Baysys 3
// Tool Versions: 
// Description: 
//      Testbench for DFF 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DFF_TB(
    input reg clk,              // Clock
    input reg CLR,              // Reset
    input reg Pre,              // Preset
    input reg d,                // Data
    output reg q            //Output of DFF
    );

    // Instantiate DFF
    DFF DFF0(
        .clk(clk),
        .CLR(CLR),
        .Pre(Pre),
        .d(d),
        .q(q)
    );

    // Clock Generation
    always begin            // start of infinite loop
        clk = 1'b0;
        #100 clk = 1'b1;      // 5ns clock high
        #100 clk = 1'b0;      // 5ns clock low
    end


    // Data Generation
    always begin            // start of infinite loop
        d = 1'b0;
        Pre = 1'b0;         // 0ns preset low
        CLR = 1'b1;         // 0ns reset low
        #45 CLR = 1'b0;
        #50 d = 1'b1;       // 15ns data high
        #150 d = 1'b0;       // 15ns data low

        #170 Pre = 1'b1;     // 30ns preset high
        
        #250 Pre = 1'b0;
        #300 CLR = 1'b1;       // 45ns CLR high
        
        
        
        
        
    end

    // Output Display\
    always @(posedge clk) begin
        $display("DFF Output: %b", q);
    end



endmodule