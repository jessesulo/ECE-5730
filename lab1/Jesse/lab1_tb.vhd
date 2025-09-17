library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab1_tb is
end lab1_tb;

architecture test of lab1_tb is
	component counter is
		port (
			clk : in  std_logic;
			rst_l : in  std_logic;
			binary_output : out std_logic_vector(9 downto 0)
		);
	end component counter;

	signal clk : std_logic;
	signal rst_l : std_logic;
	signal binary_output : std_logic_vector(9 downto 0);

	constant CLK_PERIOD : time := 10 ns; -- 50mhz

begin
	uut : entity work.counter
    port map (
      clk => clk,
      rst_l => rst_l,
      binary_output => binary_output
    );

  clk_process : process
  begin
    clk <= '0'; wait for CLK_PERIOD;
    clk <= '1'; wait for CLK_PERIOD;
  end process;

  stim_process : process
  begin
    rst_l <= '0';
    wait for 5*CLK_PERIOD;
    rst_l <= '1';
    wait for 2000 ms;
    wait;
  end process;

end architecture;