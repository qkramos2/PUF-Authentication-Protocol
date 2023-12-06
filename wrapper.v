`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2023 12:44:45 AM
// Design Name: 
// Module Name: wrapper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module wrapper(
        in_val, 
        out_val
    );
    
input  [7:0] in_val; 
output [7:0] out_val;

ArbiterPUF wrap(

in_val[7],

in_val[6],

in_val[5],

in_val[4],

in_val[3],

in_val[2],

in_val[1],

in_val[0],


out_val[7],

out_val[6],

out_val[5],

out_val[4],

out_val[3],

out_val[2],

out_val[1],

out_val[0]

);


endmodule
