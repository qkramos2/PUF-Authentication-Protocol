--Generic Definitions for PUF

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package PUFPkg is
     constant N : positive := 8;            --PUF challenge size
    constant M : positive := 8;            --PUF Response size
end PUFPkg;
