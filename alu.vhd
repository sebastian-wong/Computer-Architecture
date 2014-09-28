----------------------------------------------------------------------------------
-- Company: NUS
-- Engineer: Rajesh Panicker
-- 
-- Create Date:   10:39:18 13/09/2014
-- Design Name: 	ALU
-- Target Devices: Nexys 4 (Artix 7 100T)
-- Tool versions: ISE 14.7
-- Description: ALU template for MIPS processor
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.03 - Asserting reset will cause everything in the MULTI_CYCLE_PROCESS to be reset 
-- Additional Comments: 
--
----------------------------------------------------------------------------------


------------------------------------------------------------------
-- ALU Entity
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alu is
generic (width 	: integer := 32);
Port (Clk			: in	STD_LOGIC;
		Control		: in	STD_LOGIC_VECTOR (5 downto 0);
		Operand1		: in	STD_LOGIC_VECTOR (width-1 downto 0);
		Operand2		: in	STD_LOGIC_VECTOR (width-1 downto 0);
		Result1		: out	STD_LOGIC_VECTOR (width-1 downto 0);
		Result2		: out	STD_LOGIC_VECTOR (width-1 downto 0);
		Status		: out	STD_LOGIC_VECTOR (2 downto 0); -- busy (multicycle only), overflow (add and sub), zero (sub)
		Debug			: out	STD_LOGIC_VECTOR (width-1 downto 0));		
end alu;


------------------------------------------------------------------
-- ALU Architecture
------------------------------------------------------------------

architecture Behavioral of alu is

type states is (COMBINATIONAL, MULTI_CYCLE);
signal state, n_state 	: states := COMBINATIONAL;


----------------------------------------------------------------------------
-- ADDSUB instantiation
----------------------------------------------------------------------------
component ADDSUB is
generic (width : integer);
port (A 		: in 	std_logic_vector(width-1 downto 0);
		B 		: in 	std_logic_vector(width-1 downto 0);
		INVERSE 	: in 	std_logic;
		SUM 		: out std_logic_vector(width-1 downto 0);
		CARRY	: out std_logic);
end component;

----------------------------------------------------------------------------
--Shifter instantiation
----------------------------------------------------------------------------

component Shift is
    Port (
			Shift_Controls :in STD_LOGIC_VECTOR(1 downto 0); --(0) is for direction, (1) is for shift type
			Operand1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Operand2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Result1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Result2 : out  STD_LOGIC_VECTOR (31 downto 0));
end component Shift;

----------------------------------------------------------------------------
-- ADDSUB signals
----------------------------------------------------------------------------

signal B 		: std_logic_vector(width-1 downto 0) := (others => '0'); 
signal INVERSE 	: std_logic := '0';
signal SUM 		: std_logic_vector(width-1 downto 0) := (others => '0'); 
signal CARRY	: std_logic := '0'; --not used


-----------------------------------------------------------------------------
--Shifter signals
-----------------------------------------------------------------------------

signal Shift_output : STD_LOGIC_VECTOR(31 downto 0);

----------------------------------------------------------------------------
-- Signals for MULTI_CYCLE_PROCESS
----------------------------------------------------------------------------
signal Result1_multi		: STD_LOGIC_VECTOR (width-1 downto 0) := (others => '0'); 
signal Result2_multi		: STD_LOGIC_VECTOR (width-1 downto 0) := (others => '0');
signal Debug_multi		: STD_LOGIC_VECTOR (width-1 downto 0) := (others => '0'); 
signal done		 			: STD_LOGIC := '0';

begin

-- <port maps>
ADDSUBer : ADDSUB generic map (width =>  width) port map (  A=>Operand1, B=>Operand2, INVERSE=>CONTROL(2), SUM=>SUM, CARRY=>CARRY );
Shifter : Shift port map(Operand1=>Operand1, Operand2=>Operand2, Shift_Controls(0)=>Control(3), Shift_Controls(1)=>Control(2), Result1=>Shift_output);
-- </port maps>


----------------------------------------------------------------------------
-- COMBINATIONAL PROCESS
----------------------------------------------------------------------------
COMBINATIONAL_PROCESS : process (
											Control, Operand1, Operand2, state, -- external inputs
											SUM, Shift_output, -- SUM: output from addsub, Shift_output : output from shifter
											Result1_multi, Result2_multi, Debug_multi, done -- from multi-cycle process(es)
											)
begin

-- <default outputs>
Status(2 downto 0) <= "000"; -- both statuses '0' by default 
Result1 <= (others=>'0');
Result2 <= (others=>'0');
Debug <= (others=>'0');

n_state <= state;

B <= Operand2;
--C_in <= '0';
-- </default outputs>

--reset
if Control(5) = '1' then
	n_state <= COMBINATIONAL;
else

case state is
	when COMBINATIONAL =>
		case Control(4 downto 0) is
		--and
		when "00000" =>   -- takes 0 cycles to execute
			Result1 <= Operand1 and Operand2;
		--or
		when "00001" =>
			Result1 <= Operand1 or Operand2;
		--nor
		when "01100" => 
			Result1 <= Operand1 nor Operand2;
			
		--add
		when "00010" =>
			Result1 <= SUM;
			-- overflow
			-- Sign bit (MSB) of the operands are the same, and is different from that of the result
			Status(1) <= ( Operand1(width-1) xnor  Operand2(width-1) )  and ( Operand2(width-1) xor SUM(width-1) );
			
		-- sub
		when "00110" =>
			--B <= not(Operand2);
			--C_in <= '1';
			Result1 <= SUM;
			-- overflow
			--Sign bit (MSB) of the operands are different, and the result has a sign same as that of the second operand
			Status(1) <= ( Operand1(width-1) xor Operand2(width-1)) and ( Operand2(width-1) xnor SUM(width-1));
			--zero
			if SUM = x"00000000" then 
				Status(0) <= '1'; 
			else
				Status(0) <= '0';
			end if;
			
		--slt
		when "00111" =>
		
		--SUM(31) is the MSB
		--Result1 = 0x01 if operand1 < operand2
		--Result1 = 0x00 if operand1 > operand2
		--MSB of sum will be set to one during subtraction if operand2 > operand1
		--This is because sum is negative
		
			Result1 <= (0 => SUM(31), others => '0');
			Result2 <= (others => 'X');
			Status(0) <= 'X';
			Status(1) <= 'X';
				
		--sltu
		when "01110" =>	
		
			--Operand1 is definitely > than Operand2
			if Operand1(31) = '1' and Operand2(31) = '0' then
				Result1 <= (others => '0');
				
			--Operand2 is definitely > than Operand1	
			elsif Operand1(31) = '0' and Operand2(31) = '1' then
				Result1 <= (0 => '1', others => '0');
			--MSB of both operands are the same			
			else
				Result1 <= (0 => SUM(31), others => '0');
			end if;
			
			Status(0) <= 'X';
			Status(1) <= 'X';	
			
			--Shifter outputs
			-- for SLL, SRL, and SRA
		when "00101" | "01101" | "01001" =>
			
				Result1 <= Shift_Output;				
			
		-- multi-cycle operations
		when "10000" | "11110" => 
			n_state <= MULTI_CYCLE;
			Status(2) <= '1';
		-- default cases (already covered)
		when others=> null;
		end case;
	when MULTI_CYCLE => 
		if done = '1' then
			Result1 <= Result1_multi;
			Result2 <= Result2_multi;
			Debug <= Debug_multi;
			n_state <= COMBINATIONAL;
			Status(2) <= '0';
		else
			Status(2) <= '1';
			n_state <= MULTI_CYCLE;
		end if;
	end case;
end if;	
end process;


----------------------------------------------------------------------------
-- STATE UPDATE PROCESS
----------------------------------------------------------------------------

STATE_UPDATE_PROCESS : process (Clk) -- state updating
begin  
   if (Clk'event and Clk = '1') then
		state <= n_state;
   end if;
end process;

----------------------------------------------------------------------------
-- MULTI CYCLE PROCESS
----------------------------------------------------------------------------

MULTI_CYCLE_PROCESS : process (Clk) -- multi-cycle operations done here
-- assume that Operand1 and Operand 2 do not change while multi-cycle operations are being performed
variable count : std_logic_vector(15 downto 0) := (others => '0');
variable temp_sum : std_logic_vector(2*width-1 downto 0) := (others => '0');
begin  
   if (Clk'event and Clk = '1') then 
		if Control(5) = '1' then
			count := (others => '0');
			temp_sum := (others => '0');
		end if;
		done <= '0';
		if n_state = MULTI_CYCLE then
			case Control(4 downto 0) is
			when "10000" =>  -- takes 16 cycles to execute, returns Operand1<<16 ( a terrible way of doing shift - adding the number 16 times :P )
				if state = COMBINATIONAL then  -- n_state = MULTI_CYCLE and state = COMBINATIONAL implies we are just transitioning into MULTI_CYCLE
					temp_sum := (others => '0');
					count := (others => '0');					
				end if;		
				count := count+1;	
				temp_sum := temp_sum + Operand1;
				if count=x"0010" then	
					Result1_multi <= temp_sum(width-1 downto 0);
					Result2_multi <= temp_sum(2*width-1 downto width);
					Debug_multi <= Operand1(width/2-1 downto 0) & Operand2(width/2-1 downto 0); -- just a random output
					done <= '1';	
				end if;
			when "11110" => -- takes 1 cycle to execute, just returns the operands
				if state = COMBINATIONAL then
					Result1_multi <= Operand1;
					Result2_multi <= Operand2;
					Debug_multi <= Operand1(width-1 downto width/2) & Operand2(width-1 downto width/2);
					done <= '1';
				end if;	
			when others=> null;
			end case;
		end if;
	end if;
end process;


end Behavioral;


------------------------------------------------------------------
-- Adder Entity
------------------------------------------------------------------

--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

--entity adder is
--generic (width : integer := 32);
--port (A 		: in std_logic_vector(width-1 downto 0);
		--B 		: in std_logic_vector(width-1 downto 0);
		--C_in 	: in std_logic;
		--S 		: out std_logic_vector(width-1 downto 0);
		--C_out	: out std_logic);
--end adder;

------------------------------------------------------------------
-- Adder Architecture
------------------------------------------------------------------

--architecture adder_arch of adder is
--signal S_wider : std_logic_vector(width downto 0);
--begin
--	S_wider <= ('0'& A) + ('0'& B) + C_in;
--	S <= S_wider(width-1 downto 0);
--	C_out <= S_wider(width);
--end adder_arch;