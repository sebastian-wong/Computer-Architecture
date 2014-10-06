--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:56:22 09/30/2014
-- Design Name:   
-- Module Name:   C:/Users/hp/Desktop/lab2 30sept/lab2code/test_alu.vhd
-- Project Name:  lab2code
-- Target Device:  
-- Tool versions:  
-- Company: 
-- Engineer:
--
-- Create Date:   23:41:57 09/28/2014
-- Design Name:   
-- Module Name:   C:/Users/hp/Desktop/cg3207 lab2/cg3207_lab2/alu_test_division.vhd
-- Project Name:  cg3207_lab2
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
 
ENTITY alu_test_division IS
END alu_test_division;
 
ARCHITECTURE behavior OF alu_test_division IS 
 
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
   
     -- wait for Clk_period*10;

		--test cases	
	
	
	
	  -- test cases for wed's lab 
		Control <= "010011" ;
		Operand1 <= X"000000ff" ;
		Operand2 <= X"ffffffff";
		wait for 320 ns;
		--result 1 : X"00000000"
		--result2 : X"000000ff";
		
		
		Control <= "010010" ;
		Operand1 <= X"000000ff" ;
		Operand2 <= X"ffffffff";
		wait for 400 ns;
		--result 1 : X"ffffff01"
		--result2 : X"00000000";
		

		---

		--FOR DIVU -Control <=	"010011" ;
	
		--test case for Operand 1 / Operand 2 where Operand 2 is X"00000000"
		Control <=	"010011" ;
		Operand1 <= X"00000003"; --3
		Operand2 <= X"00000000"; --0
		
		wait for 320 ns;



		--test case for Operand 1 < Operand 2 
		Control <=	"010011" ;
		Operand1 <= X"00000002"; --2
		Operand2 <= X"00000009"; --9
		
		wait for 320 ns;
		


-- test for Operand 1 is X"00000000" 
		Control <=	"010011" ;
		Operand1 <= X"00000000"; --0
		Operand2 <= X"00000004"; --4
		
		wait for 320 ns;


--		-- test for Operand 1 and Operand 2 are X"00000000" 
		Control <=	"010011" ;
		Operand1 <= X"00000000"; --0
		Operand2 <= X"00000000"; --0
		
		wait for 320 ns;

		-- test for remainder = 0 where Operand 1 > Operand 2
		Control <=	"010011" ;
		Operand1 <= X"00000008"; --8
      Operand2 <= X"00000002"; --2
		
		wait for 320 ns;
	
		-- test for remainder = 0 where Operand 1 = Operand 2
		Control <=	"010011" ;
		Operand1 <= X"00000008"; --8
      Operand2 <= X"00000008"; --8
		
		wait for 320 ns;

		 --test for remainder > 0 where Operand 1 > Operand 2
		Control <=	"010011" ;
		Operand1 <= X"00000007"; --7
      Operand2 <= X"00000003"; --3
		wait for 320 ns;		
					
					
		-- test for remainder < 0 (bigger value)
		Control <=	"010011" ;
		Operand1 <= X"00000190"; --400 
		Operand2 <= X"000000FA"; --250
		wait for 320 ns;



-- test for remainder < 0 (random value)
		Control <=	"010011" ;
		Operand1 <= X"10010190"; --268501392
		Operand2 <= X"000100FA"; --65786
		wait for 320 ns;

			
		
	
		 --FOR DIV -Control <=	"010010" ;   	

			-- -7/3 Q = -2 R = -1
		Control <=	"010010" ;
		Operand1 <= "11111111111111111111111111111001"; --    -7
		Operand2 <= "00000000000000000000000000000011"; --    3
		wait for 320 ns;


     	
	
--	-- -7/-3 Q = 2 R = -1
		Control <=	"010010" ;
		Operand1 <= "11111111111111111111111111111001"; --    -7
		Operand2 <= "11111111111111111111111111111101"; --    -3
		wait for 320 ns;
--
	
		
		-- 7/-3 Q = -2 R = 1
		Control <=	"010010" ;
		Operand1 <= "00000000000000000000000000000111"; --    7
		Operand2 <= "11111111111111111111111111111101"; --   -3
		wait for 320 ns;	
		
		
		
		-- 7/3 Q = 2 R = 1
		Control <=	"010010" ;
		Operand1 <= "00000000000000000000000000000111"; --    7
		Operand2 <= "00000000000000000000000000000011"; --    3
		wait for 320 ns;
		
		



      wait;
   end process;

END;