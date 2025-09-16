library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
  port (
    clk            : in  std_logic;
    rst_l          : in  std_logic;
    binary_output  : out std_logic_vector(9 downto 0)
  );
end entity counter;

architecture ticker of counter is
  signal count      : unsigned(9 downto 0) := (others => '0');
  signal clk_count  : unsigned(24 downto 0) := (others => '0');
begin
  process (clk, rst_l)
  begin
    if rst_l = '0' then
      count     <= (others => '0');
      clk_count <= (others => '0');
    elsif rising_edge(clk) then
      if clk_count = to_unsigned(24999999, clk_count'length) then
        count     <= count + 1;
        clk_count <= (others => '0');
      else
        clk_count <= clk_count + 1;
      end if;
    end if;
  end process;
  binary_output <= std_logic_vector(count);
end architecture ticker;