
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity Test_MyRAM is
--  Port ( );
end Test_MyRAM;

architecture Behavioral of Test_MyRAM is
component Usa_RAM is
PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    douta : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    Mulo :  OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
end component;
signal Iclka: STD_LOGIC:='0';
signal Iena: STD_LOGIC;
signal Iwea: STD_LOGIC_VECTOR(0 DOWNTO 0);
signal Iaddra: STD_LOGIC_VECTOR(9 DOWNTO 0);
signal Idina: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal Odouta: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal OMulo:  STD_LOGIC_VECTOR(15 DOWNTO 0);
constant tclk : time:= 10ns;
constant mdepth : integer:= 1024;
constant naddr : integer:= 10;
constant ndata : integer:=16;
begin
 CUT: Usa_RAM port map (Iclka, Iena, Iwea, Iaddra, Idina, Odouta, OMulo);
 
 process
 begin
    wait for tclk/2;
    Iclka<= not Iclka;
 end process;
ACCMEM: process
begin
    wait for 100ns;
    wait until falling_edge(Iclka);
    Iena<='1';
    Iwea<=(others=>'1');
    for i in 0 to mdepth-1 loop
        Iaddra<= conv_std_logic_vector(i, naddr);
        Idina<= conv_std_logic_vector(i+256, ndata);
        wait for tclk;
    end loop;


wait for 10*tclk;

Iwea<=(others=>'0');
wait for 10*tclk;
for i in 0 to mdepth-1 loop
        Iaddra<= conv_std_logic_vector(i, naddr);
        wait for tclk;
end loop;
end process;

end Behavioral;
