library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_top is
	port (
		ADC_CLK_10 : in std_logic;
		MAX10_CLK1_50 : in std_logic;
		MAX10_CLK2_50 : in std_logic;
		KEY : in std_logic_vector(1 downto 0);
		LEDR : out std_logic_vector(9 downto 0)
	);
end;

architecture behavorial of counter_top is

component counter
	port (
		clk : in std_logic;
		rst_l : in std_logic;
		output : out std_logic_vector(9 downto 0)
	);
end component;

begin
	u0 : counter
		port map (
			clk => MAX10_CLK1_50,
			rst_l => key(0),
			output => LEDR
		)
end;