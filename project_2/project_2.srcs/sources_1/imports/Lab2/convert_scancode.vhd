-------------------------------------------------------------------------------
-- Title      : convert_scancode.vhd 
-- Project    : Keyboard VLSI Lab
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Description: 
-- 		        Implement a shift register to convert serial to parallel
-- 		        A counter to flag when the valid code is shifted in
--
-------------------------------------------------------------------------------

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity convert_scancode is
    port (
	     clk : in std_logic;
	     rst : in std_logic;
	     edge_found : in std_logic;
	     serial_data : in std_logic;
	     valid_scan_code : out std_logic;
	     scan_code_out : out unsigned(7 downto 0)
	 );
end convert_scancode;

architecture convert_scancode_arch of convert_scancode is
    signal count: std_logic_vector(3 downto 0);
    signal data: std_logic_vector(7 downto 0);
    signal data_reg: std_logic_vector(9 downto 0);
    signal data_next: std_logic_vector(9 downto 0);
    signal shift_count_up : std_logic;
    component counter is
      port ( 
        clk : in std_logic;
        enable : in std_logic;
        reset : in std_logic;
        count_up : out std_logic;
        count: out std_logic_vector (3 downto 0)
      );
    end component;
begin

    counter_1_inst : counter 
    port map (
		 clk => clk,
            enable => edge_found,
            reset => rst,
            count_up => shift_count_up,
            count => count
	     );

    process(clk, rst)
    begin
        if(rst = '1') then
         --   counter <= "0000";
         --   scan_code_out <= "00000000";
            data_reg <= "0000000000";
        elsif (clk'event and clk = '1') then
            if(shift_count_up = '1') then
                data_reg <= data_next;
            else
                data_reg <= data_next;
            end if;
            
            --data_reg <= serial_data & data_reg(data_reg'left - 1 downto 0);
        end if;
    end process;

    process(count)
    begin
       --if(shift_count_up = '1') then
            -- do shift once more because we only count till 10
            data_next <= serial_data & data_reg(9 downto 1);
       --else
       --     data_reg <= serial_data & data_reg(data_reg'left - 1 downto 0);
       --end if;
    end process;
    
    --shift_count_up <= count
    
    scan_code_out <= unsigned(data_reg(7 downto 0));
    --data <= data_reg(7 downto 0);
    


end convert_scancode_arch;
