----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:25:42 09/29/2021 
-- Design Name: 
-- Module Name:    Debounce_Boutons - Behavioral 
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

entity Debounce_Boutons is
    Port ( CLK : in  STD_LOGIC;
           Data_IN : in  STD_LOGIC;
           Data_OUT : out  STD_LOGIC);
end Debounce_Boutons;

architecture Behavioral of Debounce_Boutons is

Signal OP1, OP2, OP3: std_logic;
 
begin
 
Process(CLK) is
 
begin
 
If rising_edge(CLK) then
 
OP1 <= Data_IN;
 
OP2 <= OP1;
 
OP3 <= OP2;
 
end if;
 
end process;
 
Data_OUT <= OP1 and OP2 and OP3;
 
end Behavioral;


