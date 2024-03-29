-- file : Fetch_tb.vhdl
-- description : test bench for the File Fetch.vhdl 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity Fetch_tb is

end Fetch_tb;

architecture test of Fetch_tb is
    -- componet to be tested
    component Fetch is
    port(
        clk : in std_logic;                                           --the system clock which drives the controller (!!THIS MUST MATCH THE PROGRAM MEMORY CLOCK)
        reset : in std_logic;                                         --indicates that a system reset has taken place and the program counter should be reset to the reset address. 
        reset_addr : in std_logic_vector(31 downto 0);                --the address to reset to based on the type of reset that was detected. Variable based on the resets of the running program.
        PC_modify : in std_logic;                                     --indicate that the PC is to be modified. This should be done before the next instruction fetch if the prediction is good. 
        PC_mod_addr : in std_logic_vector(31 downto 0);               --this is the new address provided by jumps or branches which musst update the program counter.
        program_addr : out std_logic_vector(31 downto 0)              --this is the current program counter address going out to the program memory.  
    );
    end component;

    --test signals
    signal clk_test : std_logic := '0';
    signal reset_test : std_logic := '0';
    signal PC_mod_test : std_logic := '0';
    signal reset_address_test : std_logic_vector(31 downto 0) := (others => '0');
    signal PC_address_test : std_logic_vector(31 downto 0) := (others => '0');
    signal program_address_test : std_logic_vector(31 downto 0) := (others => '0');
    constant clock_period : time := 1 ns;
begin
        
    Fetch_test_unit : Fetch port map(
        clk => clk_test,
        reset => reset_test,
        reset_addr => reset_address_test,
        PC_modify => PC_mod_test,
        PC_mod_addr => PC_address_test,
        program_addr => program_address_test
    );        
    
    --will toggle the clock in the correct manner based on the clock period given.     
    run_clk : process is 
    
    begin
        wait for clock_period/2;
        clk_test <= not(clk_test);
    end process;
    
    test : process is
    
    begin 
        --see if the PC can count normally
        wait for clock_period*4;
        --reset the counter to 0
        reset_test <= '1';
        wait for clock_period;
        --check the PC changed
        assert not(program_address_test = x"00000000")
            report "RESET COMPLETE"
            severity NOTE;
        reset_test <= '0';
        wait for clock_period*4;
        --set the address back to 0 with a jump
        PC_mod_test <= '1';
        wait for clock_period;
        --check the FC changed
        assert not(program_address_test = x"00000000")
            report "JUMP TO 0 COMPLETE"
            severity NOTE;
        PC_mod_test <= '0';
        wait for clock_period*16;
        --set the address to a specific address with a jump
        PC_mod_test <= '1';
        PC_address_test <= x"DEADBEEF";
        wait for clock_period;
        PC_mod_test <= '0';
        --check the FC changed
        assert not(program_address_test = x"DEADBEEF")
            report "JUMP TO TEST COMPLETE"
            severity NOTE;
        
        --end the test with a false failure
        assert false
            report "END OF TEST"
            severity FAILURE;
        
    end process;
end test;
