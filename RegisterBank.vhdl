-- file : RegisterBank.vhdl
-- description : This unit is part of the second stage of the system pipeline, and holds all 32 of the CPU level registers and is in control of reading from and writting to them. 



library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity RegisterBank is
    port(
        clk : in std_logic;
        reset : in std_logic;
        read_en : in std_logic;
        write_en : in std_logic;
        write_bank_data : in std_logic_vector(31 downto 0);
        reg_1_addr : in std_logic_vector(4 downto 0);
        reg_2_addr : in std_logic_vector(4 downto 0);
        reg_1_data : out std_logic_vector(31 downto 0);
        reg_2_data : out std_logic_vector(31 downto 0);
    );
	
end RegisterBank;

architecture Structural of RegisterBank is
	
begin


end Structural;
