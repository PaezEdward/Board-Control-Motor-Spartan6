----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:35:56 09/26/2021 
-- Design Name: 
-- Module Name:    State_Machine_Stepper_Motor - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity State_Machine_Stepper_Motor is
    Port ( CLK_1KHz : in  STD_LOGIC;
           Bouton_UP : in  STD_LOGIC;
           Bouton_DOWN : in  STD_LOGIC;
           In_Freq_Motor : in  STD_LOGIC_VECTOR (7 downto 0);
           RESET : in  STD_LOGIC;
			  Out_Freq_Motor : out  STD_LOGIC_VECTOR (7 downto 0);
           Cmd_Demi_Pas : out  STD_LOGIC_VECTOR (3 downto 0);
           LED_UP_Freq : out  STD_LOGIC;
           LED_Down_Freq : out  STD_LOGIC);
end State_Machine_Stepper_Motor;

architecture Behavioral of State_Machine_Stepper_Motor is

TYPE etat IS (attente,position1,position2,position3,position4,position5,position6,position7,position8);
SIGNAL state_machine: etat;
SIGNAL count4 : INTEGER range 0 to 1000 := 0; --16 bits compteur
SIGNAL clock_int4: STD_LOGIC :='0';
signal M : INTEGER range 0 to 1000;
begin

--Divise par M en fonction de In_Freq_Motor--
PROCESS(CLK_1KHz,M,RESET,In_Freq_Motor)
BEGIN
if RESET='1' then
   clock_int4 <='0';
	count4 <=0;
elsif rising_edge(CLK_1KHz) then
   M <= 1000/conv_integer(In_Freq_Motor);
  	IF count4 <= M-1 THEN
      count4 <= count4 + 1;
		ELSE
      count4 <=0;
   END IF;
	IF count4 <= M/2 THEN --à la moitié du comptage on change la valeur de clock_1Hz_int (rapport cyclique = 1/2)
      clock_int4 <= '0';
   ELSE
      clock_int4 <= '1';
   END IF;

end if;
END PROCESS;

--state machine moteur pas a pas--
process(clock_int4,RESET,Bouton_UP,Bouton_DOWN)
 begin
 if RESET='1' then
 state_machine <= attente;
 Cmd_Demi_Pas <="0000";
 elsif rising_edge(clock_int4) then 
 case state_machine is   

 when attente => Cmd_Demi_Pas <="0000";  --0--
                 if Bouton_UP = '1' and Bouton_DOWN='0' then
                    state_machine <= position1;
					 
					  elsif Bouton_UP = '0' and Bouton_DOWN='1' then
                    state_machine <= position8;
						  
					  else
                    state_machine <= attente;  
					  end if;
					  	  
                       --UP & DOWN--
 when position1  => Cmd_Demi_Pas <="0001";  --1--
                 if Bouton_UP = '1' and Bouton_DOWN='0' then
                    state_machine <= position2;
									  
					  elsif Bouton_UP = '0' and Bouton_DOWN='1' then
					     state_machine <= position8;  --9-- 
					  
					  else
                    state_machine <= attente;  
					  end if;
					  
 when position2  => Cmd_Demi_Pas <="0011";  --3--
                 if Bouton_UP = '1' and Bouton_DOWN='0' then
                    state_machine <= position3;
										  
					  elsif Bouton_UP = '0' and Bouton_DOWN='1' then
                    state_machine <= position1;   --1--
						  
					  else
                    state_machine <= attente;  
					  end if;

 when position3  => Cmd_Demi_Pas <="0010";  --2--
                 if Bouton_UP = '1' and Bouton_DOWN='0' then
                    state_machine <= position4;
					  				  
					  elsif Bouton_UP = '0' and Bouton_DOWN='1' then
                    state_machine <= position2;   --3--
					  
					  else
                    state_machine <= attente;  
					  end if;
					  
 when position4  => Cmd_Demi_Pas <="0110";  --6--
                 if Bouton_UP = '1' and Bouton_DOWN='0' then
                    state_machine <= position5;
					  					  
					  elsif Bouton_UP = '0' and Bouton_DOWN='1' then
                    state_machine <= position3;   --2--

					  else
                    state_machine <= attente;  
					  end if;
					  
 when position5  => Cmd_Demi_Pas <="0100";  --4--
                 if Bouton_UP = '1' and Bouton_DOWN='0' then
                    state_machine <= position6;
					  					  
					  elsif Bouton_UP = '0' and Bouton_DOWN='1' then
                    state_machine <= position4;   --6--

					  else
                    state_machine <= attente;  
					  end if;
					  
 when position6  => Cmd_Demi_Pas <="1100";  --12--
                 if Bouton_UP = '1' and Bouton_DOWN='0' then
                    state_machine <= position7;
					  					  
					  elsif Bouton_UP = '0' and Bouton_DOWN='1' then
                    state_machine <= position5;   --4--
					 				 
					  else
                    state_machine <= attente;  
					  end if;
 
 when position7  => Cmd_Demi_Pas <="1000";  --8--
                 if Bouton_UP = '1' and Bouton_DOWN='0' then
                    state_machine <= position8;
					 					  
					  elsif Bouton_UP = '0' and Bouton_DOWN='1' then
                    state_machine <= position6;   --12--
									  					  					  
					  else
                    state_machine <= attente;  
					  end if;
 
 when position8 => Cmd_Demi_Pas <="1001";  --9--
                 if Bouton_UP = '1' and Bouton_DOWN='0' then
                    state_machine <= position1;
					  					  
					  elsif Bouton_UP = '0' and Bouton_DOWN='1' then
                    state_machine <= position7;   --8--
					  
                 else
                    state_machine <= attente;  
					  end if;
 
end case;
end if;
end process;

Out_Freq_Motor <= std_logic_vector(In_Freq_Motor);
LED_UP_Freq <= Bouton_UP;
LED_Down_Freq <= Bouton_DOWN;


end Behavioral;

