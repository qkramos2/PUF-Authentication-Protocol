----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2023 12:43:44 PM
-- Design Name: 
-- Module Name: Butterfly - Behavioral
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

entity Butterfly is
  Port ( CLK : in std_logic;     -- Clock
         Pre : in std_logic;     -- Preset
         Clr : in std_logic;     -- Clear
         Q : out std_logic     -- Output

   );
end Butterfly;

architecture Behavioral of Butterfly is
--DFF 1
signal Q1 : std_logic;
signal D1 : std_logic;
signal Pre1 : std_logic := '0';
signal Clr1 : std_logic;

--DFF 2
signal Q2 : std_logic;
signal D2 : std_logic;
signal Pre2 : std_logic;
signal Clr2 : std_logic := '0';

component DFF
port (CLK, Pre, Clr, D : in std_logic;
Q : out std_logic);
end component;

--apply the attribute dont touch to Registers/internal signals
attribute dont_touch : boolean;
attribute dont_touch of Q1,Q : signal is true;


begin
Pre2 <= Pre;
Clr1 <= Clr;

process (CLK, Pre, Clr)
begin
 if (rising_edge(CLK)) then        -- Cross coupled latch
    D2 <= Q1;                       -- D2 = Q1
    D1 <= Q2;                       -- D1 = Q2
    Q <= Q1;                        -- Q = Q1
 end if;
end process;


--DFF 1
DFF1_inst: DFF port map (CLK => CLK, Pre => Pre1, Clr => Clr1, D => D1, Q => Q1);

--DFF 2
DFF2_inst: DFF port map (CLK => CLK, Pre => Pre2, Clr => Clr2, D => D2, Q => Q2);

end Behavioral;
