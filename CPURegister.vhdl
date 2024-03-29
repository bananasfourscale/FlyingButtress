-- file : CPURegister.vhdl
-- description : Represents a single 32-bit CPU register.


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity CPURegister is
    generic(
        reg_size : integer := 32
    );
    port(
        clk : in std_logic;	                                    --clock signal that drives all functionality
        reset : in std_logic;                                   --sychronous reset line that will clear all data in the register
        data_in : in std_logic_vector(reg_size-1 downto 0);	            --input signal which will be stored to the data_bank if write enable is set
        write_en : in std_logic;                                --the control line that will enable the writing of the data_bank
        data_out : out std_logic_vector(reg_size-1 downto 0)            --output signal that will hold the data store in data_bank when read enable is set
    );
	
end CPURegister;

architecture Behave of CPURegister is
--the data bank that holds the data internal to the register
signal data_bank : std_logic_vector(reg_size-1 downto 0) := (others => '0');
begin
	
	--the output signal is always tied to the interal storage. 
	data_out <= data_bank;
	
	--process to write the internal storage when the clock rises and the write enable is set
    write_proc : process(clk, reset, write_en) is 
    
    begin
        if rising_edge(clk) then --only operate on the rising edge of the clock
            --if the reset line is high then clear the data_bank
            if reset = '1' then
                data_bank <= (others => '0');
            else
                --if the write enable line is set, transfer the input data to the internal data_bank
                if write_en = '1' then
                    data_bank <= data_in;
                else
                    data_bank <= data_bank;
                end if;
            end if;
        end if;
    end process;
	
end Behave;
