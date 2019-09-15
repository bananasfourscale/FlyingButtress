-- file : RegisterBank.vhdl
-- description : This unit is part of the second stage of the system pipeline, and holds all 32 of the CPU level registers and is in control of reading from and writting to them. 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity RegisterBank is
    port(
        clk : in std_logic;                                     --clock signal that drives all functionality
        reset : in std_logic;                                   --sychronous reset line that will clear all data in all registers
        write_en : in std_logic;                                --enable writing to one of the regsiters based on the given wrtie_addr
        write_bank_data : in std_logic_vector(31 downto 0);     --the data what will be written to the selected register when the enable line is set
        write_addr : in std_logic_vector(4 downto 0);           --selectes which of the 32 registers to write to when the enable line is set
        reg_1_addr : in std_logic_vector(4 downto 0);           --the address of the first register to read out from the instruction
        reg_2_addr : in std_logic_vector(4 downto 0);           --the address of the second register to read out from the instruction
        reg_1_data : out std_logic_vector(31 downto 0);         --the data out of the first register read out based on the given address
        reg_2_data : out std_logic_vector(31 downto 0)          --the data out of the second register read out based on the given address
    );
	
end RegisterBank;

architecture Structural of RegisterBank is
    component CPURegister is
        port(
            clk : in std_logic;	                                    --clock signal that drives all functionality
            reset : in std_logic;                                   --sychronous reset line that will clear all data in the register
            data_in : in std_logic_vector(31 downto 0);	            --input signal which will be stored to the data_bank if write enable is set
            write_en : in std_logic;                                --the control line that will enable the writing of the data_bank
            data_out : out std_logic_vector(31 downto 0)            --output signal that will hold the data store in data_bank when read enable is set
        );
    end component;
    
    component RegisterMultiplex is
        Generic(
            bus_size : integer := 32
        );
        Port(
            source : in std_logic_vector(bus_size-1 downto 0);
            sel : in std_logic_vector(4 downto 0);
            out_0 : out std_logic_vector(bus_size-1 downto 0);
            out_1 : out std_logic_vector(bus_size-1 downto 0);
            out_2 : out std_logic_vector(bus_size-1 downto 0);
            out_3 : out std_logic_vector(bus_size-1 downto 0);
            out_4 : out std_logic_vector(bus_size-1 downto 0);
            out_5 : out std_logic_vector(bus_size-1 downto 0);
            out_6 : out std_logic_vector(bus_size-1 downto 0);
            out_7 : out std_logic_vector(bus_size-1 downto 0);
            out_8 : out std_logic_vector(bus_size-1 downto 0);
            out_9 : out std_logic_vector(bus_size-1 downto 0);
            out_10 : out std_logic_vector(bus_size-1 downto 0);
            out_11 : out std_logic_vector(bus_size-1 downto 0);
            out_12 : out std_logic_vector(bus_size-1 downto 0);
            out_13 : out std_logic_vector(bus_size-1 downto 0);
            out_14 : out std_logic_vector(bus_size-1 downto 0);
            out_15 : out std_logic_vector(bus_size-1 downto 0);
            out_16 : out std_logic_vector(bus_size-1 downto 0);
            out_17 : out std_logic_vector(bus_size-1 downto 0);
            out_18 : out std_logic_vector(bus_size-1 downto 0);
            out_19 : out std_logic_vector(bus_size-1 downto 0);
            out_20 : out std_logic_vector(bus_size-1 downto 0);
            out_21 : out std_logic_vector(bus_size-1 downto 0);
            out_22 : out std_logic_vector(bus_size-1 downto 0);
            out_23 : out std_logic_vector(bus_size-1 downto 0);
            out_24 : out std_logic_vector(bus_size-1 downto 0);
            out_25 : out std_logic_vector(bus_size-1 downto 0);
            out_26 : out std_logic_vector(bus_size-1 downto 0);
            out_27 : out std_logic_vector(bus_size-1 downto 0);
            out_28 : out std_logic_vector(bus_size-1 downto 0);
            out_29 : out std_logic_vector(bus_size-1 downto 0);
            out_30 : out std_logic_vector(bus_size-1 downto 0);
            out_31 : out std_logic_vector(bus_size-1 downto 0)
        );
    end component;
    
    --internal signals
    signal input_bank : std_logic_vector((32*8)-1 downto 0);
    signal output_bank : std_logic_vector((32*8)-1 downto 0);
    signal write_en_bank : std_logic_vector(32 downto 0);
    
begin
    
    --generate the 32 cpu registes
    Register_gen : for i in 0 to 31 generate
        REG : CPURegister port map(
            clk => clk,
            reset => reset,
            data_in => input_bank(((8*i) + 7) downto (8*i)),
            write_en => write_en_bank(i),
            data_out => output_bank(((8*i) + 7) downto (8*i))
        );
    end generate;
    
    --
    Data_mux_1 : RegisterMultiplex 
    generic map(
        bus_size => 32
    )
    port map(
        source => write_bank_data,
        sel => write_addr,
        out_0 => input_bank(7 downto 0),
        out_1 => input_bank(15 downto 8),
        out_2 => input_bank(23 downto 16),
        out_3 => input_bank(31 downto 24),
        out_4 => input_bank(39 downto 32),
        out_5 => input_bank(47 downto 40),
        out_6 => input_bank(55 downto 48),
        out_7 => input_bank(63 downto 56),
        out_8 => input_bank(71 downto 64),
        out_9 => input_bank(79 downto 72),
        out_10 => input_bank(87 downto 80),
        out_11 => input_bank(95 downto 88),
        out_12 => input_bank(103 downto 96),
        out_13 => input_bank(111 downto 104),
        out_14 => input_bank(119 downto 112),
        out_15 => input_bank(127 downto 120),
        out_16 => input_bank(135 downto 128),
        out_17 => input_bank(143 downto 136),
        out_18 => input_bank(151 downto 144),
        out_19 => input_bank(159 downto 152),
        out_20 => input_bank(167 downto 160),
        out_21 => input_bank(175 downto 168),
        out_22 => input_bank(183 downto 176),
        out_23 => input_bank(191 downto 184),
        out_24 => input_bank(199 downto 192),
        out_25 => input_bank(207 downto 200),
        out_26 => input_bank(215 downto 208),
        out_27 => input_bank(223 downto 216),
        out_28 => input_bank(231 downto 224),
        out_29 => input_bank(239 downto 232),
        out_30 => input_bank(247 downto 240),
        out_31 => input_bank(256 downto 248)
    );
    
end Structural;
