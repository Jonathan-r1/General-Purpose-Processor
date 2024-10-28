LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY sseg IS
	PORT (
		bcd	: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		neg	: IN STD_LOGIC;
		leds, neg_led	: OUT STD_LOGIC_VECTOR(1 to 7)
		
	);
END sseg7;

ARCHITECTURE Behaviour OF sseg IS
BEGIN
	PROCESS(bcd, neg)
	BEGIN
	IF neg = '1' THEN
		neg_led <= NOT "0000001";
	ELSE 
		neg_led <= "0000000";
	END IF;
	
	CASE bcd IS           -- abcdefg
		WHEN "0000" => leds <= NOT "1111110"; -- Displays 0
		WHEN "0001" => leds <= NOT "0000110"; -- Displays 1
		WHEN "0010" => leds <= NOT "1101101"; -- Displays 2
		WHEN "0011" => leds <= NOT "1111001"; -- Displays 3
		WHEN "0100" => leds <= NOT "0110011"; -- Displays 4
		WHEN "0101" => leds <= NOT "1011011"; -- Displays 5
		WHEN "0110" => leds <= NOT "1011111"; -- Displays 6
		WHEN "0111" => leds <= NOT "1110000"; -- Displays 7
		WHEN "1000" => leds <= NOT "1111111"; -- Displays 8
		WHEN "1001" => leds <= NOT "1110011"; -- Displays 9
		WHEN "1010" => leds <= NOT "1111101"; -- Displays a
		WHEN "1011" => leds <= NOT "0011111"; -- Displays b
		WHEN "1100" => leds <= NOT "1001110"; -- Displays c
		WHEN "1101" => leds <= NOT "0111110"; -- Displays d
		WHEN "1110" => leds <= NOT "1001111"; -- Displays e
		WHEN "1111" => leds <= NOT "1000111"; -- Displays f
	END CASE;
END PROCESS;
END Behaviour;
