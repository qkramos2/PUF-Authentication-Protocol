-- File for the Arbiter
-- Two one bit muxes feed into a Butterfly Puff Network



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Arbys is 
    port ( 
        in1, in0, in2, in3 : in std_logic;
        sel : in std_logic;
        out1, out2 : out std_logic
    );
end Arbys;

architecture ohBehave of Arbys is
    component Mux is
        port (
            sel : in std_logic;
            in1, in0 : in std_logic;
            res : out std_logic
        );
    end component;

    begin

    Inst_mux1 : mux port map (sel => sel, in1 => in1, in0 => in0, res => out1);
    Inst_mux2 : mux port map (sel => sel, in1 => in3, in0 => in2, res => out2);

end ohBehave;
