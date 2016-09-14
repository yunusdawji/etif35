----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/13/2016 03:41:51 PM
-- Design Name: 
-- Module Name: counter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
  port ( 
    clk : in std_logic;
    enable : in std_logic;
    reset : in std_logic;
    count_up : out std_logic;
    count: out std_logic_vector (3 downto 0)
  );
end counter;

architecture Behavioral of counter is

    signal r_reg : unsigned( 3 downto 0);
    signal r_next : unsigned (3 downto 0);
    --signal count : unsigned (3 downto 0);
begin
    process(clk , reset)
    begin
        if(reset = '1') then
            r_reg <= "0000";
        elsif (clk'event and clk = '1') then
            if(enable = '1') then
                r_reg <= r_next;
            end if;
        end if;
    end process;

    --r_next <= (others=>"0000") when (r_reg= "1010") else r_reg+1;
    r_next <= (others=>'0') when (r_reg=10) else r_reg+1;
    count_up <= '1' when r_reg = "1010" else '0';
    count <= std_logic_vector(r_reg);
    
end Behavioral;
