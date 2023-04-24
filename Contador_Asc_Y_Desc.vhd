library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity Contador_Asc_Y_Desc is
    Port ( clk, reset, enable, load : in STD_LOGIC;
           contDe : out integer;
           contUn : out integer;
           alarma      : out std_logic
           );
end Contador_Asc_Y_Desc;

architecture arch_count of Contador_Asc_Y_Desc is

    signal Desc : integer range 0 to 35 := 35;
    signal Asc : integer range 0 to 63;
    signal carga : integer := 0;
    signal conversor : std_logic_vector(1 downto 0);
    
begin

    process (clk, reset)

    constant data : integer :=  35;
    variable data_in : STD_LOGIC_VECTOR (5 downto 0);

    begin

        if carga = 0 then

            if reset = '0' then
                Desc <= 35;
                
                elsif (rising_edge(clk)) then
                
                    if enable = '1' then
                
                        if load = '1' then
                
                            Desc <= data;
                
                            if (Desc = 0) then
                                Desc <= data;
                                carga <= 1;
                
                            else
                                Desc <= Desc - 1;
                            end if;
                        end if;
                    end if;
                
                if enable = '1' then
                
                    if load = '0' then
                
                        Desc <= data;
                    end if;
                end if;
                
                if enable = '0' then
                    
                    if load = '0' then
                
                    Desc <= data;
                    end if;
                end if;
            end if;
            
            contDe <= Desc / 10;
            contUn <= Desc mod 10;

        end if;
        
        if carga = 1 then
            if reset = '0' then
                Asc <= 0;
                    
                elsif (rising_edge(clk)) then
                
                    if enable = '1' then
                        
                            if load = '1' then
                                
                                Asc <= to_integer(unsigned(data_in));
                                
                                    if (Asc = 63) then
                                        Asc <= 0;
                                        else
                                            Asc <= Asc + 1;
                                    end if;
                            end if;
                    end if;
                        
                    if enable = '1' then
                        
                        if load = '0' then
                                
                            Asc <= to_integer(unsigned(data_in));
                        end if;
                    end if;	
                            
                    if enable = '0' then
                        
                        if load = '0' then
                                
                            Asc <= to_integer(unsigned(data_in));
                        end if;
                    end if;
            end if;

            contDe <= Asc / 10;
            contUn <= Asc mod 10;
        end if;
    end process;
    
    conversor <= std_logic_vector(to_unsigned(carga, 2));
    alarma <= conversor(0);
end arch_count;