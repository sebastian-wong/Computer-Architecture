----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:58:07 09/26/2014 
-- Design Name: 
-- Module Name:    Shift - Behavioral 
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

entity Shift is
    Port (
			Shift_Controls :in STD_LOGIC_VECTOR(1 downto 0); --(0) is for direction, (1) is for shift type
			Operand1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Operand2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Result1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Result2 : out  STD_LOGIC_VECTOR (31 downto 0));
end Shift;

architecture Behavioral of Shift is

begin

process(Shift_Controls, Operand1, Operand2)

	variable temp_result : STD_LOGIC_VECTOR(31 downto 0);
	--variable temp_result_higher :STD_LOGIC_VECTOR (31 downto 0);
	variable MSB : STD_LOGIC;
	
begin
	
	temp_result := Operand1;
	
	
	
	case Shift_Controls is
	
	
	--Logical shift left
	when "01" =>
		
		if Operand2(0) = '1' then
			temp_result := temp_result(30 downto 0) & '0';
			end if;
		if Operand2(1) = '1' then
			temp_result := temp_result(29 downto 0) & "00";
			end if;
		if Operand2(2) = '1' then	
			temp_result := temp_result(27 downto 0) & x"0";
			end if;
		if Operand2(3) = '1' then
			temp_result := temp_result(23 downto 0) & x"00";
			end if;
		if Operand2(4) = '1' then
			temp_result := temp_result(15 downto 0) & x"0000";
			end if;
			
	--Logical shift right 
	when "11" =>
	
		if Operand2(0) = '1' then
			temp_result :=  '0' & temp_result(31 downto 1);
			end if;
		if Operand2(1) = '1' then
			temp_result:= "00" & temp_result(31 downto 2);
			end if;
		if Operand2(2) = '1' then
			temp_result:= x"0" & temp_result(31 downto 4);
			end if;
		if Operand2(3) = '1' then
			temp_result:= x"00" & temp_result(31 downto 8);
			end if;
		if Operand2(4) = '1' then
			temp_result:= x"0000" & temp_result(31 downto 16);
			end if;

	
	-- Shift right arithmetic
	when "10" =>
		MSB := Operand1(31);
		
		if Operand2(0) = '1' then
			--temp_result(31) := MSB;
			temp_result(30 downto 0) := temp_result(31 downto 1);
			temp_result(31) := MSB;
			end if;
		if Operand2(1) = '1' then
			--temp_result(31 downto 30) := (others => MSB);
			temp_result(29 downto 0) := temp_result(31 downto 2);
			temp_result(31 downto 30) := (others => MSB);
			end if;
		if Operand2(2) = '1' then
			temp_result(27 downto 0) := temp_result(31 downto 4);
			temp_result(31 downto 28) := (others => MSB);
			end if;
		if Operand2(3) = '1' then
			temp_result(23 downto 0) := temp_result(31 downto 8);
			temp_result(31 downto 24) := (others => MSB);	
			end if;
		if Operand2(4) = '1' then	
			temp_result(15 downto 0) := temp_result(31 downto 16);
			temp_result(31 downto 16) := (others => MSB);
			end if;

	
	when others =>
		
			--do nothing
	end case;
	
	Result1 <= temp_result;
	Result2 <= (others => 'X');
	
end process;	

end Behavioral;

