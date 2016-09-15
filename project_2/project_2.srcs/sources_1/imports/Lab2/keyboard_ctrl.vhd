-------------------------------------------------------------------------------
-- Title      : keyboard_ctrl.vhd 
-- Project    : Keyboard VLSI Lab
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Description: 
-- 		        controller to handle the scan codes 
-- 		        
--
-------------------------------------------------------------------------------

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;


entity keyboard_ctrl is
    port (
	     clk : in std_logic; 
	     rst : in std_logic;
	     valid_code : in std_logic;
	     scan_code_in : in unsigned(7 downto 0);
	     code_to_display : out unsigned(7 downto 0);
	     seg_en : out unsigned(3 downto 0)
	 );
end keyboard_ctrl;

architecture keyboard_ctrl_arch of keyboard_ctrl is

type key_state is (F0, waiting_for_F0, F1);
signal current_state : key_state;
signal next_state : key_state;
begin
    process(clk, rst)
    begin
        if(rst='1') then
            --do something
            
        elsif(clk'event and clk = '1') then
            
        end if;
    end process;
    
    process(valid_code)
    begin
        case current_state is
        --when F0 =>
        --    reg_0 <= scan_code_in;
        --    current_state <= waiting_for_F0;
        when waiting_for_F0 =>
            if(scan_code_in = X"F0") then
                next_state <= F1;
            end if;
        when F1 =>
            --reg_1 <= scan_code_in;
            next_state <= waiting_for_F0;
        when others =>
            next_state <= waiting_for_F0;
        end case;
        
        
        --data_next1 <= serial_data & data_reg1(9 downto 1);
    end process;
end keyboard_ctrl_arch;
