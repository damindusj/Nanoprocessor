----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2025 10:12:23 PM
-- Design Name: 
-- Module Name: Instruction_Decoder - Behavioral
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

entity Instruction_Decoder is
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
end Instruction_Decoder;

architecture Behavioral of Instruction_Decoder is

--signal Op_code : STD_LOGIC_VECTOR (1 downto 0);

begin
    
    Process (Instruction, Jump_reg_val)
    begin
        
        
        if Instruction (11 downto 10) = "00" then -- ADD
            Jump_Flag <= '0';
            Reg_Sel_A <= Instruction(9 downto 7);
            Reg_Sel_B <= Instruction(6 downto 4);
            Add_Sub_Sel <= '0';
            Load_Sel <= '1';
            Reg_En <= Instruction(9 downto 7);
            Flag_Reg_En <='1';
            
        elsif Instruction (11 downto 10) = "01" then -- Neg
            Jump_Flag <= '0';
            Reg_Sel_A <= Instruction(9 downto 7);
            Reg_Sel_B <= Instruction(6 downto 4);
            Add_Sub_Sel <= '1';
            Load_Sel <= '1';
            Reg_En <= Instruction(9 downto 7);
            Flag_Reg_En <='1';
            
        elsif Instruction (11 downto 10) = "10" then -- MOVI
            Jump_Flag <= '0';
            Load_Sel <= '0';
            Reg_En <= Instruction(9 downto 7);
            Flag_Reg_En <= '0';
            Immediate_value <= Instruction(3 downto 0);
        
        elsif Instruction (11 downto 10) = "11" then --JZR
            Reg_En <= "000";
            Flag_Reg_En <= '0';
            Reg_Sel_A <= Instruction(9 downto 7);
            if Jump_reg_val ="0000" then
                Jump_Flag <= '1';
                Jump_Address <= Instruction (2 downto 0);
            else
                Jump_Flag <= '0';
            end if;

        end if;                  
                                
    end process;
    
end Behavioral;
