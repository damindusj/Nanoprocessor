----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 06:05:01 PM
-- Design Name: 
-- Module Name: Program_ROM - Behavioral
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
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


entity Program_ROM is
    Port ( address : in STD_LOGIC_VECTOR (2 downto 0);
           data : out STD_LOGIC_VECTOR (11 downto 0));
end Program_ROM;

architecture Behavioral of Program_ROM is

type rom_type is array (0 to 7) of std_logic_vector(11 downto 0); 

    signal Program_ROM : rom_type := ( 
        "101110000001", -- 0  	MOVI R7,1
        "100010000010", -- 1    MOVI R1.2
        "100100000011", -- 2  	MOVI R2,3
        "001110010000", -- 3  	ADD R7,R1
        "001110100000", -- 4  	ADD R7,R2
        "110000000111", -- 5	JZR R0,7  
        "110000000111", -- 6  	JZR R0,7
        "110000000111" -- 7 	JZR R0,7  
        );


begin
    data <= Program_ROM(to_integer(unsigned(address))); 


end Behavioral;
