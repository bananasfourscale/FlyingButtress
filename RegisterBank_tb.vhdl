-- file : RegisterBank_tb.vhdl
-- brief : Simulation to test the 32 register storage bank for all the CPU registers

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use IEEE.math_real.all;

entity RegisterBank_tb is

end RegisterBank_tb;

architecture test of RegisterBank_tb is
	component RegisterBank is
		generic(
			reg_count : integer := 32;
			reg_size : integer := 32
		);
		port(
            clk : in std_logic;                                     --clock signal that drives all functionality
            reset : in std_logic;                                   --sychronous reset line that will clear all data in all registers
            write_en : in std_logic;                                --enable writing to one of the regsiters based on the given wrtie_addr
            write_bank_data : in std_logic_vector(reg_size-1 downto 0);     --the data what will be written to the selected register when the enable line is set
            write_addr : in std_logic_vector(integer(ceil(log2(real(reg_size))))-1 downto 0);           --selectes which of the 32 registers to write to when the enable line is set
            read_1_addr : in std_logic_vector(integer(ceil(log2(real(reg_size))))-1 downto 0);           --the address of the first register to read out from the instruction
            read_2_addr : in std_logic_vector(integer(ceil(log2(real(reg_size))))-1 downto 0);           --the address of the second register to read out from the instruction
            reg_1_data : out std_logic_vector(reg_size-1 downto 0);         --the data out of the first register read out based on the given address
            reg_2_data : out std_logic_vector(reg_size-1 downto 0)          --the data out of the second register read out based on the given address
        );
	end component;
	
	--test signals
    constant reg_count : integer := 32;
    constant reg_size : integer := 32;
	
    signal clock_in_test : std_logic := '0';
    signal reset_in_test : std_logic := '0';
	signal write_en_test : std_logic := '0';
	signal write_bank_data_test : std_logic_vector((reg_size-1) downto 0) := (others => '0');
	signal write_addr_test : std_logic_vector(integer(ceil(log2(real(reg_size))))-1 downto 0) := (others => '0');
	signal read_1_addr_test : std_logic_vector(integer(ceil(log2(real(reg_size))))-1 downto 0) := (others => '0');
	signal read_2_addr_test : std_logic_vector(integer(ceil(log2(real(reg_size))))-1 downto 0) := (others => '1');
	signal reg_1_data_test : std_logic_vector(reg_size-1 downto 0) := (others => '0');
	signal reg_2_data_test : std_logic_vector(reg_size-1 downto 0) := (others => '0');
	
	constant clock_period : time := 1ns;
begin
    
    test_RegisterBank : RegisterBank
    generic map(
        reg_count => 32,
        reg_size => 32
    )
    port map(
        clk => clock_in_test,
        reset => reset_in_test,
        write_en => write_en_test,
        write_bank_data => write_bank_data_test,
        write_addr => write_addr_test,
        read_1_addr => read_1_addr_test,
        read_2_addr => read_2_addr_test,
        reg_1_data => reg_1_data_test,
        reg_2_data => reg_2_data_test
    );
    
	--will toggle the clock in the correct manner based on the clock period given.     
    run_clk : process is 
    
    begin
        wait for clock_period/2;
        clock_in_test <= not(clock_in_test);
    end process;
	
	test_proc : process is
	   
	begin
	   --trigger the reset to make sure all the registers are cleared
	   reset_in_test <= '1';
	   wait for clock_period;
	   reset_in_test <= '0';
	   wait for clock_period;
	   
	   --increment the address by one to write to each register in turn. 
	   for i in 0 to reg_count-1 loop
	       
	       --increment the address each time through
	       write_addr_test <= std_logic_vector(to_unsigned(i, integer(ceil(log2(real(reg_size))))));
	     
	       --write the address count to the register, so each has a unique entry for easier debug
	       write_bank_data_test <= std_logic_vector(to_unsigned(i, reg_size));
	       
	       --advance time to make sure that we arn't writing without the enable.
	       wait for clock_period;
	       write_en_test <= '1';
	       
	       --now check that the data is indeed written correctly.
	       wait for clock_period;
	       write_en_test <= '0';
	       wait for clock_period;
	       
	   end loop;
	   
	   for j in 0 to reg_count-1 loop
           --advance the two read addresses
	       read_1_addr_test <= read_1_addr_test + 1;
	       read_2_addr_test <= read_2_addr_test - 1;
	       wait for clock_period;
       end loop;
	   assert false
	       report "END OF TEST"
           severity FAILURE;
	end process;

end test;