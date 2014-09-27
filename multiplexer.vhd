----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:24:07 09/26/2014 
-- Design Name: 
-- Module Name:    multiplexer - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multiplexer is
    Port ( CONTROL_OP : in  STD_LOGIC_VECTOR (4 DOWNTO 0);
           ADD_SUB_OP : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           SHIFTER_OP : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
			  MULT_OP : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
			  DIV_OP : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           --AND_OP : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           --OR_OP : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           --XOR_OP : in STD_LOGIC_VECTOR (31 DOWNTO 0);
           --NOR_OP : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
           RESULT : out  STD_LOGIC_VECTOR (31 DOWNTO 0) );
end multiplexer;

architecture Behavioral of multiplexer is
begin
		signal unaffected : std_logic_vector(31 downto 0) := (others <='0');

	with CONTROL_OP select
		RESULT <=   ADD_SUB_OP when "00010" or "00110"; --ADD/SUB
						SHIFTER_OP when "00101" or "01101" or "01001"; --SLL/SRL/SRA
						MULT_OP when "10000" or "10001"; --MULT/MULTU
						DIV_OP when "10010" or "10011"; --DIV/DIVU
						--AND_OP when "00000"; --AND
						--OR_OP  when "00001"; --OR
						--XOR_OP when "00100"; --XOR
						--NOR_OP when "01100"; --NOR
					   unaffected when others; -- SLT/SLTU

end Behavioral;

