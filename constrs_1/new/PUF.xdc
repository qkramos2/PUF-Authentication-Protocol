#Set location


# Clock Constraint

# Input/Output Standards
set_property PACKAGE_PIN W5 [get_ports CLK]
set_property IOSTANDARD LVCMOS33 [get_ports CLK]
create_clock -add -name sys_clk_pin -period 22222 -waveform {0 5} [get_ports CLK]


# Internal Signals
set_property PACKAGE_PIN V17 [get_ports EN]
set_property IOSTANDARD LVCMOS33 [get_ports EN]

set_property PACKAGE_PIN R2 [get_ports {Challenge[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Challenge[0]}]

set_property PACKAGE_PIN T1 [get_ports {Challenge[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Challenge[1]}]

set_property PACKAGE_PIN U1 [get_ports {Challenge[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Challenge[2]}]

set_property PACKAGE_PIN W2 [get_ports {Challenge[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Challenge[3]}]

set_property PACKAGE_PIN R3 [get_ports {Challenge[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Challenge[4]}]

set_property PACKAGE_PIN T2 [get_ports {Challenge[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Challenge[5]}]

set_property PACKAGE_PIN T3 [get_ports {Challenge[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Challenge[6]}]

set_property PACKAGE_PIN V2 [get_ports {Challenge[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Challenge[7]}]


set_property PACKAGE_PIN U16 [get_ports {Response[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Response[0]}]

set_property PACKAGE_PIN E19 [get_ports {Response[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Response[1]}]

set_property PACKAGE_PIN U19 [get_ports {Response[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Response[2]}]

set_property PACKAGE_PIN V19 [get_ports {Response[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Response[3]}]

set_property PACKAGE_PIN W18 [get_ports {Response[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Response[4]}]

set_property PACKAGE_PIN U15 [get_ports {Response[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Response[5]}]

set_property PACKAGE_PIN U14 [get_ports {Response[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Response[6]}]

set_property PACKAGE_PIN V14 [get_ports {Response[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Response[7]}]