library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab10BitCounter is
	port (
		clk: in std_logic;
		rst: in std_logic;
		leds: out std_logic_vector(9 downto 0)
	);
end entity lab10BitCounter;

architecture behavioral of lab10BitCounter is
	signal counter: unsigned(9 downto 0):=(others=>'0');
	signal clockCounter: unsigned(27 downto 0):=(others=>'0');
	signal enable: std_logic:='0';
begin

	-- clock enable logic
	process(clk)
	begin
		if rising_edge(clk) then
			if rst = '1' then -- reset logic
				enable <= '0';
				clockCounter <= (others => '0');
			elsif clockCounter = to_unsigned(249999999, clockCounter'length) then -- enable logic at 2 hz
					enable <= '1';
					clockCounter <= (others => '0');
				else -- increase clockCounter
					clockCounter <= clockCounter + 1;
					enable <= '0';
				end if;
			end if;
		end if;
	end process;
					

	-- counter logic
	process(clk)
   begin
		if rising_edge(clk) then
			if rst = '1' then -- reset logic
				counter <= (others => '0');
			elsif enable = '1' then -- if reset is not pressed increment
				counter <= counter + 1;
			end if;
		end if;
   end process;
	
	leds <= std_logic_vector(counter); -- actually send out signal to the LEDS
	
end architecture behavioral;