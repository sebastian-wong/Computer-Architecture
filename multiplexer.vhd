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
--	signal unaffected : std_logic_vector(31 downto 0);
	--unaffected <=(others <='0');
begin
						
						
		RESULT <= ADD_SUB_OP when CONTROL_OP = "00010" or CONTROL_OP = "00110" else --ADD/SUB
			 
			 SHIFTER_OP when CONTROL_OP = "00101" or 
						CONTROL_OP = "01101" or CONTROL_OP = "01001" else --SLL/SRL/SRA
			 
			 MULT_OP when CONTROL_OP = "10000" or CONTROL_OP = "10001" else --MULT/MULTU
			 
			 DIV_OP when CONTROL_OP ="10010" or CONTROL_OP = "10011" else --DIV/DIVU
			 
			 SHIFTER_OP when CONTROL_OP = "00101" or CONTROL_OP = "01101" or CONTROL_OP = "01001" else
			  
			 (others => '0');		 -- SLT/SLTU	

--			  AND_OP  when CONTROL_OP = "00000" else
--			  OR_OP   when CONTROL_OP = "00001" else
--			  XOR_OP  when CONTROL_OP = "00100" else
--			  NOR_OP   when CONTROL_OP = "01100" else			  
						
						
						
						
						
						
						
						
						
						

end Behavioral;

