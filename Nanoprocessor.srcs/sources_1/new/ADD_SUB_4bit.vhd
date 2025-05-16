----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/11/2025 03:48:27 PM
-- Design Name: 
-- Module Name: ADD_SUB_4bit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ADD_SUB_4bit is
    Port ( Ins : in STD_LOGIC; -- instruction (ADD =0, SUB = 1) (also works as C_in)
        A : in STD_LOGIC_VECTOR (3 DOWNTO 0);
        B : in STD_LOGIC_VECTOR (3 DOWNTO 0);
        S : out STD_LOGIC_VECTOR (3 DOWNTO 0);
        O_flow : out STD_LOGIC;
        Zero: out STD_LOGIC);
end ADD_SUB_4bit;

architecture Behavioral of ADD_SUB_4bit is

component FA is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C_in : in STD_LOGIC;
           S : out STD_LOGIC;
           C_out : out STD_LOGIC);
end component;

signal FA0_C, FA1_C, FA2_C, FA3_C : std_logic;
Signal A0, A1, A2, A3 : std_logic;
Signal S0, S1, S2, S3 : std_logic;

begin

-- When Subtracting we will do B-A

    A0 <= A(0) XOR Ins;
    A1 <= A(1) XOR Ins;
    A2 <= A(2) XOR Ins;
    A3 <= A(3) XOR Ins;
    
    FA_0 : FA 
        port map(
        A=>A0,
        B=>B(0),
        C_in=> Ins,
        S=> S0,
        C_out => FA0_C);

    FA_1 : FA 
        port map(
        A=>A1,
        B=>B(1),
        C_in=> FA0_C,
        S=> S1,
        C_out => FA1_C);

    FA_2 : FA 
        port map(
        A=>A2,
        B=>B(2),
        C_in=> FA1_C,
        S=> S2,
        C_out => FA2_C);
 
    FA_3 : FA 
        port map(
        A=>A3,
        B=>B(3),
        C_in=> FA2_C,
        S=> S3,
        C_out => FA3_C);
    
S <= S3 & S2 & S1 & S0;    
Zero <= ( (NOT S0) AND (NOT S1) AND (NOT S2) AND (NOT S3) ); 
O_Flow <= FA3_C XOR FA2_C;
        
end Behavioral;
