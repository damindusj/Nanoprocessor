----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 02:49:21 PM
-- Design Name: 
-- Module Name: Mux_8way_4bit - Behavioral
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

entity Mux_8way_4bit is
    Port (
        D0, D1, D2, D3 : in  STD_LOGIC_VECTOR(3 downto 0);
        D4, D5, D6, D7 : in  STD_LOGIC_VECTOR(3 downto 0);
        SEL             : in  STD_LOGIC_VECTOR(2 downto 0);  -- 3-bit selection
        Y               : out STD_LOGIC_VECTOR(3 downto 0)   -- 4-bit output
    );
end Mux_8way_4bit;

architecture Behavioral of Mux_8way_4bit is

begin
   process(D0, D1, D2, D3, D4, D5, D6, D7, SEL)
   begin
        if SEL = "000" then 
            Y <= D0;
        elsif SEL = "001" then
            Y <= D1;
        elsif SEL = "010" then
            Y <= D2;
        elsif SEL = "011" then 
            Y <= D3;
        elsif SEL = "100" then
            Y <= D4;
        elsif SEL = "101" then
            Y <= D5;
        elsif SEL = "110" then
            Y <= D6;
        elsif SEL = "111" then
            Y <= D7;
        end if;
        
   end process;


end Behavioral;
