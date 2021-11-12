----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:52:37 09/26/2021 
-- Design Name: 
-- Module Name:    Compteur_Binary_to_BCD - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Compteur_Binary_to_BCD is
    Port ( CLK_1KHz : in  STD_LOGIC;
           Bouton_UP : in  STD_LOGIC;
           Bouton_DOWN : in  STD_LOGIC;
           ENABLE : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           In_Freq_Motor : in  STD_LOGIC_VECTOR (7 downto 0);
           BCD_U : out  STD_LOGIC_VECTOR (3 downto 0);
           BCD_D : out  STD_LOGIC_VECTOR (3 downto 0);
           BCD_H : out  STD_LOGIC_VECTOR (3 downto 0);
           BCD_T : out  STD_LOGIC_VECTOR (3 downto 0);
           LED_Full : out  STD_LOGIC;
           LED_Empty : out  STD_LOGIC);
end Compteur_Binary_to_BCD;

architecture Behavioral of Compteur_Binary_to_BCD is

SIGNAL count3 : INTEGER range 0 to 1000 := 0; --16 bits compteur
SIGNAL clock_int3: STD_LOGIC;
signal M : INTEGER range 0 to 1000;

signal COUNTER_U: INTEGER range 0 to 9;
signal COUNTER_D: INTEGER range 0 to 9;
signal COUNTER_H: INTEGER range 0 to 9;
signal COUNTER_T: INTEGER range 0 to 9;

signal IS_4096: STD_LOGIC;
signal IS_0000: STD_LOGIC;
begin

--Divise par M en fonction de In_Freq_Motor--
PROCESS(CLK_1KHz,RESET,ENABLE,M,In_Freq_Motor)
BEGIN
if RESET ='1' then 
   count3 <= 0;
elsif rising_edge(CLK_1KHz) then
if ENABLE ='1' then
   M <= 1000/conv_integer(In_Freq_Motor);
	IF count3 <= M-1 THEN
      count3 <= count3 + 1;
   ELSE
      count3 <= 0;
   END IF;
	IF count3 <= M/2 THEN --à la moitié du comptage on change la valeur de clock_1Hz_int (rapport cyclique = 1/2)
      clock_int3 <= '0';
   ELSE
      clock_int3 <= '1';
   END IF;
end if;
end if;
END PROCESS;


process(clock_int3,ENABLE,RESET,Bouton_UP,Bouton_DOWN)
begin
if RESET='1' then
      COUNTER_U  <= 0;
      COUNTER_D  <= 0;
      COUNTER_H  <= 0;  
		COUNTER_T  <= 0;
elsif rising_edge(clock_int3) then 
     if ENABLE = '1' then 
		 if Bouton_UP ='1' then
		    if IS_4096 = '1' then 
			    COUNTER_U  <= 0;
             COUNTER_D  <= 0;
             COUNTER_H  <= 0;  
		       COUNTER_T  <= 0;
           elsif IS_4096 = '0' then 			  
            if COUNTER_U = 9 then
	     	      COUNTER_U <= 0;
	     	   if COUNTER_D = 9 then
                  COUNTER_D <= 0;
               if COUNTER_H = 9 then
                  COUNTER_H <= 0;
               if COUNTER_T = 9 then
                  COUNTER_T <= 0;
               else
               COUNTER_T <= COUNTER_T + 1;
               end if; 
               else
               COUNTER_H <= COUNTER_H + 1;
               end if;  
               else
               COUNTER_D <= COUNTER_D + 1;
               end if;
               else
               COUNTER_U <= COUNTER_U + 1;
               end if;
            end if;

        end if;			  
      if Bouton_DOWN ='1' then

		            if  IS_0000 ='0' then 
                       if COUNTER_U = 0 then
                          COUNTER_U <= 9;
                       if COUNTER_D = 0 then
                          COUNTER_D <= 9;
                       if COUNTER_H = 0 then
                          COUNTER_H <= 9;
                       if COUNTER_T = 0 then
                          COUNTER_T <= 9;
                       else
                       COUNTER_T <= COUNTER_T - 1;
                       end if;
                       else
                       COUNTER_H <= COUNTER_H - 1;
                       end if;
                       else
                       COUNTER_D <= COUNTER_D - 1;
                       end if;
                       else
                       COUNTER_U <= COUNTER_U - 1;
                       end if;
                  end if; 
		end if;
end if;
end if;
end process;

 
 BCD_U <= CONV_STD_LOGIC_VECTOR(COUNTER_U,4);
 BCD_D <= CONV_STD_LOGIC_VECTOR(COUNTER_D,4);
 BCD_H <= CONV_STD_LOGIC_VECTOR(COUNTER_H,4); 
 BCD_T <= CONV_STD_LOGIC_VECTOR(COUNTER_T,4);
   
 IS_4096 <= '1' when (COUNTER_U = 6 and COUNTER_D = 9 and COUNTER_H = 0 and COUNTER_T = 4) else '0';
 IS_0000 <= '1' when (COUNTER_U = 0 and COUNTER_D = 0 and COUNTER_H = 0 and COUNTER_T = 0) else '0';
 LED_Full <= IS_4096; 
 LED_Empty <= IS_0000;

 
end Behavioral;

