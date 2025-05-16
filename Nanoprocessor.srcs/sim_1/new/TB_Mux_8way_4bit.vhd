----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/11/2025 03:17:15 PM
-- Design Name: 
-- Module Name: TB_Mux_8way_4bit - Behavioral
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

entity TB_Mux_8way_4bit is
end TB_Mux_8way_4bit;

architecture Behavioral of TB_Mux_8way_4bit is

component Mux_8way_4bit is
    Port (
        D0, D1, D2, D3 : in  STD_LOGIC_VECTOR(3 downto 0);
        D4, D5, D6, D7 : in  STD_LOGIC_VECTOR(3 downto 0);
        SEL             : in  STD_LOGIC_VECTOR(2 downto 0);
        Y               : out STD_LOGIC_VECTOR(3 downto 0)
    );
end component;

signal SEL_tb : std_logic_vector(2 downto 0);
signal D0_tb, D1_tb, D2_tb, D3_tb, D4_tb, D5_tb, D6_tb, D7_tb : std_logic_vector(3 downto 0);
signal Y_tb : std_logic_vector(3 downto 0);

begin

    UUT: Mux_8way_4bit
        port map(
            D0 => D0_tb,
            D1 => D1_tb,
            D2 => D2_tb,
            D3 => D3_tb,
            D4 => D4_tb,
            D5 => D5_tb,
            D6 => D6_tb,
            D7 => D7_tb,
            SEL => SEL_tb,
            Y => Y_tb
        );

    -- Stimulus process
    process
    begin
        -- Initialize inputs
        D0_tb <= "0100";
        D1_tb <= "0011";
        D2_tb <= "1010";
        D3_tb <= "1011";
        D4_tb <= "1100";
        D5_tb <= "0101";
        D6_tb <= "0110";
        D7_tb <= "1111";

        SEL_tb <= "000";  -- Select D0
        wait for 100 ns;

        SEL_tb <= "001";  -- Select D1
        wait for 100 ns;

        SEL_tb <= "010";  -- Select D2
        wait for 100 ns;

        SEL_tb <= "011";  -- Select D3
        wait for 100 ns;
        
        SEL_tb <= "100";  -- Select D4
        wait for 100 ns;
        
        SEL_tb <= "101";  -- Select D5
        wait for 100 ns;
        
        SEL_tb <= "110";  -- Select D6
        wait for 100 ns;
        
        SEL_tb <= "111";  -- Select D7
        wait for 100 ns;
        
        

        wait;
    end process;

end Behavioral;