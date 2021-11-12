----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:19:21 09/26/2021 
-- Design Name: 
-- Module Name:    Codeur_Numerique - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Codeur_Numerique is
    Port ( CLK_1KHz : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           Rotary_A : in  STD_LOGIC;
           Rotary_B : in  STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR (7 downto 0));
end Codeur_Numerique;

architecture Behavioral of Codeur_Numerique is

type etat_codeur is(S1,S2,S3,S4,S5,S6,S7);  -- declaration  de la machine d'état et du nombre d'état--
signal etat : etat_codeur;
signal compteur: INTEGER range 0 to 255;	-- déclaration d'un compteur 8 bits qui servira à charger le DAC via la liaison SPI--

-- process machine d'état encodeur numérique--
begin
process(CLK_1KHz,RESET,Rotary_A,Rotary_B)  -- liste de sensibilité toujours des entrées ou des signaux déclarés--
begin
if reset ='1' then

	 Output <="00000000";   -- on s'assure que le compteur de sortie soit à zéro à l'initialisation --
	 compteur <= 0;  -- compteur interne à zéro à l'initialisation--
	 etat <= S1;     -- on va à l'état S1 --
	 	 
elsif CLK_1KHz'event and CLK_1KHz ='1' then

case etat is  -- machine d'état on décrit tous les cas possibles--

  	  when S1=>  if rotary_A ='1' and rotary_B = '1' then  -- si pas d'action on reste en S1--
				    etat <= S1;
	   		    
      	       elsif rotary_A ='0' and rotary_B = '1' then   -- si rotation  CW  --
			       etat <= S2;
					  					  
					 elsif rotary_A ='1' and rotary_B = '0' then   -- si rotation  CCW --
			       etat <= S5;
					 end if; 
			 
    when S2=>   if rotary_A ='0' and rotary_B = '0' then
					 etat <= S3;
					 end if;

		 
    when S3=>   if rotary_A ='1' and rotary_B = '0' then
					 etat <= S4;
					 end if;

    when S4=>   if rotary_A ='1' and rotary_B = '1' then
                compteur <= compteur + 1;
                etat <= S1;
       		    end if;
								 
	 when S5=>   if rotary_A ='0' and rotary_B = '0' then
	             etat <= S6;
	   	   	 end if; 
		            
    when S6=>   if rotary_A ='0' and rotary_B = '1' then
					 etat <= S7;
					 end if;
		 
    when S7=>   if rotary_A ='1' and rotary_B = '1' then
	             compteur <= compteur - 1;
					 etat <= S1;
					 end if;
													  
end case;        
                Output <= CONV_STD_LOGIC_VECTOR(compteur,8);  -- on convertit des entiers en std_logic_vectors, bus logic.
end if;
end process;

end Behavioral;

