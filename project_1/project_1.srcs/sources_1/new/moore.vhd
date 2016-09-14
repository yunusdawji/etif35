library ieee;
use ieee.std_logic_1164.all; 

entity moore is 
 port (  clk : in std_logic;  
rst : in std_logic;  
s_in : in std_logic; 
 d_out : out std_logic);
 end moore;
 




architecture sequence_decoder_arch  of moore is 

-- Define a enumeration type for the states
type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12 ); 
-- Define the needed internal signals 
signal current_state, next_state : state_type;

begin -- sequence_decoder_arch 
 -- purpose: Implements the registers for the sequence decoder 
 -- type : sequential 
-- inputs : clk, rst, next_state 
-- outputs: current_state 
reg: process (clk, rst) -- The register process 
begin -- process register 
if rst = '0' then -- asynchronous reset (active high) 
    current_state <= s0; 
elsif clk'event and clk = '1' then -- rising clock edge
    current_state <= next_state; 
end if; 
end process ; 

-- purpose: Implements the next_state logic as well as the output logic 
-- type : combinational 
-- inputs : d_in, current_state 
-- outputs: next_state, d_out 
comb: process (s_in, current_state) -- The combinational process 
begin -- process combinational 

-- set default value 
d_out <= '0'; 
next_state <= current_state; 

-- next-state logic 
case current_state is 
when s0 => 
    if s_in = '0' then 
        next_state <= s0; 
    else 
        next_state <= s1; 
    end if; 
when s1 => 
    if s_in = '0' then
        next_state <= s2;
    else
        next_state <= s1;
    end if;
when s2 => 
    if s_in = '0' then
        next_state <= s0;
    else
        next_state <= s3;
    end if;
when s3 => 
        if s_in = '0' then 
            next_state <= s4; 
        else 
            next_state <= s1; 
        end if; 
when s4 => 
    if s_in = '0' then
        next_state <= s0;
    else
        next_state <= s5;
    end if;
when s5 => 
    if s_in = '0' then
        next_state <= s4;
    else
        next_state <= s6;
    end if;    
when s6 => 
    if s_in = '0' then 
        next_state <= s2; 
    else 
        next_state <= s7; 
    end if; 
when s7 => 
    if s_in = '0' then
        next_state <= s2;
    else
        next_state <= s8;
    end if;
when s8 => 
    if s_in = '0' then
        next_state <= s2;
    else
        next_state <= s9;
    end if;
when s9 => 
        if s_in = '0' then 
            next_state <= s10; 
        else 
            next_state <= s1; 
        end if; 
when s10 => 
    if s_in = '0' then
        next_state <= s11;
    else
        next_state <= s3;
    end if;
when s11 => 
    if s_in = '0' then
        next_state <= s0;
    else
        next_state <= s12;
    end if;
when s12 => 
    if s_in = '0' then
        next_state <= s2;
    else
        next_state <= s1;
    end if;
--??? 
--??? 
when others =>
    next_state <= s0; 

end case; 

if( current_state = s12) then
    d_out <= '1';
else
    d_out <= '0';
end if;

end process; 


end sequence_decoder_arch ;