library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
entity Usa_RAM is
PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    douta : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    Mulo :  OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
end Usa_RAM;

architecture Behavioral of Usa_RAM is
component blk_mem_gen_0 IS
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END component;
  
  component Mul is
   generic( nb: integer:=8);
   Port ( A: in STD_LOGIC_VECTOR(nb-1 downto 0);
          B: in STD_LOGIC_VECTOR(nb-1 downto 0);
          clk: in STD_LOGIC;
          S: out STD_LOGIC_VECTOR(nb*2-1 downto 0));
  end component;

component Registro is
generic(nb:integer:=16);
Port( D: in STD_LOGIC_VECTOR(nb-1 downto 0);
     clk: in STD_LOGIC;
     Q: out STD_LOGIC_VECTOR(nb-1 downto 0));
end component;

Signal IA,IB : STD_LOGIC_VECTOR(7 downto 0);
signal prod: STD_LOGIC_VECTOR(15 DOWNTO 0);

begin
 MEM : blk_mem_gen_0 port map (clka, ena, wea,addra, dina, douta);
 test: Mul port map(IA,IB,clka,prod);
 finale: registro port map(prod, clka, Mulo);
 process(clka)
 begin
    if rising_edge(clka) then
       IA<=douta(15 downto 8);
       IB<=douta(7 downto 0);
    end if;
 end process;
end Behavioral;
