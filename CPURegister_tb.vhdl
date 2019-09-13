-- file : CPURegister_tb.vhdl
-- brief : Simulation to test the 32 bit CPU register

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity CPURegister_tb is

end CPURegister_tb;

architecture test of CPURegister_tb is
    component CPURegister is
    port(
        clk : in std_logic;	                                    --clock signal that drives all functionality
        reset : in std_logic;                                   --sychronous reset line that will clear all data in the register
        data_in : in std_logic_vector(31 downto 0);	            --input signal which will be stored to the data_bank if write enable is set
        write_en : in std_logic;                                --the control line that will enable the writing of the data_bank
        read_en : in std_logic;	                                --the control line that will enable the reading of the data_bank
        data_out : out std_logic_vector(31 downto 0)            --output signal that will hold the data store in data_bank when read enable is set
    );
    end component;
    
    --test signals
    signal clock_in_test : std_logic := '0';
    signal reset_in_test : std_logic := '0';
    signal data_in_test : std_logic := '0';
    signal write_enable_test : std_logic := '0';
    signal read_enable_test : std_logic := '0';
    signal data_out_test : std_logic := '0';
    constant clock_period : time := 1 ns;
    
begin
    
    CPU_register_test_unit : CPURegister port map(
        clk => clock_in_test,
        reset => reset_in_test,
        data_in => data_in_test,
        write_en => write_enable_test,
        read_en => read_enable_test,
        data_out => data_out_test
    );

    --will toggle the clock in the correct manner based on the clock period given.     
    run_clk : process is 
    
    begin
        wait for clock_period/2;
        clk_test <= not(clk_test);
    end process;
    
    test : process is
        
    begin
        --place some obvious test data into the register
        data_in_test <= x"DEADBEEF";
        wait for clock_period*4;
        --the output should not change because the read enable line is still low
        assert not(data_out_test = x"00000000")
            report "READ DISABLED"
            severity NOTE;
        --enable the read line to check that the data is still zero
        read_enable_test <= '1';
        wait for clock_period*2;
        --the data should still be zero at the output because write_en is still low
        assert not(data_out_test = x"00000000")    
            report "WRITE DISABLED"
            severity NOTE;
        read_enable_test <= '0';
        write_enable_test <= '1';
        --now enable the write line so that 
        wait for clock_period*2;
        --the read should still be zero because it was not enabled
        assert not(data_out_test = x"00000000")
            report "WRITE ENABLED READ DISABLED"
            severity NOTE;
        write_enable_test <= '0';
        read_enable_test <= '1';
        wait for clk_period;
        --now the output should reflect the internal storage
        assert not(data_out_test = x"DEADBEEF")
            report "WRITE ENABLED READ ENABLED"
            severity NOTE;
        reset_enable_test <= '1';    
        wait for clk_period;
        --the data should reset to zero with the line going high
        assert not(data_out_test = x"00000000")
            report "RESET COMPLETE"
            severity NOTE;
        reset_enable_test <= '0';
        wait for clk_period;
        assert False
            report "END OF TEST"
            severity ERROR;
    end process;
end 1test;