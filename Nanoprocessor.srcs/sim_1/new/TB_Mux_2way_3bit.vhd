----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 08:23:11 PM
-- Design Name: 
-- Module Name: TB_Mux_2way_3bit - Behavioral
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

entity TB_Mux_2way_3bit is
--  Port ( );
end TB_Mux_2way_3bit;

architecture Behavioral of TB_Mux_2way_3bit is

    -- Component declaration
    component Mux_2way_3bit is
        Port (
            A   : in  STD_LOGIC_VECTOR(2 downto 0);
            B   : in  STD_LOGIC_VECTOR(2 downto 0);
            SEL : in  STD_LOGIC;
            Y   : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;

    -- Testbench signals
    signal A_tb, B_tb, Y_tb : STD_LOGIC_VECTOR(2 downto 0);
    signal SEL_tb : STD_LOGIC;

begin

    -- Instantiate the Unit Under Test (UUT)
    UUT: Mux_2way_3bit
        port map (
            A   => A_tb,
            B   => B_tb,
            SEL => SEL_tb,
            Y   => Y_tb
        );

    -- Stimulus process
    process
    begin
        -- Test case 1: SEL = 0, Y should be A
        A_tb <= "101";
        B_tb <= "011";
        SEL_tb <= '0';
        wait for 100 ns;

        -- Test case 2: SEL = 1, Y should be B
        SEL_tb <= '1';
        wait for 100 ns;

        -- Test case 3: Change inputs
        A_tb <= "001";
        B_tb <= "111";
        SEL_tb <= '0';
        wait for 100 ns;

        SEL_tb <= '1';
        wait for 100 ns;

        -- Finish
        wait;
    end process;

end Behavioral;
