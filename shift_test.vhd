--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:20:00 09/26/2014
-- Design Name:   
-- Module Name:   C:/Users/Sebastian/Dropbox/Sem 5/CG3207/Lab/Lab 2/Lab2revised/shift_tester.vhd
-- Project Name:  Lab2revised
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Shift
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
 
ENTITY shift_tester IS
END shift_tester;
 
ARCHITECTURE behavior OF shift_tester IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Shift
    PORT(
         Shift_Controls : IN  std_logic_vector(1 downto 0);
         Operand1 : IN  std_logic_vector(31 downto 0);
         Operand2 : IN  std_logic_vector(31 downto 0);
         Result1 : OUT  std_logic_vector(31 downto 0);
         Result2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Shift_Controls : std_logic_vector(1 downto 0) := (others => '0');
   signal Operand1 : std_logic_vector(31 downto 0) := (others => '0');
   signal Operand2 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Result1 : std_logic_vector(31 downto 0);
   signal Result2 : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Shift PORT MAP (
          Shift_Controls => Shift_Controls,
          Operand1 => Operand1,
          Operand2 => Operand2,
          Result1 => Result1,
          Result2 => Result2
        );

   -- Clock process definitions
 --  <clock>_process :process
 --  begin
	--	<clock> <= '0';
	--	wait for <clock>_period/2;
	--	<clock> <= '1';
	--	wait for <clock>_period/2;
  -- end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		
--test LSL
--	wait for 100 ns;
	Shift_Controls <= "01";
	Operand1 <= x"FFFF0000";
	Operand2 <= x"00000001";
	
	wait for 20 ns;
	Operand1 <= x"FFFF0000";
	Operand2 <= x"00000002";
	
	wait for 20 ns;
	Operand1 <= x"FFFFFFFF";
	Operand2 <= x"00000004";
	
	wait for 20 ns;
	Operand1 <= x"FFFFFFFF";
	Operand2 <= x"00000008";

	wait for 20 ns;
	Operand1 <= x"FFFFFFFF";
	Operand2 <= x"00000010";
	
   wait for 100 ns;
	Shift_Controls <= "11";
	Operand1 <= x"FFFFFFFF";
	Operand2 <= x"00000001";
	
   wait for 20 ns;
	Operand1 <= x"FFFFFFFF";
	Operand2 <= x"00000002";
	
   wait for 20 ns;
	Operand1 <= x"FFFFFFFF";
	Operand2 <= x"00000004";

   wait for 20 ns;
	Operand1 <= x"FFFFFFFF";
	Operand2 <= x"00000008";

   wait for 20 ns;
	Operand1 <= x"FFFFFFFF";
	Operand2 <= x"00000010";
	
	
	
	wait for 100 ns;
	Shift_Controls <= "10";
	Operand1 <= x"F0000001";
	Operand2 <= x"00000001";
	
	wait for 20 ns;
	Operand1 <= x"F0000001";
	Operand2 <= x"00000002";

	wait for 20 ns;
	Operand1 <= x"F0000001";
	Operand2 <= x"00000004";

	wait for 20 ns;
	Operand1 <= x"F0000001";
	Operand2 <= x"00000008";

	wait for 20 ns;
	Operand1 <= x"F0000001";
	Operand2 <= x"00000010";
	
	
	
     -- wait for <clock>_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
