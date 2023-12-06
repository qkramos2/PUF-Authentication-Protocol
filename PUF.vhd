----------------------------------------------------------------------------------
-- Company: The Dynamic Duo Inc.
-- Engineer: Robbie Riviere
-- 
-- Create Date: 11/30/2023 10:32:14 PM
-- Design Name: HyBrid Arbiter Butterfly PUF
-- Module Name: Puf - Behavioral 
-- Target Devices: Basys 3 Artix-7 FPGA
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- use work.PUFPkg.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Puf is
  Port ( CLK : in std_logic;
         Challenge : in std_logic; --_vector(N-1 downto 0);
         EN : in std_logic;
         Response : out std_logic --_vector(N-1 downto 0)
  );
end Puf;

architecture ohBehave of Puf is

component Butterfly is 
  Port ( CLK : in std_logic;     -- Clock
         Pre : in std_logic;     -- Preset
         Clr : in std_logic;     -- Clear
         Q : out std_logic     -- Output
  );
end component;

component Arbys is 
  port ( in1, in0, in2, in3 : in std_logic;
         sel : in std_logic;
         out1, out2 : out std_logic);
end component;

component DFF is
port ( D : in  STD_LOGIC;               -- Data
            Pre : in  STD_LOGIC;        -- Preset
            CLR : in  STD_LOGIC;        -- Clear
            CLK : in  STD_LOGIC;        -- Clock
            Q : out  STD_LOGIC);        -- Output
end component;

-- 1st stage First Arbiter
signal enable : std_logic;    -- Enable bit; Goes to both inputs of the first arbiter
signal selTop : std_logic;    -- Select of first arbiter, will take N-1 Bit of challenge
signal ArbOut1 : std_logic;   -- Output of Mux1
signal ArbOut2 : std_logic;   -- Output of Mux2
 
-- 2nd stage
signal Butterfly_out : std_logic;

-- 3rd stage
signal ArbOut3 : std_logic;   -- Output of Mux3
signal ArbOut4 : std_logic;   -- Output of Mux4
signal selBot : std_logic;    -- Select of second arbiter, will take Butterfly_out

begin

selTop <= Challenge; -- Select of first arbiter, will take N-1 Bit of challenge
selBot <= Butterfly_out; -- Select of second arbiter, will take Butterfly_out
ArbiterL1_inst: Arbys port map (in0 => EN, in1 => EN, in2 => EN, in3 => EN, sel => selTop, out1 => ArbOut1, out2 => ArbOut2);
Butterfly_inst: Butterfly port map (CLK => CLK, Pre => ArbOut2, Clr => ArbOut1, Q => Butterfly_out);  
ArbiterL2_inst: Arbys port map (in0 => ArbOut1, in1 => ArbOut2, in2 => ArbOut2, in3 => Arbout1, sel => selBot, out1 => ArbOut3, out2 => ArbOut4);
DFF_inst: DFF port map ( D => ArbOut4, CLK => ArbOut3, Pre => '0', CLR => '0', Q => Response);

end ohBehave;
