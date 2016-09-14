library IEEE; use IEEE.STD_LOGIC_1164.ALL; 
 
-- Uncomment the following library declaration if using -- arithmetic functions with Signed or Unsigned values 
use IEEE.NUMERIC_STD.ALL; 
 
-- Uncomment the following library declaration if instantiating -- any Xilinx leaf cells in this code. 
--library UNISIM; 
--use UNISIM.VComponents.all; 
 
entity counter_testbench is
 --  Port ( );
  end counter_testbench; 
 
architecture Behavioral of counter_testbench is 
 
component my_counter    
 Port ( start_count : in STD_LOGIC;           
  rst : in STD_LOGIC;            
  clk_in1 : in STD_LOGIC;            
  count_val : out unsigned (2 downto 0)); 
 end component; 
 
signal start_count_tb   : std_logic; 
signal rst_tb           : std_logic; 
signal clk_in_tb        : std_logic := '0'; 
signal count_val_tb     : unsigned(2 downto 0); 
constant clk_period     : time := 2.5ns; 
constant delay_val      : time := 10ns; 
 
begin 
 
my_counter_inst : my_counter 
port map(   start_count => start_count_tb,     
            rst => rst_tb,     
            clk_in1 => clk_in_tb,     
            count_val => count_val_tb); 
 
clk_in_tb           <= not clk_in_tb after clk_period; 
 
rst_tb              <= '0' after delay_val,'1' after 1500*delay_val; 
start_count_tb      <= '0' after delay_val, '1' after 2000*delay_val; 
 
end Behavioral; 