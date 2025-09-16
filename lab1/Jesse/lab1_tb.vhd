library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab1_tb is
end entity;

architecture test of lab1_tb is
  signal clk           : std_logic := '0';
  signal rst_l         : std_logic := '1';                 -- start not in reset
  signal binary_output : std_logic_vector(9 downto 0);

  constant CLK_PERIOD : time := 20 ns;                    -- 50 MHz

begin
  -- DUT instantiation (direct entity form; no component needed)
  uut : entity work.counter
    port map (
      clk           => clk,
      rst_l         => rst_l,
      binary_output => binary_output
    );

  -- 50 MHz clock
  clk_process : process
  begin
    clk <= '0'; wait for CLK_PERIOD/2;
    clk <= '1'; wait for CLK_PERIOD/2;
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