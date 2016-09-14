library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use std.textio.all;

entity test is
end test;

architecture behavior of test is

-- ***** Uncomment the component that you want to simulate *****  

--  component mealy is
--    port (clk     : in  std_logic;
--           rst    : in  std_logic;
--           s_in   : in  std_logic;
--           d_out1 : out std_logic
--           );
--  end component;

--  component moore is
--    port (clk    : in  std_logic;
--          rst    : in  std_logic;
--          s_in   : in  std_logic;
--          d_out2 : out std_logic
--          );
--  end component;

  component CLOCKGENERATOR
    generic(clkhalfperiod : time);
    port(
      clk : out std_logic
      );
  end component;

  component FILE_READ
    generic (file_name : string; width : positive; datadelay : time);
    port(
      CLK, RESET : in  std_logic;
      Q          : out std_logic_vector(width-1 downto 0)
      );
  end component;


  --Inputs
  signal s_in : std_logic := '0';
  signal clk  : std_logic := '0';
  signal rst  : std_logic := '0';

  --Outputs
  signal d_out1 : std_logic;
  signal d_out2 : std_logic;

  --wires
  signal flag          : std_logic                      := '0';
  signal count         : std_logic_vector (3 downto 0)  := "0000";
  signal inputbus      : std_logic_vector (11 downto 0) := X"000";
  signal inputbus_temp : std_logic_vector (11 downto 0) := X"000";
  signal M1            : std_logic_vector (11 downto 0) := X"000";
  
begin
  
  rst <= '0' after 1 ns,
         '1' after 7500 ns;

  -- Instantiate the Unit Under Test (UUT)
  -- Uncomment the unit that currently is under test
  
  --uut1: mealy port map( 
  --clk      => clk,
  --rst      => rst,
  --s_in     => s_in,
  --d_out    => d_out1  
  --);
  
--  uut2 : moore
--    port map(
--      clk      => clk,
--      rst     => rst,
--      s_in     => s_in,
--      d_out    => d_out2
--      );


  -------------------------------------------------------------              
  -- Read data from a file every 12th clock cycle 
  -------------------------------------------------------------
  TESTGEN : file_read
    generic map (
      file_name => "C:\Users\Public\stimuli.txt",
      width     => 12, datadelay => 1 ns)
    port map(clk => flag, reset => rst, Q => inputbus);

  ------------------------------------------------------------- 
  -- Creating Clk of 200KHz
  -------------------------------------------------------------   
  CLOCKGEN : clockgenerator
    generic map (clkhalfperiod => 2500 ns)
    port map (clk              => clk);

  ------------------------------------------------------------- 
  -- Converting a 12-bit parallel data in to bit stream. 
  -------------------------------------------------------------          
  process (clk, rst)
  begin
    if rst = '0' then
      count <= (others => '0');
      flag  <= '0';
    elsif (clk = '0') and (clk'event) then
      if count < X"C" then
        count <= count + X"1";
        flag  <= '0';
      else
        count <= X"0";
        flag  <= '1';
      end if;
      inputbus_temp <= M1;
    end if;
    
  end process;

  M1   <= inputbus when flag = '1' else inputbus_temp(10 downto 0) & inputbus_temp(0);
  s_in <= inputbus_temp(11);


------------------------------------------------------------- 


end;
