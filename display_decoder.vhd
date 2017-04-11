library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display_decoder is
	port ( nibble : in  std_logic_vector (3 downto 0);
	segments : out  std_logic_vector (6 downto 0));
end display_decoder;

architecture behavioral of display_decoder is

	type output_matrix is array (0 to 2 ** 4 - 1) of std_logic_vector(6 downto 0);
	--constant segments_map : output_matrix := (("1111110"), ("0110000"),
		--("1101101"), ("1111001"), ("0110011"), ("1011011"), ("1011111"),
		--("1110000"), ("1111111"), ("1110011"), ("1110111"), ("0011111"),
		--("1001110"), ("0111101"), ("1001111"), ("1000111"));

	constant segments_map : output_matrix := (("0111111"), ("0000110"),
		("1011011"), ("1001111"), ("1100110"), ("1101101"), ("1111101"),
		("0000111"), ("1111111"), ("1100111"), ("1110111"), ("1111100"),
		("0111001"), ("1011110"), ("1111001"), ("1110001"));
begin

	--wiring: for i in segments'range generate
		--segments(i) <= segments_map(to_integer(unsigned(nibble)))(i);
	--end generate;

	segments <= segments_map(to_integer(unsigned(nibble)));

end behavioral;

