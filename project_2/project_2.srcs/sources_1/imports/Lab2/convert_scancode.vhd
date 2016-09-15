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
    signal data_reg: std_logic_vector(9 downto 0);
    signal data_next: std_logic_vector(9 downto 0);
    signal data_reg1: std_logic_vector(9 downto 0);
    signal data_next1: std_logic_vector(9 downto 0);
    signal shift_count_up : std_logic;
    signal valid_code_reg : std_logic;
    signal valid_code_next : std_logic;
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

    -- sequential block
    process(clk, rst)
    begin
        if(rst = '1') then
            data_reg <= "0000000000";
        elsif (clk'event and clk = '1') then
            
            data_reg1 <= data_next1;
            valid_code_reg <= valid_code_next;
            
            -- when count is up, move the data out to reg
            if(shift_count_up = '1') then
                data_reg <= data_next;
            end if;
           
        end if;
    end process;

    -- process for shifting reg
    process(count)
    begin
        data_next1 <= serial_data & data_reg1(9 downto 1);
    end process;
    
    -- data reg for serial to parallel
    data_next <= data_next1;
    scan_code_out <= unsigned(data_reg(7 downto 0));
    
    -- reg for setting valid code next
    valid_code_next <= '1' when (shift_count_up='1' and edge_found='1') else '0';
    valid_scan_code <= valid_code_reg;
    
    
end convert_scancode_arch;
