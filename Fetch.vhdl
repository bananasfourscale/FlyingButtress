-- file : Fetch.vhdl
-- description : The first stage of the basic execution cycle, the fetch hardware must manage the program counter, and gathering instructions from the program memory space. 



library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity Fetch is
        generic(
                clk_period : time := 1 ns
        );
	port(
                clk : in std_logic;                                           --the system clock which drives the controller (!!THIS MUST MATCH THE PROGRAM MEMORY CLOCK)
		reset : in std_logic;                                         --indicates that a system reset has taken place and the program counter should be reset to the reset address. 
		reset_addr : in std_logic_vector(31 downto 0);                --the address to reset to based on the type of reset that was detected. Variable based on the resets of the running program.
                PC_modify : in std_logic;                                     --indicate that the PC is to be modified. This should be done before the next instruction fetch if the prediction is good. 
                PC_mod_addr : in std_logic_vector(31 downto 0);               --this is the new address provided by jumps or branches which musst update the program counter.
		program_addr : out std_logic_vector(31 downto 0)              --this is the current program counter address going out to the program memory.  
	);
end Fetch;

architecture Behave of Fetch is 
--The Mysterious program counter 
signal Program_Counter : std_logic_vector(31 downto 0);
begin
        -- the program counter is directly connected to the program_addr output signal so that as soon as it changes the out will also change
        program_addr <= Program_Counter;
        
        -- change the program counter based on the control signals
        PC_change : process(clk, PC_modify, PC_mod_addr) is
        
        begin
                if rising_edge(clk) then -- only change on a rising edge
                        -- if reset is high then reset to the selected address
                        if reset = '1' then 
                                Program_Counter <= reset_addr;
                        -- if a jump or branch command has come in then modify the PC accordingly
                        elsif PC_modify = '1' then
                                Program_Counter <= PC_mod_addr;
                        -- if there are no special conditions, then the PC increments to the next address. 
                        else
                                Program_Counter <= Program_Counter + 4; -- a standard increment is 4 bytes or 1 full address word. 
                        end if;
                end if;
        end process;

end Behave;

