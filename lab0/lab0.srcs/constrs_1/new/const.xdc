set_property PACKAGE_PIN E3 [get_ports clk_in1]        
set_property IOSTANDARD LVCMOS33 [get_ports clk_in1] 
#create_clock -add -name clk_in1 -period 10.00 -waveform {0 5} [get_ports clk_board] 
 
set_property PACKAGE_PIN C12 [get_ports {rst}] 
set_property IOSTANDARD LVCMOS33 [get_ports {rst}] 
 
set_property PACKAGE_PIN U9 [get_ports {start_count}] 
set_property IOSTANDARD LVCMOS33 [get_ports {start_count}] 
# LED 0 
set_property PACKAGE_PIN T8 [get_ports {count_val[0]}]     
set_property IOSTANDARD LVCMOS33 [get_ports {count_val[0]}] 
# LED 1  
set_property PACKAGE_PIN V9 [get_ports {count_val[1]}]      
set_property IOSTANDARD LVCMOS33 [get_ports {count_val[1]}] 
# LED 2 
set_property PACKAGE_PIN R8 [get_ports {count_val[2]}]      
set_property IOSTANDARD LVCMOS33 [get_ports {count_val[2]}] 
         
set_property CFGBVS Vcco [current_design] 
set_property config_voltage 3.3 [current_design]