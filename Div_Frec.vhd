LIBRARY ieee;
USE ieee.std_logic_1164.all;
--------------------------------------------------------
ENTITY Div_Frec IS
    PORT (  clk : IN STD_LOGIC;
            Sal1, Sal2 : BUFFER STD_LOGIC);
END Div_Frec;
--------------------------------------------------------
ARCHITECTURE Divisor OF Div_Frec IS  
        SIGNAL contador1: INTEGER RANGE 0 TO 50000000;
       
    BEGIN
        PROCESS (clk)
VARIABLE contador2: INTEGER RANGE 0 TO 50000000;
        BEGIN
            IF (clk' EVENT AND clk='1') THEN
                contador1 <= contador1 + 1;
                contador2 := contador2 + 1;
               
                IF (contador1 = 24999999 ) THEN
                    Sal1 <= NOT Sal1;
                    contador1 <= 1;
                END IF;
               
                IF (contador2 = 25000000 ) THEN
                    Sal2 <= NOT Sal2;
                    contador2 := 1;
                END IF;
            END IF;
        END PROCESS;
END Divisor;
