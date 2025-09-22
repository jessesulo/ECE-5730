library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab2StopWatch is
	port (
		clk: in std_logic;
		reset: in std_logic;
		go: in std_logic;
		seg0: out std_logic_vector(6 downto 0);
		seg1: out std_logic_vector(6 downto 0);
		seg2: out std_logic_vector(6 downto 0);
		seg3: out std_logic_vector(6 downto 0);
		seg4: out std_logic_vector(6 downto 0);
		seg5: out std_logic_vector(6 downto 0)
	);
end entity lab2StopWatch;

architecture behavioral of lab2StopWatch is
	signal enable: std_logic := '0';
	signal count: unsigned(27 downto 0) := (others => '0');
	signal minutes: unsigned (6 downto 0) := (others => '0');
	signal seconds: unsigned (6 downto 0) := (others => '0');
	signal hundreds: unsigned (6 downto 0) := (others => '0');
	signal M1, M2, S1, S2, H1, H2: unsigned(3 downto 0) := (others => '0');
	function sevenSegDisplay(number: unsigned(3 downto 0)) return std_logic_vector is
	begin
		case number is
			when "0000" => return "0000001"; -- 0
			when "0001" => return "1001111"; -- 1
			when "0010" => return "0010010"; -- 2
			when "0011" => return "0000110"; -- 3
			when "0100" => return "1001100"; -- 4
			when "0101" => return "0100100"; -- 5
			when "0110" => return "0100000"; -- 6
			when "0111" => return "0001111"; -- 7
			when "1000" => return "0000000"; -- 8
			when "1001" => return "0000100"; -- 9
			when others => return "1111111"; -- off
		end case;
	end function sevenSegDisplay;
begin


	-- clock generator
	process(clk)
	begin
		if rising_edge(clk) then
			if reset = '1' then -- reset logic
				count <= (others => '0');
				enable <= '0';
				minutes <= (others => '0');
				seconds <= (others => '0');
				hundreds <= (others => '0');
			else
				enable <= go; -- go logic
			end if;
				
			if count = to_unsigned(500000, count'length) and enable = '1' then -- if 50MHz clock hit a hundredth of a second
				if hundreds = to_unsigned(99, hundreds'length) then
					-- if hundred is greater than or equal to 100 increment second and reset hundreds
					hundreds <= (others => '0');
					if seconds = to_unsigned(59, seconds'length) then
						-- if seconds is greater than or equal to 60 increment minute and reset seconds
						seconds <= (others => '0');
						if minutes = to_unsigned(59, minutes'length) then
							-- if minutes is greater than or equal to 60 reset completely
							count <= (others => '0');
							minutes <= (others => '0');
							seconds <= (others => '0');
							hundreds <= (others => '0');
						else
							minutes <= minutes + 1;-- increment minute
						end if;
					else
						seconds <= seconds + 1;-- increment second
					end if;
				else
					hundreds <= hundreds + 1;-- increment hundred
				end if;
			else
				count <= count + 1; --increment count
			end if;
		end if;
	end process;
	
				
	-- seven segment display logic
	
	process(minutes, seconds, hundreds)
	begin
		M1 <= to_unsigned(to_integer(minutes) mod 10, 4);-- find out first digites through mod 10
		S1 <= to_unsigned(to_integer(seconds) mod 10, 4);
		H1 <= to_unsigned(to_integer(hundreds) mod 10, 4);
		M2 <= to_unsigned(to_integer(minutes) / 10, 4); -- find out second digits through / 10
		S2 <= to_unsigned(to_integer(seconds) / 10, 4);
		H2 <= to_unsigned(to_integer(hundreds) / 10, 4);
	end process;
	
	seg5 <= sevenSegDisplay(M2);
	seg4 <= sevenSegDisplay(M1);
	seg3 <= sevenSegDisplay(S2);
	seg2 <= sevenSegDisplay(S1);
	seg1 <= sevenSegDisplay(H2);
	seg0 <= sevenSegDisplay(H1);
	

end behavioral;