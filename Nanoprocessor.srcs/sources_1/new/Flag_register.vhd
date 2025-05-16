----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 07:18:25 PM
-- Design Name: 
-- Module Name: Flag_register - Behavioral
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

entity Flag_register is
    Port ( Zero : in STD_LOGIC;     --zero signal from ADD_SUB_Unit
           Over_f : in STD_LOGIC;   --overflow signal from ADD_SUB_Unit
           En : in STD_LOGIC;
           reset : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Zero_Flag : out STD_LOGIC;
           OverFlow_Flag : out STD_LOGIC);
end Flag_register;

architecture Behavioral of Flag_register is

begin

process (Clk) begin
    if (rising_edge(Clk)) then
        if reset = '1' then
            Zero_Flag <= '0';
            OverFlow_Flag <= '0';        
        elsif En = '1' then
            Zero_Flag <= Zero;
            OverFlow_Flag <= Over_f;
        end if;
    end if;
end process;

end Behavioral;
