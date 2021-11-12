----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:26:36 10/19/2021 
-- Design Name: 
-- Module Name:    USB_or_codeur_with_python_com - Behavioral 
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity USB_or_codeur_with_python_com is
    Port ( Select_CW_or_CCW : in  STD_LOGIC_VECTOR (1 downto 0);
           Codeur_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           Select_Codeur_or_UART : in  STD_LOGIC;
			  Rx_data_Uart : in  STD_LOGIC_VECTOR (7 downto 0);
           Start_motor_UP : out  STD_LOGIC;
           Start_motor_DOWN : out  STD_LOGIC;
           Reglage_Frequency_Motor : out  STD_LOGIC_VECTOR (7 downto 0));
end USB_or_codeur_with_python_com;

architecture Behavioral of USB_or_codeur_with_python_com is
signal UP : STD_LOGIC :='0';
signal DOWN : STD_LOGIC :='0';

begin

process(select_CW_or_CCW,UP,DOWN)
begin
  case select_CW_or_CCW is
       when "00" => UP <='0'; 	DOWN <='0';
       when "01" => UP <='0'; 	DOWN <='1';
       when "10" => UP <='1'; 	DOWN <='0';
       when "11" => UP <='0'; 	DOWN <='0';
       when others => UP <='0'; DOWN <='0';
  end case;
end process;

Reglage_Frequency_Motor <= Rx_data_Uart(7 downto 0) when Select_Codeur_or_UART ='1' else Codeur_IN;
Start_motor_UP <= '1' when Select_Codeur_or_UART = '1' and  UP ='1' and  Rx_data_Uart >X"00" else '0'; 
Start_motor_DOWN <= '1' when Select_Codeur_or_UART = '1' and  DOWN = '1' and  Rx_data_Uart >X"00" else '0'; 


end Behavioral;

