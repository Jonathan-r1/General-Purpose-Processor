library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
entity ALU2 is
port( Clk : in std_logic; -- input clock signal
	A,B : in unsigned(7 downto 0); -- 8-bit stuent id from latches
	OP : in unsigned(15 downto 0); -- 16-bit selector for opertion from decoder
	Neg : out std_logic; -- set -ve bit output
	R1 : out unsigned(3 downto 0); -- owder 4bits of 8bit result: output
	R2 : out unsigned(3 downto 0)); --higher 4 bits of 8bit result output
end ALU2;

architecture calcultion of ALU2 is
signal Reg1,Reg2,Result : unsigned(7 downto 0):=(others => '0');
signal Reg4 : unsigned(0 to 7);
begin
Reg1 <= A; --temp store A in Reg1 local variable
Reg2 <= B; --temp store B in Reg2 local variable
process(Clk, OP)
begin
	if(rising_edge(Clk))THEN -- calcultions @positive edge og clk cycle
		case OP is
		WHEN "0000000000000001" =>
		--invert bit significance of A
			Result(7) <=  Reg1(0);
			Result(6) <=  Reg1(1);
			Result(5) <=  Reg1(2);
			Result(4) <=  Reg1(3);
			Result(3) <=  Reg1(4);
			Result(2) <=  Reg1(5);
			Result(1) <=  Reg1(6);
			Result(0) <=  Reg1(7);
					--Result <= Reg1(0)&Reg1(1)&Reg1(2)&Reg1(3)&Reg1(4)&Reg1(5)&Reg1(6)&Reg1(7);
					Neg<='0';
		WHEN "0000000000000010" =>
		--Shift A to left by 4 bits, input bit = 1 (SHL)
		Result <= Reg1(5 downto 0) & "01"; --Reg1 sll 3; --Reg1(3 downto 0) & "1111";	

		WHEN "0000000000000100" =>
			--invert upper four bits of B
			Result(7) <= NOT Reg2(7);
			Result(6) <= NOT Reg2(6);
			Result(5) <= NOT Reg2(5);
			Result(4) <= NOT Reg2(4);
			Result(3) <=  Reg2(3);
			Result(2) <=  Reg2(2);
			Result(1) <=  Reg2(1);
			Result(0) <=  Reg2(0);
		
		WHEN "0000000000001000" =>

					--find smaller value between (a,b) and produce results
			if(Reg1 <= Reg2) then
				Result <= Reg1;
			else
				Result  <= Reg2;
			end if;
		
		WHEN "0000000000010000" =>

				--Calculate the summation of A and B and increase it by 4
			Result <= ((Reg1 + Reg2) + "00000100");
		
		WHEN "0000000000100000" =>

					-- Increment A by 3
			Result <= (Reg1 + "00000011");
		
		WHEN "0000000001000000" =>

					--Replace the even bits of A with even bits of B
			Result <= Reg1;
			Result(0) <= Reg2(0);
			Result(2) <= Reg2(2);
			Result(4) <= Reg2(4);
			Result(6) <= Reg2(6);
		
		WHEN "0000000010000000" =>
		--Produce the result of XNORing A and B
			Result <= (Reg1 XNOR Reg2);
		
		WHEN "0000000100000000" =>
				--Rotate B to right by 3 bits (ROR)
			Result <= (Reg2 ROR 3);--(Reg2 ROR 3);

		WHEN OTHERS =>
			Result <= "00000000";
end case;
end if;
end process;

R1 <= Result(3 downto 0); --split the 8bits into two 4 bits for sseg
R2 <= Result(7 downto 4);
end calcultion;
