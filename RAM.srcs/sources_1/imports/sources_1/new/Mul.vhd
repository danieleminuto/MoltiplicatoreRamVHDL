library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity Mul is
 generic( nb: integer:=8);
 Port ( A: in STD_LOGIC_VECTOR(nb-1 downto 0);
        B: in STD_LOGIC_VECTOR(nb-1 downto 0);
        clk: in STD_LOGIC;
        S: out STD_LOGIC_VECTOR(nb*2-1 downto 0));
        
end Mul;

architecture Behavioral of Mul is
component Registro is
generic (nb: integer:=16);
Port( D: in STD_LOGIC_VECTOR(nb-1 downto 0);
     clk: in STD_LOGIC;
     Q: out STD_LOGIC_VECTOR(nb-1 downto 0));
end component;

component RegAdder is
    generic (nb: integer:=16);
    Port ( A : in STD_LOGIC_VECTOR (nb-1 downto 0);
           B : in STD_LOGIC_VECTOR (nb-1 downto 0);
           Cin: in STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (nb-1 downto 0));
end component;

type sommaP is Array(natural range<>) of STD_LOGIC_VECTOR(nb*2-1 downto 0);
type moltiplicatore is Array(natural range<>) of STD_LOGIC_VECTOR(nb-1 downto 0);

--Signal  mAnd : STD_LOGIC_VECTOR(nb-1 downto 0);
Signal somP: sommaP(nb-1 downto 0);
signal sp0,sp1,sp2,sp3,sp4,sp5,sp6,sp7,s1,s2,s3,s4,ss1,ss2,sss:STD_LOGIC_VECTOR(nb*2-1 downto 0);
signal sl1,sl2,sl3,sl4,sll1,sll2,slll:STD_LOGIC_VECTOR(nb*2-1 downto 0);
signal moltB: moltiplicatore(nb-1 downto 0); --è diverso rispetto ad usare un vector perchè non soffre di conflitti

begin
ciclo: for i in 0 to nb-1 generate
     moltB(i)<=(others=>(B(i)));
     somP(i)(nb-1+i downto i)<=A and moltB(i);
     somP(i)(nb*2-1 downto nb+i)<=(others=>'0');
     somP(i)(i-1 downto 0)<=(others=>'0');
end generate;

--abbiamo tutte le somme parziali
reg0: registro port map(somP(0),clk,sp0);
reg1: registro port map(somP(1),clk,sp1);
reg2: registro port map(somP(2),clk,sp2);
reg3: registro port map(somP(3),clk,sp3);
reg4: registro port map(somP(4),clk,sp4);
reg5: registro port map(somP(5),clk,sp5);
reg6: registro port map(somP(6),clk,sp6);
reg7: registro port map(somP(7),clk,sp7);

--- primo livello albero di somma:
sum1: regAdder port map(sp0,sp1,'0',sl1);
regs1: registro port map(sl1,clk,s1);

sum2: regAdder port map(sp2,sp3,'0',sl2);
regs2: registro port map(sl2,clk,s2);

sum3: regAdder port map(sp4,sp5,'0',sl3);
regs3: registro port map(sl3,clk,s3);

sum4: regAdder port map(sp6,sp7,'0',sl4);
regs4: registro port map(sl4,clk,s4);

--- secondo livello albero di somma:
suml1: regAdder port map(s1,s2,'0',sLL1);
regsl1: registro port map(sLL1,clk,ss1);

suml2: regAdder port map(s3,s4,'0',sll2);
regsl2: registro port map(sll2,clk,ss2);

--- risultato:

SommaRis: regAdder port map(ss1,ss2,'0',sLLL);
RegRis: registro port map(sLLL,clk,S);

end Behavioral;
