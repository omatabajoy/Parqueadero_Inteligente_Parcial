library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity Parqueadero_inteligente is
	port (
    	ParqInt : in std_logic_vector(7 downto 0);
		clk1 		: in std_logic;
		selector	: in std_logic;
		DEC	: out std_logic_vector(6 downto 0);
		UNIT	: out std_logic_vector(6 downto 0);
		Vehiculo		: out std_logic_vector(6 downto 0);
		LED		: out std_logic_vector(7 downto 0)
	);
end Parqueadero_inteligente ;

architecture Parking of Parqueadero_inteligente is

	signal rst 	: STD_LOGIC := '1';
	signal load	: STD_LOGIC := '1';
	signal clock: STD_LOGIC;
	signal clock_2: STD_LOGIC;
	signal contador : integer range 1 to 9 := 1;
	signal op : integer range 1 to 8;

	signal D1 : integer;
	signal D2 : integer;
	signal D3 : integer;
	signal D4 : integer;
	signal D5 : integer;
	signal D6 : integer;
	signal D7 : integer;
	signal D8 : integer;
	
	signal U1 : integer;
	signal U2 : integer;
	signal U3 : integer;
	signal U4 : integer;
	signal U5 : integer;
	signal U6 : integer;
	signal U7 : integer;
	signal U8 : integer;

	signal UNI : integer range 0 to 9;
	signal DECE : integer range 0 to 6;



	component Contador_Asc_Y_Desc
		Port ( clk, reset, enable, load : in STD_LOGIC;
			contDe : out integer;
			contUn : out integer;
			alarma      : out std_logic);
	end component;

	component Div_Frec
		PORT (  clk : IN STD_LOGIC;
				Sal1, Sal2 : BUFFER STD_LOGIC);
	end component;

begin
	rlj1seg: Div_Frec port map (clk => clk1, Sal1 => clock, Sal2 =>clock_2);

	Vehiculo1 : Contador_Asc_Y_Desc port map (clk => clock, reset => rst, enable => ParqInt(0), load => load, contDe => D1,contUn => U1, alarma => LED(0));

	Vehiculo2 : Contador_Asc_Y_Desc port map (clk => clock, reset => rst, enable => ParqInt(1), load => load, contDe => D2,contUn => U2, alarma => LED(1));
	
	Vehiculo3 : Contador_Asc_Y_Desc port map (clk => clock, reset => rst, enable => ParqInt(2), load => load, contDe => D3,contUn => U3, alarma => LED(2));
	
	Vehiculo4 : Contador_Asc_Y_Desc port map (clk => clock, reset => rst, enable => ParqInt(3), load => load, contDe => D4,contUn => U4, alarma => LED(3));
	
	Vehiculo5 : Contador_Asc_Y_Desc port map (clk => clock, reset => rst, enable => ParqInt(4), load => load, contDe => D5,contUn => U5, alarma => LED(4));
	
	Vehiculo6 : Contador_Asc_Y_Desc port map (clk => clock, reset => rst, enable => ParqInt(5), load => load, contDe => D6,contUn => U6, alarma => LED(5));
	
	Vehiculo7 : Contador_Asc_Y_Desc port map (clk => clock, reset => rst, enable => ParqInt(6), load => load, contDe => D7,contUn => U7, alarma => LED(6));
	
	Vehiculo8 : Contador_Asc_Y_Desc port map (clk => clock, reset => rst, enable => ParqInt(7), load => load, contDe => D8,contUn => U8, alarma => LED(7));

	process(selector)

    begin
        if rising_edge(selector) then
            if contador > 8 then
                contador <= 1;
            else
                contador <= contador + 1;
            end if;
        end if;
        op <= contador;
    end process;

	with op select
		UNI <= U1 when 1,
			   U2 when 2,
		      U3 when 3,
			   U4 when 4,
			   U5 when 5,
			   U6 when 6,
			   U7 when 7,
			   U8 when 8;

	with op select
		DECE <= 	D1 when 1,
				D2 when 2,
				D3 when 3,
				D4 when 4,
				D5 when 5,
				D6 when 6,
				D7 when 7,
				D8 when 8;

	process (UNI) begin
		case UNI is 
			when 0 =>UNIT<= "0000001";
			when 1 =>UNIT<= "1001111";
			when 2 =>UNIT<= "0010010";
			when 3 =>UNIT<= "0000110";
			when 4 =>UNIT<= "1001100";
			when 5 =>UNIT<= "0100100";
			when 6 =>UNIT<= "0100000";
			when 7 =>UNIT<= "0001111";
			when 8 =>UNIT<= "0000000";
			when 9 =>UNIT<= "0000100";
			when others  =>UNIT<= "1111111";
		end case;
	end process;
		
	process (DECE) begin
		case DECE is
			when 1 =>DEC<= "1001111";
			when 2 =>DEC<= "0010010";
			when 3 =>DEC<= "0000110";
			when 4 =>DEC<= "1001100";
			when 5 =>DEC<= "0100100";
			when 6 =>DEC<= "0100000";
			when others  =>DEC<= "1111111";
		end case;
	end process;

	process (op) begin
		case op is 
			when 1 =>Vehiculo<= "1001111";
			when 2 =>Vehiculo<= "0010010";
			when 3 =>Vehiculo<= "0000110";
			when 4 =>Vehiculo<= "1001100";
			when 5 =>Vehiculo<= "0100100";
			when 6 =>Vehiculo<= "0100000";
			when 7 =>Vehiculo<= "0001111";
			when 8 =>Vehiculo<= "0000000";
			when others  =>Vehiculo<= "1111111";
		end case;
	end process;
end architecture ;