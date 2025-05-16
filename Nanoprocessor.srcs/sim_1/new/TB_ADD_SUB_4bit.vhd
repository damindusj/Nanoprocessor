----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/11/2025 04:58:50 PM
-- Design Name: 
-- Module Name: TB_ADD_SUB_4bit - Behavioral
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

entity TB_ADD_SUB_4bit is
--  Port ( );
end TB_ADD_SUB_4bit;

architecture Behavioral of TB_ADD_SUB_4bit is

component ADD_SUB_4bit is
    Port ( Ins : in STD_LOGIC; -- instruction (ADD =0, SUB = 1) (also works as C_in)
        A : in STD_LOGIC_VECTOR (3 DOWNTO 0);
        B : in STD_LOGIC_VECTOR (3 DOWNTO 0);
        S : out STD_LOGIC_VECTOR (3 DOWNTO 0);
        O_flow : out STD_LOGIC;
        Zero: out STD_LOGIC);
end component;

signal  a,b,s : std_logic_vector (3 downto 0);
signal ins, O_f, z :std_logic;

begin
    
    UTT: ADD_SUB_4bit
        port map(
        Ins => ins,
        A => a,
        B => b,
        S => s,
        O_flow => O_f,
        Zero => z );

    process
    begin
        a <= "0010";
        b <= "0101";
        ins <= '0';
        wait for 100ns;
        
        ins <= '1';
        wait for 100ns;
        
        a<="0111";
        b<="0111";
        ins <= '0';
        wait for 100ns;
        
        ins <='1';
        
        wait;
                
    end process;
end Behavioral;
