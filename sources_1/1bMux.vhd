----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2023 11:25:14 AM
-- Design Name: 
-- Module Name: 1bMux - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux is
    Port ( in0 : in STD_LOGIC;
           in1 : in STD_LOGIC;
           sel : in STD_LOGIC;
           res : out STD_LOGIC );
end Mux;

architecture ohBehave of Mux is

begin
    MuxProc: process(in0, in1, sel)
    begin
        if sel = '0' then
            res <= in0;
        else
            res <= in1;
        end if;
    end process MuxProc;
end ohBehave;
