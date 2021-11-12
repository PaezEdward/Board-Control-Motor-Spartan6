----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:39:06 10/19/2021 
-- Design Name: 
-- Module Name:    View_data_RX - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity View_data_RX is
    Port ( Reset : in  STD_LOGIC;
           Data_RX : in  STD_LOGIC;
           Date_RX_VIEW : out  STD_LOGIC);
end View_data_RX;

architecture Behavioral of View_data_RX is
signal count1: INTEGER range 0 to 1 := 0;
CONSTANT M1: INTEGER := 1;

begin

PROCESS(Data_RX,Reset)
BEGIN
if Reset = '1' then
   Date_RX_VIEW <='0';
elsif rising_edge(Data_RX) then
      IF count1 <= M1-1 THEN  
      count1 <= count1 + 1;
      ELSE
      count1 <= 0;
      END IF;
		IF count1 = 1 then
		   Date_RX_VIEW <='1';
		ELSE
		   Date_RX_VIEW <='0';
		END IF;
end if;
END PROCESS;

end Behavioral;

