--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:20:26 09/26/2014
-- Design Name:   
-- Module Name:   C:/Users/hp/Desktop/NUS/nus yr3 sem 1/CG3207/lab2 sol new/lab2_assignment/multiplexer_test.vhd
-- Project Name:  lab2_assignment
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: multiplexer
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
 
ENTITY multiplexer_test IS
END multiplexer_test;
 
ARCHITECTURE behavior OF multiplexer_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT multiplexer
    PORT(
         CONTROL_OP : IN  std_logic_vector(4 downto 0);
         ADD_SUB_OP : IN  std_logic_vector(31 downto 0);
         SHIFTER_OP : IN  std_logic_vector(31 downto 0);
         MULT_OP : IN  std_logic_vector(31 downto 0);
         DIV_OP : IN  std_logic_vector(31 downto 0);
         RESULT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CONTROL_OP : std_logic_vector(4 downto 0) := (others => '0');
   signal ADD_SUB_OP : std_logic_vector(31 downto 0) := (others => '0');
   signal SHIFTER_OP : std_logic_vector(31 downto 0) := (others => '0');
   signal MULT_OP : std_logic_vector(31 downto 0) := (others => '0');
   signal DIV_OP : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal RESULT : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
  -- constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: multiplexer PORT MAP (
          CONTROL_OP => CONTROL_OP,
          ADD_SUB_OP => ADD_SUB_OP,
          SHIFTER_OP => SHIFTER_OP,
          MULT_OP => MULT_OP,
          DIV_OP => DIV_OP,
          RESULT => RESULT
        );

   -- Clock process definitions
  -- <clock>_process :process
  -- begin
	--	<clock> <= '0';
	--	wait for <clock>_period/2;
	--	<clock> <= '1';
		--wait for <clock>_period/2;
 --  end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

    --  wait for <clock>_period*10;

		ADD_SUB_OP <= X"00000000";
      SHIFTER_OP <= X"00000010";
		MULT_OP    <= X"00000100";
		DIV_OP     <= X"00001000";
	
		--ADDSUB
		CONTROL_OP <= "00010";
		WAIT FOR 50 NS;
		CONTROL_OP <= "00110";
		WAIT FOR 50 NS;
		
		--SLL/SRL/SRA
		CONTROL_OP <= "00101";
		WAIT FOR 50 NS;
		
		CONTROL_OP <= "01101";
		WAIT FOR 50 NS;
		
		CONTROL_OP <= "01001";
		WAIT FOR 50 NS;
		
		--MULT/MULTU
		CONTROL_OP <= "10000";
		WAIT FOR 50 NS;
		
		CONTROL_OP <= "10001";
		WAIT FOR 50 NS;
		
		--DIV/DIVU
		CONTROL_OP <= "10010";
		WAIT FOR 50 NS;
		
		CONTROL_OP <= "10011";
		WAIT FOR 50 NS;
		
		
		--OTHERS
		--ADD
		CONTROL_OP <= "00000";
		WAIT FOR 50 NS;
		
		--OR
		CONTROL_OP <= "00001";
		WAIT FOR 50 NS;
		
		
		--XOR
		CONTROL_OP <= "00100";
		WAIT FOR 50 NS;
		
		--NOR
		CONTROL_OP <= "01100";
		WAIT FOR 50 NS;
		
		--SLT 
		CONTROL_OP <= "00111";
		WAIT FOR 50 NS;
		
		--SLTU
		CONTROL_OP <= "01110";
		WAIT FOR 50 NS;
		
		
		
		
		
		

      wait;
   end process;

END;
