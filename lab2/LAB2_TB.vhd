library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab2StopWatch_tb is
end entity;

architecture test of lab2StopWatch_tb is
    component lab2StopWatch
        port (
            clk   : in std_logic;
            reset : in std_logic;
            go    : in std_logic;
            seg0  : out std_logic_vector(6 downto 0);
            seg1  : out std_logic_vector(6 downto 0);
            seg2  : out std_logic_vector(6 downto 0);
            seg3  : out std_logic_vector(6 downto 0);
            seg4  : out std_logic_vector(6 downto 0);
            seg5  : out std_logic_vector(6 downto 0)
        );
    end component;
    signal clk     : std_logic := '0';
    signal reset   : std_logic := '0';
    signal go      : std_logic := '0';
    signal seg0    : std_logic_vector(6 downto 0);
    signal seg1    : std_logic_vector(6 downto 0);
    signal seg2    : std_logic_vector(6 downto 0);
    signal seg3    : std_logic_vector(6 downto 0);
    signal seg4    : std_logic_vector(6 downto 0);
    signal seg5    : std_logic_vector(6 downto 0);
    constant clk_period : time := 20 ns; -- 50 MHz clock

begin
    uut: lab2StopWatch
        port map (
            clk   => clk,
            reset => reset,
            go    => go,
            seg0  => seg0,
            seg1  => seg1,
            seg2  => seg2,
            seg3  => seg3,
            seg4  => seg4,
            seg5  => seg5
        );

    -- Clock logic
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;
	 
    stim_proc: process
    begin
        -- Initial reset
        reset <= '1';
        go <= '0';
        wait for 100 ns;

        reset <= '0';
        wait for 50 ns;

        -- Start stopwatch
        go <= '1';

        -- Let it run to simulate time passing
        wait for 500 ms;

        -- Stop stopwatch
        go <= '0';

        wait for 50 ms;
        wait;
    end process;

end architecture;
