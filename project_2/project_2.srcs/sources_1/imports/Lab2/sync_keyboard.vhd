-------------------------------------------------------------------------------
-- Title      : sync_keyboard.vhd 
-- Project    : Keyboard VLSI Lab
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Description: 
-- 		
-- 		
--		
--
--
--
-------------------------------------------------------------------------------

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity sync_keyboard is
    port (
	     clk : in std_logic; 
	     kb_clk : in std_logic;
	     kb_data : in std_logic;
	     kb_clk_sync : out std_logic;
	     kb_data_sync : out std_logic
	 );
end sync_keyboard;


architecture sync_keyboard_arch of sync_keyboard is

signal kb_clk_sync_ff : std_logic;
signal kb_data_sync_ff : std_logic;
begin

    process(clk)
    begin
	if (clk'event and clk = '1') then
	    kb_clk_sync_ff <= kb_clk;
	    kb_clk_sync <= kb_clk_sync_ff;
		kb_data_sync_ff <= kb_data;
	    kb_data_sync <= kb_data_sync_ff;
	end if;
    end process;

end sync_keyboard_arch;
