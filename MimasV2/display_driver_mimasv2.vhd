library ieee;
use ieee.std_logic_1164.all;

entity display_driver_mimasv2 is
	port ( clock : in  std_logic;
	reset : in  std_logic;
	input : in  std_logic_vector (7 downto 0);
	dots_en : in  std_logic_vector (1 downto 0);
	display_en : in  std_logic_vector (1 downto 0);
	cathodes : out  std_logic_vector (6 downto 0);
	dot : out  std_logic;
	anodes : out  std_logic_vector (1 downto 0));
end display_driver_mimasv2;

architecture behavioral of display_driver_mimasv2 is

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

	signal reset_internal : std_logic;
	signal input_internal : std_logic_vector (7 downto 0);
	signal dots_en_internal : std_logic_vector (1 downto 0);
	signal display_en_internal : std_logic_vector (1 downto 0);
	signal cathodes_internal : std_logic_vector(6 downto 0);
	signal dot_internal : std_logic;
	signal anodes_internal : std_logic_vector(1 downto 0);

begin

	reset_internal <= not reset;
	input_internal <= not input;
	dots_en_internal <= not dots_en;
	display_en_internal <= not display_en;

	cathodes <= not cathodes_internal;
	dot <= not dot_internal;
	anodes <= not anodes_internal;

	inst_display_driver: display_driver generic map (
		clock_freq => 100e6,
		n_display => 2,
		refresh_rate => 100
	) port map (
		clock => clock,
		reset => reset_internal,
		input => input_internal,
		dots_en => dots_en_internal,
		display_en => display_en_internal,
		cathodes => cathodes_internal,
		dot => dot_internal,
		anodes => anodes_internal
	);

end behavioral;

