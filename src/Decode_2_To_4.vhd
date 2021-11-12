----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:41:49 09/28/2021 
-- Design Name: 
-- Module Name:    Decode_2_To_4 - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Decode_2_To_4 is
    Port ( Sel : in  STD_LOGIC_VECTOR (1 downto 0);
           Afficheur_3 : out  STD_LOGIC;
           Afficheur_2 : out  STD_LOGIC;
           Afficheur_1 : out  STD_LOGIC;
           Afficheur_0 : out  STD_LOGIC);
end Decode_2_To_4;

architecture Behavioral of Decode_2_To_4 is

begin
process(Sel)
begin

Afficheur_0 <='1';
Afficheur_1 <='1';
Afficheur_2 <='1';
Afficheur_3 <='1';



case sel is
     --when "00"  =>Afficheur_0 <='0';
	  when "01"  =>Afficheur_1 <='0'; 
	  when "10"  =>Afficheur_2 <='0'; 
	  when "11"  =>Afficheur_3 <='0'; 
	  when others => Afficheur_0 <='0';
end case;
end process;

end Behavioral;

