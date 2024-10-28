library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
entity ALU is
port( Clk : in std_logic; -- input clock signal
	A,B : in unsigned(7 downto 0); -- 8-bit stuent id from latches
	OP : in unsigned(15 downto 0); -- 16-bit selector for opertion from decoder
	Neg : out std_logic; -- set -ve bit output
	R1 : out unsigned(3 downto 0); -- owder 4bits of 8bit result: output
	R2 : out unsigned(3 downto 0)); --higher 4 bits of 8bit result output
end ALU;

architecture calcultion of ALU is
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
				--add Reg1 and Reg2
				Result <= Reg1 + Reg2;
				Neg <= '0';
				
				WHEN "0000000000000010" =>
				--subtract(neg bit set if needed)
				if (Reg2>Reg1) then
					Result <= ((NOT Reg1+1) + Reg2);
					Neg <= '1';
				else
					Result <= (Reg1-Reg2);
					Neg <= '0';
				end if;
				
				WHEN "0000000000000100" =>
				--inverse
				Result <= NOT Reg1;
				
				Neg <= '0';
				
				WHEN "0000000000001000" =>
				--boolean NAND
				Result <= (NOT(Reg1 AND REG2));
				
				WHEN "0000000000010000" =>
				--boolean NOR
				Result <= (NOT(Reg1 OR REG2));
				
				WHEN "0000000000100000" =>
				-- boolean AND
				Result <= (Reg1 AND Reg2);
				
				WHEN "0000000001000000" =>
				--boolean XOR
				Result <= (Reg1 XOR Reg2);
				
				WHEN "0000000010000000" =>
				--boolean OR
				Result <= (Reg1 OR Reg2);
				
				WHEN "0000000100000000" =>
				--boolean XNOR
				Result <= (Reg1 XNOR Reg2);
				
				WHEN OTHERS =>
				Result <= "00000000";
			end case;
		end if;
	end process;
R1 <= Result(3 downto 0); --split the 8bits into two 4 bits for sseg
R2 <= Result(7 downto 4);
end calcultion;
