----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:14:05 10/05/2021 
-- Design Name: 
-- Module Name:    Selection_Valeur_to_Afficher_7Seg - Behavioral 
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

entity Selection_Valeur_to_Afficher_7Seg is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           C : in  STD_LOGIC_VECTOR (3 downto 0);
           D : in  STD_LOGIC_VECTOR (3 downto 0);
           E : in  STD_LOGIC_VECTOR (3 downto 0);
           F : in  STD_LOGIC_VECTOR (3 downto 0);
           G : in  STD_LOGIC_VECTOR (3 downto 0);
           H : in  STD_LOGIC_VECTOR (3 downto 0);
           I : in  STD_LOGIC_VECTOR (3 downto 0);
           J : in  STD_LOGIC_VECTOR (3 downto 0);
           K : in  STD_LOGIC_VECTOR (3 downto 0);
           L : in  STD_LOGIC_VECTOR (3 downto 0);
           Selection_Valeur_A_Afficher : in  STD_LOGIC_VECTOR (1 downto 0);
           DP3 : out  STD_LOGIC;
           Out_Selection_0 : out  STD_LOGIC_VECTOR (3 downto 0);
           Out_Selection_1 : out  STD_LOGIC_VECTOR (3 downto 0);
           Out_Selection_2 : out  STD_LOGIC_VECTOR (3 downto 0);
           Out_Selection_3 : out  STD_LOGIC_VECTOR (3 downto 0));
end Selection_Valeur_to_Afficher_7Seg;

architecture Behavioral of Selection_Valeur_to_Afficher_7Seg is

begin

Process(Selection_Valeur_A_Afficher,A,B,C,D,E,F,G,H,I,J,K,L) is

begin

case Selection_Valeur_A_Afficher is
	when "01" => Out_Selection_0 <= A; Out_Selection_1 <= B; Out_Selection_2 <= C; Out_Selection_3 <= D; DP3<= '1';
	when "10" => Out_Selection_0 <= E; Out_Selection_1 <= F; Out_Selection_2 <= G; Out_Selection_3 <= H; DP3<= '0';
	when "11" => Out_Selection_0 <= I; Out_Selection_1 <= J; Out_Selection_2 <= K; Out_Selection_3 <= L; DP3<= '1';
	when others => Out_Selection_0 <= A; Out_Selection_1 <= B; Out_Selection_2 <= C; Out_Selection_3 <= D; DP3<= '1';
end case;
end process;


end Behavioral;

