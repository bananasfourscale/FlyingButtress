entity Fetch is 
	port(
		clk : in std_logic;
		PC_modify : in std_logic; --indicate that the PC is to be modified. This should be done before the next instruction fetch if the prediction is good. 
		PC_mod_addr : in std_logic_vector(31 downto 0): --this is the new address provided by jumps or branches which musst update the program counter.
		program_addr : out std_logic_vector(31 downto 0); 
		instruction : out std_logic_vector(31 downto 0);
	);
end Fetch

architecture Behave of Fetch is 
--The Mysterious program counter 
signal Program_Counter : std_logic_vector(31 downto 0);
begin

end Behave;

