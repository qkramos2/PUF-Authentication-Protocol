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
use IEEE.NUMERIC_STD.ALL;
use work.PUFPkg.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Puf is
  Port ( CLK : in std_logic;
         Challenge : in std_logic_vector(N-1 downto 0); 
         EN : in std_logic;
         Response : out std_logic_vector(M-1 downto 0) 
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

type multiarray is array (M-1 downto 0) of std_logic_vector(N-2 downto 0);
-- 1st stage First Arbiter
signal ArbOut1 : multiarray := (others => (others => '0'));   -- Output of Mux1
signal ArbOut2 : multiarray := (others => (others => '0'));   -- Output of Mux2
 
-- 2nd stage
signal Butterfly_out : multiarray := (others => (others => '0'));

-- 3rd stage
signal ArbOut3 : multiarray := (others => (others => '0'));   -- Output of Mux3
signal ArbOut4 : multiarray := (others => (others => '0'));   -- Output of Mux4


--apply the attribute dont touch to Registers/internal signals
attribute dont_touch : boolean;
attribute dont_touch of EN, Challenge, ArbOut1, ArbOut2, ArbOut3, ArbOut4, Butterfly_out : signal is true;
attribute dont_touch of Butterfly, DFF, Arbys : component is true;



begin

-- Create N layers of Arbiter-Butterfly-Arbiter layers
-- This design is using an n bit challenge chain for M (1) bit response
-- The entire PUF will need to be repeated M times to get M bits of response

Puf_Gen: for j in 0 to M-1 generate
    Chain_Gen: for i in 0 to N-1 generate  
      First_ChainLink: if (i = 0 ) generate
        ArbiterL1_inst: Arbys port map (in0 => EN, in1 => EN, in2 => EN, in3 => EN, sel => Challenge(i), out1 => ArbOut1(j)(i), out2 => ArbOut2(j)(i));
        Butterfly_inst: Butterfly port map (CLK => CLK, Pre => ArbOut2(j)(i), Clr => ArbOut1(j)(i), Q => Butterfly_out(j)(i));  
        ArbiterL2_inst: Arbys port map (in0 => ArbOut1(j)(i), in1 => ArbOut2(j)(i), in2 => ArbOut2(j)(i), in3 => Arbout1(j)(i), sel => Butterfly_out(j)(i), out1 => ArbOut3(j)(i), out2 => ArbOut4(j)(i));
      end generate;
    
      Middle_arbiters: if ((i > 0) and (i < N-1)) generate
        MidArbsL1_inst: Arbys port map (in0 => ArbOut3(j)(i-1), in1 => ArbOut4(j)(i-1), in2 => ArbOut4(j)(i-1), in3 => ArbOut3(j)(i-1), sel => Challenge(i), out1 => ArbOut1(j)(i), out2 => ArbOut2(j)(i));
        MidBfly_inst: Butterfly port map (CLK => CLK, Pre => ArbOut2(j)(i), Clr => ArbOut1(j)(i), Q => Butterfly_out(j)(i));
        MidArbsL2_inst: Arbys port map (in0 => ArbOut1(j)(i), in1 => ArbOut2(j)(i), in2 => ArbOut2(j)(i), in3 => ArbOut1(j)(i), sel => Butterfly_out(j)(i), out1 => ArbOut3(j)(i), out2 => ArbOut4(j)(i));
      end generate;
      
      Last_Stage: if ( i = N-1) generate 
      DFF_inst: DFF port map ( D => ArbOut4(j)(i-1), CLK => ArbOut3(j)(i-1), Pre => '0', CLR => '0', Q => Response(j));
      end generate;
    end generate;
   end generate; 



end ohBehave;
