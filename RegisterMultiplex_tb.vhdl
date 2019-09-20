-- file : RegisterMultiplex_tb.vhdl
-- description : test bench for the File RegisterMultiplex.vhdl 

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity RegisterMultiplex_tb is

end RegisterMultiplex_tb;

architecture test of RegisterMultiplex_tb is

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

	--test signals 
	signal input_bank_test : std_logic_vector((32*8)-1 downto 0) := (others => '0');
    signal source_test : std_logic_vector(31 downto 0) := (others => '0');
	signal sel_test : std_logic_vector(4 downto 0) := (others => '0');
	signal clk_test : std_logic := '0';
	constant clock_period : time := 1ns;

begin
	clk_proc : process is
	
	begin
        wait for clock_period/2;
        clk_test <= not(clk_test);
    end process;
	
	
	Test : RegisterMultiplex 
    generic map(
        bus_size => 32
    )
    port map(
        source => source_test,
        sel => sel_test,
        out_0 => input_bank_test(7 downto 0),
        out_1 => input_bank_test(15 downto 8),
        out_2 => input_bank_test(23 downto 16),
        out_3 => input_bank_test(31 downto 24),
        out_4 => input_bank_test(39 downto 32),
        out_5 => input_bank_test(47 downto 40),
        out_6 => input_bank_test(55 downto 48),
        out_7 => input_bank_test(63 downto 56),
        out_8 => input_bank_test(71 downto 64),
        out_9 => input_bank_test(79 downto 72),
        out_10 => input_bank_test(87 downto 80),
        out_11 => input_bank_test(95 downto 88),
        out_12 => input_bank_test(103 downto 96),
        out_13 => input_bank_test(111 downto 104),
        out_14 => input_bank_test(119 downto 112),
        out_15 => input_bank_test(127 downto 120),
        out_16 => input_bank_test(135 downto 128),
        out_17 => input_bank_test(143 downto 136),
        out_18 => input_bank_test(151 downto 144),
        out_19 => input_bank_test(159 downto 152),
        out_20 => input_bank_test(167 downto 160),
        out_21 => input_bank_test(175 downto 168),
        out_22 => input_bank_test(183 downto 176),
        out_23 => input_bank_test(191 downto 184),
        out_24 => input_bank_test(199 downto 192),
        out_25 => input_bank_test(207 downto 200),
        out_26 => input_bank_test(215 downto 208),
        out_27 => input_bank_test(223 downto 216),
        out_28 => input_bank_test(231 downto 224),
        out_29 => input_bank_test(239 downto 232),
        out_30 => input_bank_test(247 downto 240),
        out_31 => input_bank_test(256 downto 248)
    );
	
	process test is
	
	begin
		source_test <= x"DEADBEEF";
		for i in 0 to 31 loop
			wait for clock_period*2;
			sel_test <= sel_test + 1;
		end loop
		
		assert false
			report "END OF TEST"
			severity FAILURE;
	
	end process;
end test;