--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:18:38 09/26/2014
-- Design Name:   
-- Module Name:   C:/Users/Sebastian/Dropbox/Sem 5/CG3207/Lab/Lab 2/Lab2revised/ADDSUB_test.vhd
-- Project Name:  Lab2revised
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ADDSUB
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ADDSUB_test IS
END ADDSUB_test;
 
ARCHITECTURE behavior OF ADDSUB_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ADDSUB
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         INVERSE : IN  std_logic;
         SUM : OUT  std_logic_vector(31 downto 0);
         CARRY : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal INVERSE : std_logic := '0';

 	--Outputs
   signal SUM : std_logic_vector(31 downto 0);
   signal CARRY : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ADDSUB PORT MAP (
          A => A,
          B => B,
          INVERSE => INVERSE,
          SUM => SUM,
          CARRY => CARRY
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
  -- end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		
--Testing subtraction
		
		
		INVERSE <= '1';
		wait for 100 ns;
		A <= x"00000001";
		B <= x"00000001";
		
		wait for 100 ns;
		A <= x"00000060";
		B <= x"00000040";
		
		wait for 100 ns;
		A <= x"00000020"; -- 32 - 96 = -64 
		B <= x"00000060";
		
		wait for 100 ns;
		
		A <= "11111111111111111111111111110110"; -- -10
		B <= "11111111111111111111111111100010"; --30


		
--Testing addition
		wait for 100 ns;
		INVERSE <= '0';
		A <= x"00000001";
		B <= x"00000001";
		
		wait for 100 ns;
		A <= x"00000060";
		B <= x"00000040";
		
		wait for 100 ns;
		A <= x"00000020";
		B <= x"00000060";
		
		
		
		
		
		
		
		
		

--      wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
