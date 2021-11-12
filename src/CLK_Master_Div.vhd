----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:22:18 09/26/2021 
-- Design Name: 
-- Module Name:    CLK_Master_Div - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CLK_Master_Div is
    Port ( CLK_100MHz : in  STD_LOGIC;
           ENABLE : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           CLK_DIV_10KHz : out  STD_LOGIC;
           CLK_DIV_1KHz : out  STD_LOGIC;
			  CLK_DIV_33Hz33 : out  STD_LOGIC);
end CLK_Master_Div;

architecture Behavioral of CLK_Master_Div is

-- signal Interne
signal compteur_33Hz33: std_logic_vector (21 downto 0):= (others => '0');
signal compteur_1KHz: std_logic_vector (16 downto 0):= (others => '0');
signal compteur_10KHz: std_logic_vector (13 downto 0):= (others => '0');

begin

process (CLK_100MHz,RESET,ENABLE)
begin  
   if (CLK_100MHz'event and CLK_100MHz = '1') then
      if RESET = '1' then
			compteur_33Hz33 <= b"0000000000000000000000";
         compteur_1KHz <= b"00000000000000000";
			compteur_10KHz <= b"00000000000000";			
      elsif ENABLE ='1' then
		
				compteur_33Hz33 <= compteur_33Hz33 + b"0000000000000000000001";
			if (compteur_33Hz33 >=        x"2DC6C2") then 
				compteur_33Hz33 <= b"0000000000000000000000";   
			end if;
			
			compteur_1KHz <= compteur_1KHz + b"00000000000000001";
			if (compteur_1KHz >=        x"1869F") then 
				compteur_1KHz <= b"00000000000000000";     
			end if;
			
				compteur_10KHz <= compteur_10KHz + b"00000000000001";
			if (compteur_10KHz >=        x"270F") then 
				compteur_10KHz <= b"00000000000000";
			end if;
			
      end if;
   end if;
end process;

CLK_DIV_33Hz33 <= '1' when (compteur_33Hz33 < x"16E361") else '0';
CLK_DIV_1KHz <= '1' when (compteur_1KHz < x"0C350") else '0'; 
CLK_DIV_10KHz <= '1' when (compteur_10KHz < x"1388") else '0'; 

end Behavioral;

