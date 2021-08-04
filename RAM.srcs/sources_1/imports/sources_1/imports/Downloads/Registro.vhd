
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Registro is
generic(nb:integer);
Port( D: in STD_LOGIC_VECTOR(nb-1 downto 0);
     clk: in STD_LOGIC;
     Q: out STD_LOGIC_VECTOR(nb-1 downto 0));
end Registro;

architecture Behavioral of Registro is

begin
    process(clk)
    begin
        if rising_edge(clk)then
          Q<=D;
        end if;
     end process;  
end Behavioral;
