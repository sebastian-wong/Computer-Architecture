----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:08:38 09/26/2014 
-- Design Name: 
-- Module Name:    ADDSUB - Behavioral 
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
--This addsub module can only take in two positive numbers and perform addition or
--subtraction.

--For subtraction, set inverse to one.
--By using B xor Inverter, every bit in B is inverted. Addding one to this will result
--in the second complement of B. Adding A to the second complement of B will result in
-- subtraction.

--For addition, set inverse to 0.
-- B xor Inverter will not result in any change as positive numbers do not have second
-- complements. Addition is performed normally.

--Improvements required: Try to allow the addsub module to take in negative numbers 
--as well

-----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ADDSUB is
generic (width : integer := 32);
port (A 		: in std_logic_vector(width-1 downto 0);
		B 		: in std_logic_vector(width-1 downto 0);
		INVERSE 	: in std_logic;
		SUM 		: out std_logic_vector(width-1 downto 0);
		CARRY	: out std_logic);
end ADDSUB;


architecture ADDSUB_arch of ADDSUB is
signal SUM_WIDER : std_logic_vector(width downto 0);
signal INVERTER : std_logic_vector(width-1 downto 0);

begin

	INVERTER <= (others => INVERSE);
	SUM_WIDER <= ('0'& A) + ('0'& (B xor INVERTER)) + INVERSE;
	SUM <= SUM_WIDER(width-1 downto 0);
	CARRY <= SUM_WIDER(width);
end ADDSUB_arch;
