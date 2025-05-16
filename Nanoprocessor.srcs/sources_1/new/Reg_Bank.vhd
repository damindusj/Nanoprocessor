----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/11/2025 07:15:54 PM
-- Design Name: 
-- Module Name: Reg_Bank - Behavioral
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

entity Reg_Bank is
    Port ( RegSel : in STD_LOGIC_VECTOR (2 downto 0);   --Register Select signal
           D : in STD_LOGIC_VECTOR (3 downto 0);    --Data line
           Reset: in STD_LOGIC;
           Clk : in STD_LOGIC;
           R0 : out STD_LOGIC_VECTOR (3 downto 0);  
           R1 : out STD_LOGIC_VECTOR (3 downto 0);
           R2 : out STD_LOGIC_VECTOR (3 downto 0);
           R3 : out STD_LOGIC_VECTOR (3 downto 0);
           R4 : out STD_LOGIC_VECTOR (3 downto 0);
           R5 : out STD_LOGIC_VECTOR (3 downto 0);
           R6 : out STD_LOGIC_VECTOR (3 downto 0);
           R7 : out STD_LOGIC_VECTOR (3 downto 0));
end Reg_Bank;

architecture Behavioral of Reg_Bank is

component Reg is
    Port ( D : in STD_LOGIC_VECTOR (3 downto 0);
           En : in STD_LOGIC;
           Res : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component Decoder_3_to_8 is
    Port ( I : in STD_LOGIC_VECTOR (2 downto 0);
           EN : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal line_en : STD_LOGIC_VECTOR (7 downto 0);

begin

    Decode: Decoder_3_to_8
        port map(
        I => RegSel,
        En => '1',
        Y => line_en);

    R0 <= "0000";   --hard code R0 to 0000
    
    Reg1: Reg
        port map(
        D => D,
        En => line_en(1),
        Res => Reset,
        Clk => Clk,
        Q => R1);

    Reg2: Reg
        port map(
        D => D,
        En => line_en(2),
        Res => Reset,
        Clk => Clk,
        Q => R2);

    Reg3: Reg
        port map(
        D => D,
        En => line_en(3),
        Res => Reset,
        Clk => Clk,
        Q => R3);

    Reg4: Reg
        port map(
        D => D,
        En => line_en(4),
        Res => Reset,
        Clk => Clk,
        Q => R4);

    Reg5: Reg
        port map(
        D => D,
        En => line_en(5),
        Res => Reset,
        Clk => Clk,
        Q => R5);

    Reg6: Reg
        port map(
        D => D,
        En => line_en(6),
        Res => Reset,
        Clk => Clk,
        Q => R6);

    Reg7: Reg
        port map(
        D => D,
        En => line_en(7),
        Res => Reset,
        Clk => Clk,
        Q => R7);

end Behavioral;
