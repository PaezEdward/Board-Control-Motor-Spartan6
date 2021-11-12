----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:52:55 09/28/2021 
-- Design Name: 
-- Module Name:    Compteur_2Bits - Behavioral 
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
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Compteur_2Bits is
    Port ( CLK_10KHz : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           ENABLE : in  STD_LOGIC;
           Output : out  STD_LOGIC_VECTOR (1 downto 0));
end Compteur_2Bits;

architecture Behavioral of Compteur_2Bits is

signal compte : std_logic_vector(1 downto 0);
begin

process(CLK_10KHz,reset)
BEGIN 
if reset ='1' then
   compte <="00";
elsif rising_edge(CLK_10KHz) then
    if enable ='1' then
       compte <= compte + 1; 
    end if;
end if;
END PROCESS; 

Output <= compte;
end Behavioral;

