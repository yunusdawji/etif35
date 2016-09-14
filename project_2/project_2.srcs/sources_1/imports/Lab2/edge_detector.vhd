-------------------------------------------------------------------------------
-- Title      : edge_detector.vhd 
-- Project    : Keyboard VLSI Lab
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Description: 
-- 		        Make sure not to use 'EVENT on anyother signals than clk
-- 		        
--
-------------------------------------------------------------------------------

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity edge_detector is
    port (
	     clk : in std_logic;
	     rst : in std_logic;
	     kb_clk_sync : in std_logic;
	     edge_found : out std_logic
	 );
end edge_detector;

architecture edge_detector_arch of edge_detector is
    type state_type is (st0,st1);
    signal local_edge_found : std_logic; 
    signal reg_wire : std_logic;
    signal last_state : state_type;
    signal triggered : std_logic;
begin

    --sequential block
    process(clk, rst)
    begin
        if (rst = '1') then
            reg_wire <= '0';
            triggered <= '0';
        elsif (clk'event and clk = '1') then
            triggered <= not(triggered);
            reg_wire <= local_edge_found;
         end if;
    end process;

    --combinational block
    process(kb_clk_sync)
    begin        
       if(kb_clk_sync = '1') then           
           last_state <= st1;
       else
           last_state <= st0;
       end if;
    end process;
    
    --combinational block
    process(triggered)
    begin        
       if(last_state = st0) then
           local_edge_found <= '0';            
       else
           local_edge_found <= not(triggered);
       end if;
    end process;
    
    edge_found <= reg_wire;

end edge_detector_arch;
