library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab10BitCounterTB is
end entity;

architecture behavior of lab10BitCounterTB is
	signal clk     : std_logic := '0';
	signal rst     : std_logic := '0';
	signal leds    : std_logic_vector(9 downto 0);
begin
	-- set up stuff
	uut: entity work.lab10BitCounter
		port map (
			clk  => clk,
         rst  => rst,
         leds => leds
      );
		
	-- clock logic
	clockProcess : process
	begin
		while now < 3 sec loop
			clk <= '0';
			wait for 0.5 sec;
			clk <= '1';
			wait for 0.5 sec;
		end loop;
		wait;
	end process;

    -- reset logic
    resetProcess: process
    begin
		rst <= '1';
		wait for 100 ns;
		rst <= '0';
		wait;
    end process;
end architecture;