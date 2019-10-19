library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity deltasigma is
	generic (
		width: integer :=8
   );
	Port ( inval : in  STD_LOGIC_VECTOR (width-1 downto 0);
           output : out  STD_LOGIC;
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC);
end deltasigma;

architecture Behavioral of deltasigma is
signal reg: STD_LOGIC_VECTOR(width+1 downto 0);
signal reg_d: STD_LOGIC_VECTOR(width+1 downto 0);
signal ddcout: STD_LOGIC_VECTOR(width+1 downto 0);

begin
ds: process(clk, reset)
begin
	if reset='1' then
		reg<=(others => '0');
		output<='0';
	elsif rising_edge(clk) then
		reg<=reg_d;
		output<=reg(width);
	end if;
end process;
ddcout(width+1 downto width)<="00";
ddcout(width-1 downto 0)<=(others=>'1') when reg(width)='1' else (others => '0');
reg_d<=(("00"&inval)-ddcout)+reg;
end Behavioral;

