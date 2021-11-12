----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:56:38 09/28/2021 
-- Design Name: 
-- Module Name:    Calcul_Vitesse_Stepper_Motor_et_Affichage - Behavioral 
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
use IEEE.STD_LOGIC_1164.ALL;
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

entity Calcul_Vitesse_Stepper_Motor_et_Affichage is
    Port ( In_Freq_Motor : in  STD_LOGIC_VECTOR (7 downto 0);
           Affichage_Vitesse_Digit3 : out  STD_LOGIC_VECTOR (3 downto 0);
           Affichage_Vitesse_Digit2 : out  STD_LOGIC_VECTOR (3 downto 0);
           Affichage_Vitesse_Digit1 : out  STD_LOGIC_VECTOR (3 downto 0);
           Affichage_Vitesse_Digit0 : out  STD_LOGIC_VECTOR (3 downto 0));
end Calcul_Vitesse_Stepper_Motor_et_Affichage;

architecture Behavioral of Calcul_Vitesse_Stepper_Motor_et_Affichage is
signal Frequence: INTEGER range 0 to 255;
signal N: INTEGER; -- Tours/minutes ou *60 tr/heures
signal Q : STD_LOGIC_VECTOR (11 downto 0);
signal decalage_a_gauche: INTEGER;

begin

Frequence <= conv_integer(In_Freq_Motor);
decalage_a_gauche <= (Frequence * 100000);
N <= (decalage_a_gauche / 4096) * 60;  --tours/s -->tours/minutes @100Hz 1.464 tr/min
Q <= std_logic_vector(to_unsigned(N/100, 12));


process(Q)
  -- variable temporaire 
  variable temp  : STD_LOGIC_VECTOR ( 11 downto 0 ); 
  variable  bcd1  : STD_LOGIC_VECTOR ( 15  downto 0 );

  
begin 
                             --    2    4    3
                            --   0010 0100 0011 
									 
							--	<---------ORIGINAL
				      --000 0000 0000 11110011

--Le double dabble est un algorithme utilisé pour convertir des nombres d'un système-- 
--binaire vers un système décimal. Pour des raisons pratiques, le résultat est-- 
--généralement stocké sous la forme de décimal codé en binaire (BCD)--
--En partant du registre initial, l'algorithme effectue n itérations (soit 8 dans l'exemple)
--a chaque itération, le registre est décalé d'un bit vers la gauche. Avant d'effectuer cette opération, 
--la partie au format BCD est analysée, décimale par décimale. Si une décimale en BCD (4 bits)
--est plus grande que 4 alors on lui ajoute 3. Cette incrément permet de s'assurer qu'une valeur de 5, 
--après incrémentation et décalage, devient 16 et se propage correctement �  la décimale suivante.     
	                 ---   0000 0000 0000 11110011      Initialisation
                    ---   0000 0000 0001 11100110      Décalage
                    ---   0000 0000 0011 11001100      Décalage
                    ---   0000 0000 0111 10011000      Décalage
                    ---   0000 0000 1010 10011000      Ajouter 3 �  la première décimale BCD, puisque sa valeur était 7
                    ---   0000 0001 0101 00110000      Décalage
                    ---   0000 0001 1000 00110000      Ajouter 3 �  la première décimale BCD, puisque sa valeur était 5
                    ---   0000 0011 0000 01100000      Décalage
                    ---   0000 0110 0000 11000000      Décalage
                    ---   0000 1001 0000 11000000      Ajouter 3 �  la seconde décimale BCD, puisque sa valeur était 6
                    ---   0001 0010 0001 10000000      Décalage
                    --    0010 0100 0011 00000000      Décalage
								  --2----4---3--
								  
		--mettre �  zéro la variable bcd 
	 bcd1   := (others => '0');
    
	 --if select_freq_or_vitesse ='1' then    
       temp (11 downto 0) :=  Q ;-- lire le signal Q dans la variable 
	 	 
	 for i in 0 to 11 loop
      

      if bcd1(3 downto 0) > 4 then 
        bcd1(3 downto 0) := bcd1(3 downto 0) + 3;
      end if;
      
      if bcd1(7 downto 4) > 4 then 
        bcd1(7 downto 4) := bcd1(7 downto 4) + 3;
      end if;
    
      if bcd1(11 downto 8) > 4 then  
        bcd1(11 downto 8) := bcd1(11 downto 8) + 3;
      end if;
    
      -- thousands can't be >4 for a 12-bit input number
      -- so don't need to do anything to upper 4 bits of bcd
    
      -- shift bcd left by 1 bit, copy MSB of temp into LSB of bcd
      bcd1 := bcd1(14 downto 0) & temp(11);

      -- shift temp left by 1 bit
      temp := temp(10 downto 0) & '0';
    end loop; 
	 

	 	 	 -- set outputs    		 
          Affichage_Vitesse_Digit0 <=  STD_LOGIC_VECTOR (bcd1(3 downto 0));
          Affichage_Vitesse_Digit1 <=  STD_LOGIC_VECTOR (bcd1(7 downto 4));
          Affichage_Vitesse_Digit2 <=  STD_LOGIC_VECTOR (bcd1(11 downto 8));
          Affichage_Vitesse_Digit3 <=  STD_LOGIC_VECTOR (bcd1(15 downto 12));
			 
       
end process;
end Behavioral;