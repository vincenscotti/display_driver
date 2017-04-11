library ieee;
use ieee.std_logic_1164.all;
 
entity display_driver_tb is
end display_driver_tb;
 
architecture behavior of display_driver_tb is 
 
	component display_driver
		generic ( clock_freq : integer;
		n_display : integer;
		refresh_rate : integer);

		port ( clock : in  std_logic;
		reset : in  std_logic;
		input : in  std_logic_vector ((n_display * 4) - 1 downto 0);
		dots_en : in  std_logic_vector (n_display - 1 downto 0);
		display_en : in  std_logic_vector (n_display - 1 downto 0);
		cathodes : out  std_logic_vector (6 downto 0);
		dot : out  std_logic;
		anodes : out  std_logic_vector (n_display - 1 downto 0));
	end component;

	signal clock : std_logic := '0';
	signal reset : std_logic := '1';
	signal input : std_logic_vector(11 downto 0) := (others => '0');
	signal dots_en : std_logic_vector(2 downto 0) := (others => '0');
	signal display_en : std_logic_vector(2 downto 0) := (others => '1');

	signal cathodes : std_logic_vector(6 downto 0);
	signal dot : std_logic;
	signal anodes : std_logic_vector(2 downto 0);

	constant clock_period : time := 10 ns;

	begin

	uut: display_driver generic map (
		clock_freq => 100e6,
		n_display => 3,
		refresh_rate => 25
	) port map (
		clock => clock,
		reset => reset,
		input => input,
		dots_en => dots_en,
		display_en => display_en,
		cathodes => cathodes,
		dot => dot,
		anodes => anodes
	);

	clock_process :process
	begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
	end process;

	stim_proc: process
	begin		
		wait for clock_period*10;

		reset <= '0';

		wait for 20 ms;

		input <= "000011110101";

		wait;
	end process;

end;
