----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:49:11 09/28/2021 
-- Design Name: 
-- Module Name:    Gestion_Cmd_Motor - Behavioral 
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

entity Gestion_Cmd_Motor is
    Port ( Bouton_Up_Real : in  STD_LOGIC;
           Bouton_DOWN_Real : in  STD_LOGIC;
           Start_Motor_UP_Pcontrol : in  STD_LOGIC;
           Start_Motor_DOWN_Pcontrol : in  STD_LOGIC;
           Output_UP : out  STD_LOGIC;
           Output_DOWN : out  STD_LOGIC);
end Gestion_Cmd_Motor;

architecture Behavioral of Gestion_Cmd_Motor is

begin

process(Bouton_Up_Real,Bouton_DOWN_Real,Start_Motor_UP_Pcontrol,Start_Motor_DOWN_Pcontrol) is
 begin
 
 if ( Bouton_Up_Real = '1' or Start_Motor_UP_Pcontrol = '1') then
	Output_UP <= '1';
 else			
	Output_UP <= '0';
 end if;
 
 if ( Bouton_DOWN_Real ='1' or Start_Motor_DOWN_Pcontrol = '1') then
	Output_DOWN <= '1';
 else	
	Output_DOWN <= '0';
 end if;

end process;
end Behavioral;

