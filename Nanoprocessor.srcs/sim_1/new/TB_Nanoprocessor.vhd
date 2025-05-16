----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 10:09:24 PM
-- Design Name: 
-- Module Name: TB_Nanoprocessor - Behavioral
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

entity TB_Nanoprocessor is
--  Port ( );
end TB_Nanoprocessor;

architecture Behavioral of TB_Nanoprocessor is

component Nanoprocessor is
    Port ( Reset : in STD_LOGIC;
           Clock : in STD_LOGIC;
           R7_LED : out STD_LOGIC_VECTOR (3 downto 0);
           Zero_LED : out STD_LOGIC;
           Over_F_LED : out STD_LOGIC;
           Anode : out STD_LOGIC_VECTOR (3 downto 0);
           R7_7seg : out STD_LOGIC_VECTOR (6 downto 0));
end component;

signal reset : std_logic;
signal clk : std_logic := '0';
signal Zero_LED, Over_F_LED : std_logic;
signal R7_LED : STD_LOGIC_VECTOR (3 downto 0);
signal anode : STD_LOGIC_VECTOR (3 downto 0);
signal R7_7seg : STD_LOGIC_VECTOR (6 downto 0);

begin

UUT: Nanoprocessor
    port map(
    Reset   => reset,
    Clock   => clk,
    R7_LED  => R7_LED,
    Zero_LED   =>  Zero_LED,
    Over_F_LED => Over_F_LED,
    Anode   => anode,
    R7_7seg => R7_7seg);

    process
    begin
        clk <= not clk;
        wait for 5 ns;
    end process;
    
    process
    begin
        reset <= '1';
        wait for 100ns;
        
        reset <= '0';
        wait; 
    end process;
    
    
end Behavioral;
