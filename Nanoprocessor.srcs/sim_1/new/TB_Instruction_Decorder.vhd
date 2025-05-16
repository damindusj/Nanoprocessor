----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 06:00:03 PM
-- Design Name: 
-- Module Name: TB_Instruction_Decorder - Behavioral
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

entity TB_Instruction_Decorder is
--  Port ( );
end TB_Instruction_Decorder;

architecture Behavioral of TB_Instruction_Decorder is

component Instruction_Decoder is
     Port ( Instruction : in STD_LOGIC_VECTOR (11 downto 0);
          Jump_reg_val : in STD_LOGIC_VECTOR (3 downto 0); --register value for jump check
          Reg_Sel_A: out STD_LOGIC_VECTOR (2 downto 0);    --Mux Select signal
          Reg_Sel_B: out STD_LOGIC_VECTOR (2 downto 0);    --Muc Selct signal
          Reg_En :out STD_LOGIC_VECTOR (2 downto 0);       --Register Bank write enable signal
          Flag_Reg_En : out STD_LOGIC;     -- Enable for ADD_SUB_Units Flag
          Jump_Address : out STD_LOGIC_VECTOR (2 downto 0);
          Jump_Flag : out STD_LOGIC;
          Add_Sub_Sel : out STD_LOGIC; -- 0 for add , 1 for subtract
          Load_Sel : out STD_LOGIC;    -- 0 for immediarte value, 1 for add_sub  unit value
          Immediate_Value : out STD_LOGIC_VECTOR (3 downto 0));

end component;

signal Instruction : STD_LOGIC_VECTOR (11 downto 0);
signal Jump_reg_val ,Immediate_Value: STD_LOGIC_VECTOR (3 downto 0); 
signal  Reg_Sel_A, Reg_Sel_B,Reg_En ,Jump_Address : STD_LOGIC_VECTOR (2 downto 0);
signal  Flag_Reg_En,Load_Sel,Add_Sub_Sel,Jump_Flag  : STD_LOGIC;


begin

UUT:Instruction_Decoder
    port map (
    Instruction=>Instruction,
    Jump_reg_val=>Jump_reg_val,
    Reg_Sel_A=> Reg_Sel_A,
    Reg_Sel_B=> Reg_Sel_B,
    Reg_En=> Reg_En,
    Flag_Reg_En=>Flag_Reg_En,
    Jump_Address=>Jump_Address,
    Jump_Flag=>Jump_Flag,
    Add_Sub_Sel=>Add_Sub_Sel,
    Load_Sel =>Load_Sel ,
    Immediate_Value=>Immediate_Value );
    
    process
    begin 
   
        Jump_reg_val <= "0000";
        Instruction <="101110000011"; -- MOVI R7,1
        wait for 100ns;
        
        Instruction <="100010000010"; -- MOVI R1,2
        wait for 100ns;

        Instruction <= "100100000011"; --MOVI R2,3
        wait for 100ns;
        
        Instruction <="110010000111"; -- JZR R0,7  
        wait for 100ns;
        
        Instruction <="001110010000"; -- ADD R7,R1
        wait for 100ns;

        Instruction <="010010000000"; -- NEG R1
        wait for 100ns;

        Jump_reg_val <= "0100";
        Instruction <="110100000101"; -- JZR R2,5  
        
        wait;
    
    end process;

end Behavioral;
