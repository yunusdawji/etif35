library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
 
-- Uncomment the following library declaration if using -- arithmetic functions with Signed or Unsigned values'
use IEEE.NUMERIC_STD.ALL; 
 
entity my_counter is    
 Port ( start_count : in STD_LOGIC;            
 rst : in STD_LOGIC;            
 clk_in1 : in STD_LOGIC;           
  count_val : out unsigned (2 downto 0)); 
end my_counter; 
 
architecture Behavioral of my_counter is 
 
component clk_wiz_0 port  (
  -- Clock in ports  
  clk_in1           : in     std_logic;   
  -- Clock out ports  
  clk_out1          : out    std_logic;  
  clk_out2          : out    std_logic;  
  -- Status and control signals   
  reset             : in     std_logic;   
  locked            : out    std_logic  ); 
end component; 
 
signal  clk_out1    : std_logic;
signal  clk_out2    : std_logic; 
signal  locked      : std_logic; 
signal  local_count : unsigned (19 downto 0); 
signal  local_probe : std_logic_vector(7 downto 0); 
signal  local_count_val : std_logic_vector(3 downto 0); 
 
begin
 
my_clock_gen: clk_wiz_0
  port map (    
  -- Clock in ports   
  clk_in1 => clk_in1,  -- Clock out ports     
  clk_out1 => clk_out1,   
  clk_out2 => clk_out2,  -- Status and control signals                   
  reset => '0',   
  locked => locked ); 
 
process(clk_in1, rst)
begin   
    if(rst = '0') then
     local_count <= (others => '0');   
    elsif(rising_edge(clk_in1)) then     
     if(start_count = '1') then          
      local_count <= ((local_count) + 1);    
     else         
     local_count <= local_count;   
     end if;          
  end if; 
end process;    
   
   count_val <= local_count(2 downto 0) + local_count(19 downto 17); 
   local_count_val <= std_logic_vector(local_count(3 downto 0));      
    
end Behavioral;