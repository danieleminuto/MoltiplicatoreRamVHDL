
library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;


entity RegAdder is
    generic (nb: integer:=16);
    Port ( A : in STD_LOGIC_VECTOR (nb-1 downto 0);
           B : in STD_LOGIC_VECTOR (nb-1 downto 0);
           Cin: in STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (nb-1 downto 0));
end RegAdder;

architecture Behavioral of RegAdder is
signal p,g : STD_LOGIC_VECTOR (nb-1 downto 0);
Signal C: STD_LOGIC_VECTOR (nb downto 0);
begin

p<=A xor B;
g<=A and B;
C(0)<=Cin;
C(nb downto 1)<= (p and C(nb-1 downto 0)) xor g;
Sum<=p xor C(nb-1 downto 0);




end Behavioral;
