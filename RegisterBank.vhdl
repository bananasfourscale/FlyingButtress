-- file : RegisterBank.vhdl
-- description : This unit is part of the second stage of the system pipeline, and holds all 32 of the CPU level registers and is in control of reading from and writting to them. 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use IEEE.math_real.all;

entity RegisterBank is
    generic(
        reg_count : integer := 32;
        reg_size : integer := 32
    );
    port(
        clk : in std_logic;                                     --clock signal that drives all functionality
        reset : in std_logic;                                   --sychronous reset line that will clear all data in all registers
        write_en : in std_logic;                                --enable writing to one of the regsiters based on the given wrtie_addr
        write_bank_data : in std_logic_vector(reg_size-1 downto 0);     --the data what will be written to the selected register when the enable line is set
        write_addr : in std_logic_vector( downto 0);           --selectes which of the 32 registers to write to when the enable line is set
        read_1_addr : in std_logic_vector(log2(real(reg_size)) downto 0);           --the address of the first register to read out from the instruction
        read_2_addr : in std_logic_vector(log2(real(reg_size)) downto 0);           --the address of the second register to read out from the instruction
        reg_1_data : out std_logic_vector(reg_size-1 downto 0);         --the data out of the first register read out based on the given address
        reg_2_data : out std_logic_vector(reg_size-1 downto 0)          --the data out of the second register read out based on the given address
    );
	
end RegisterBank;

 architecture Structural of RegisterBank is
    component CPURegister is
        port(
            clk : in std_logic;	                                    --clock signal that drives all functionality
            reset : in std_logic;                                   --sychronous reset line that will clear all data in the register
            data_in : in std_logic_vector(reg_size-1 downto 0);	            --input signal which will be stored to the data_bank if write enable is set
            write_en : in std_logic;                                --the control line that will enable the writing of the data_bank
            data_out : out std_logic_vector(reg_size-1 downto 0)            --output signal that will hold the data store in data_bank when read enable is set
        );
    end component;
    
    --internal signals
    signal input_bank : std_logic_vector((reg_count*reg_size)-1 downto 0);
    signal output_bank : std_logic_vector((reg_count*reg_size)-1 downto 0);
    signal write_en_bank : std_logic_vector(reg_size-1 downto 0);
    signal write_en_internal : std_logic; --create a unique internal just to avoid confusion with lower level write_en
    
begin
    
    --pass externals to internals
    write_en_internal <= write_en;
    
    --generate the 32 cpu registes
    Register_gen : for i in 0 to (reg_count-1) generate
        REG : CPURegister port map(
            clk => clk,
            reset => reset,
            data_in => input_bank(((reg_count*i) + (reg_size-1)) downto (reg_count*i)),
            write_en => write_en_bank(i),
            data_out => output_bank(((reg_count*i) + (reg_size-1)) downto (reg_count*i))
        );
    end generate;
    
    write_proc : process(write_en_internal, write_bank_data, write_addr) is
        variable write_addr_var : integer;
    begin
        --convert the input address to an integer for easier indexing.
        write_addr_var := integer(write_addr);
        if(write_en_internal = '1') then
            --if write enable is high, just put the data on the input bank. It will not be written to the Register unless the clock goes high
            input_bank( (reg_count*write_addr_var) + (reg_size-1) downto (reg_count*write_addr_var));
        else
            --otherwise the bank just stays the same
            input_bank <= input_bank; 
        end if;
    end process;
    
    read_proc : process(read_1_addr, read_2_addr) is
        variable read_addr_1_var : integer;
        variable read_addr_2_var : integer;
    begin
        --convert both output addresses to integers for easier indexing.
        read_addr_1_var := integer(read_1_addr);
        read_addr_2_var := integer(read_2_addr);
        
        --relay the correct register output to the two bank outputs based on the two given register addresses
        reg_1_data <= output_bank( (reg_count*read_addr_1_var) + (reg_size-1) downto (reg_count*read_addr_1_var));
        reg_2_data <= output_bank( (reg_count*read_addr_2_var) + (reg_size-1) downto (reg_count*read_addr_2_var));
    end process;
    
end Structural;
