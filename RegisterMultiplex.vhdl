-- file : RegisterMuiltiplex.vhdl
-- brief : Somewhat generic multiplexer which is used to route both data and control signals

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity RegisterMultiplex is
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
end RegisterMultiplex;

architecture Behave of RegisterMultiplex is

begin
    process (sel, source) is
    
    begin
        case sel is
            when b"00000" =>
                out_0 <= source; 
            when b"00001" =>
                out_1 <= source;
            when b"00010" =>
                out_2 <= source;
            when b"00011" =>
                out_3 <= source; 
            when b"00100" =>
                out_4 <= source; 
            when b"00101" =>
                out_5 <= source; 
            when b"00110" =>
                out_6 <= source; 
            when b"00111" =>
                out_7 <= source;
            when b"01000" =>
                out_8 <= source; 
            when b"01001" =>
                out_9 <= source; 
            when b"01010" =>
                out_10 <= source;
            when b"01011" =>
                out_11 <= source;
            when b"01100" =>
                out_12 <= source;
            when b"01101" =>
                out_13 <= source;
            when b"01110" =>
                out_14 <= source;
            when b"01111" =>
                out_15 <= source;
            when b"10000" =>
                out_16 <= source;
            when b"10001" =>
                out_17 <= source; 
            when b"10010" =>
                out_18 <= source; 
            when b"10011" =>
                out_19 <= source; 
            when b"10100" =>
                out_20 <= source; 
            when b"10101" =>
                out_21 <= source; 
            when b"10110" =>
                out_22 <= source; 
            when b"10111" =>
                out_23 <= source; 
            when b"11000" =>
                out_24 <= source; 
            when b"11001" =>
                out_25 <= source; 
            when b"11010" =>
                out_26 <= source; 
            when b"11011" =>
                out_27 <= source; 
            when b"11100" =>
                out_28 <= source; 
            when b"11101" =>
                out_29 <= source; 
            when b"11110" =>
                out_30 <= source; 
            when b"11111" =>
                out_31 <= source;        
        end case;
    end process;

end Behave;
