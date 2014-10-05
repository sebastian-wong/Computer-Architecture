--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:40:20 09/28/2014
-- Design Name:   
-- Module Name:   C:/Users/Sebastian/Dropbox/Sem 5/CG3207/Lab/Lab 2/Lab2revised/alu_test1.vhd
-- Project Name:  Lab2revised
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: alu
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
 
ENTITY alu_test1 IS
END alu_test1;
 
ARCHITECTURE behavior OF alu_test1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu
    PORT(
         Clk : IN  std_logic;
         Control : IN  std_logic_vector(5 downto 0);
         Operand1 : IN  std_logic_vector(31 downto 0);
         Operand2 : IN  std_logic_vector(31 downto 0);
         Result1 : OUT  std_logic_vector(31 downto 0);
         Result2 : OUT  std_logic_vector(31 downto 0);
         Status : OUT  std_logic_vector(2 downto 0);
         Debug : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Control : std_logic_vector(5 downto 0) := (others => '0');
   signal Operand1 : std_logic_vector(31 downto 0) := (others => '0');
   signal Operand2 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Result1 : std_logic_vector(31 downto 0);
   signal Result2 : std_logic_vector(31 downto 0);
   signal Status : std_logic_vector(2 downto 0);
   signal Debug : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: alu PORT MAP (
          Clk => Clk,
          Control => Control,
          Operand1 => Operand1,
          Operand2 => Operand2,
          Result1 => Result1,
          Result2 => Result2,
          Status => Status,
          Debug => Debug
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;

----Tests for SLT
--Control <= "000111";
--Operand1 <= (others => '0');
--Operand2 <= (others => '0');
----Result1 should be 0
--
--      --wait for Clk_period*2;
--		      wait for 100 ns;
--
--Control <= "000111";
--Operand1 <= (others => '0');
--Operand2 <= (others => '0');
----Result1 should be 0
--
--
--		--wait for Clk_period*2;
--		      wait for 100 ns;
--
--
--Control <= "000111";
--Operand1 <= (0 => '1', others => '0');
--Operand2 <= (others => '0');
----Result1 should be 0
--
--     -- wait for Clk_period*2;
--	        wait for 100 ns;
--
--Control <= "000111";
--Operand1 <= (others => '0');
--Operand2 <= (0 => '1', others => '0');
----Result1 should be 1
--
--
--     -- wait for Clk_period*2;
--	        wait for 100 ns;
--
--Control <= "000111";
--Operand1 <= (30 => '1', others => '0');
--Operand2 <= (29 => '1', others => '0');
----Result1 should be 0
--
--
--     -- wait for Clk_period*2;
--	        wait for 100 ns;
--
--Control <= "000111";
--Operand1 <= (29 => '1', others => '0');
--Operand2 <= (30 => '1', others => '0');
----Result1 should be 1		
--
--
--		      wait for 100 ns;
--
--Control <= "000111";
--Operand1 <= "00000000000000000000000000001100";  -- 12
--Operand2 <= "11111111111111111111111111110110"; -- -10
----Result1 should be 0		
--				
--				wait for 100 ns;
--
--Control <= "000111";
--Operand1 <= (31 => '1', others => '0');
--Operand2 <= (30 => '1', others => '0');
----Result1 should be 1
--
--
--
----Tests for SLTU
--
--
--Control <= "001110";
--Operand1 <= (31 => '1', others => '0');
--Operand2 <= (30 => '1', others => '0');
----Results should be 0
--
--
--Control <= "001110";
--Operand1 <= (30 => '1', others => '0');
--Operand2 <= (31 => '1', others => '0');
----Results should be 1
--
--Control <= "001110";
--Operand1 <= (others => '1');
--Operand2 <= (30 => '1', others => '0');
----Results should be 0
--


--Tests for shifting
Control <= "000101";
Operand1 <= (others => '1');
Operand2 <= (0 => '1', others => '0');

Control <= "000101";
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
	Control <= "001101";
	Operand1 <= x"00f0f0f0";
	Operand2 <= x"0000001f";
	
	
	
	wait for 20 ns;
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
	Control <= "001001";
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
	


     -- wait for Clk_period*2;
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		

      -- insert stimulus here 

      wait;
   end process;

END;
