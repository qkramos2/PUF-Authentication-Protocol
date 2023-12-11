-- D Flip FLop for the Butterly PUF Cell

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- D Flip Flop for BPUF
entity DFF is
    Port (  D : in  STD_LOGIC;          -- Data
            Pre : in  STD_LOGIC;        -- Preset
            CLR : in  STD_LOGIC;        -- Clear
            CLK : in  STD_LOGIC;        -- Clock
            Q : out  STD_LOGIC);        -- Output
end DFF;

architecture ohBehave of DFF is

--apply the attribute dont touch to Registers/internal signals

-- BPUF Flip Flop behavior
begin
    process(CLK)
    begin
        if (rising_edge(CLK)) then
            if (CLR = '1') then         -- Clear
                Q <= '0';
            elsif (Pre = '1') then      -- Preset
                Q <= '1';
            else
                Q <= D;                 -- D Flip Flop standard behavior
            end if;
        end if;
    end process;
end ohBehave;
