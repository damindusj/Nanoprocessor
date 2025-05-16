----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/15/2025 08:31:21 PM
-- Design Name: 
-- Module Name: Nanoprocessor - Behavioral
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

entity Nanoprocessor is
    Port ( Reset : in STD_LOGIC;
           Clock : in STD_LOGIC;
           R7_LED : out STD_LOGIC_VECTOR (3 downto 0);
           Zero_LED : out STD_LOGIC;
           Over_F_LED : out STD_LOGIC;
           Anode : out STD_LOGIC_VECTOR (3 downto 0);
           R7_7seg : out STD_LOGIC_VECTOR (6 downto 0));
end Nanoprocessor;

architecture Behavioral of Nanoprocessor is

----- Components ------

----- Slow Clock >>>> Slowed Clock signal so easy to observe --------
component Slow_Clk is
    Port ( Clk_in : in STD_LOGIC;
           Clk_out : out STD_LOGIC);
end component;

-----Instruction Decoder-----------------------------
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

---- Register Bank (8 4-bit registers) -------
component Reg_Bank is
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
end component;

---- Flag Register  (Zero, Overflow) --------
component Flag_register is
    Port ( Zero : in STD_LOGIC;     --zero signal from ADD_SUB_Unit
           Over_f : in STD_LOGIC;   --overflow signal from ADD_SUB_Unit
           En : in STD_LOGIC;
           reset : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Zero_Flag : out STD_LOGIC;
           OverFlow_Flag : out STD_LOGIC);
end component;

---- Program Counter (register) --------
component Program_Counter is
    Port ( D : in STD_LOGIC_VECTOR (2 downto 0);
       Reset : in STD_LOGIC;
       Clk : in STD_LOGIC;
       P_count : out STD_LOGIC_VECTOR (2 downto 0));
end component;

---- 4-bit ADD_SUB_Unit -----------
component ADD_SUB_4bit is
    Port ( Ins : in STD_LOGIC; -- instruction (ADD =0, SUB = 1) (also works as C_in)
        A : in STD_LOGIC_VECTOR (3 DOWNTO 0);
        B : in STD_LOGIC_VECTOR (3 DOWNTO 0);
        S : out STD_LOGIC_VECTOR (3 DOWNTO 0);
        O_flow : out STD_LOGIC;
        Zero: out STD_LOGIC);
end component;

---- 3-bit Adder -----------------
component Adder_3bit is
    Port (
    A : in STD_LOGIC_VECTOR (2 DOWNTO 0);
    B : in STD_LOGIC_VECTOR (2 DOWNTO 0);
    S : out STD_LOGIC_VECTOR (2 DOWNTO 0));
end component;


---- 8 way 4bit Multiplexer ----------
component Mux_8way_4bit is
    Port (
        D0, D1, D2, D3 : in  STD_LOGIC_VECTOR(3 downto 0);
        D4, D5, D6, D7 : in  STD_LOGIC_VECTOR(3 downto 0);
        SEL             : in  STD_LOGIC_VECTOR(2 downto 0);  -- 3-bit selection
        Y               : out STD_LOGIC_VECTOR(3 downto 0)   -- 4-bit output
    );
end component;

---- 2 way 4bit Multiplexer --------
component Mux_2way_4bit is
    Port (
        A   : in  STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit input A
        B   : in  STD_LOGIC_VECTOR(3 downto 0);  -- 4-bit input B
        SEL : in  STD_LOGIC;                      -- Selection line
        Y   : out STD_LOGIC_VECTOR(3 downto 0)   -- 4-bit output
    );
end component;

---- 2 way 3bit Multiplexer --------
component Mux_2way_3bit is
    Port (
        A   : in  STD_LOGIC_VECTOR(2 downto 0);  -- 3-bit input A
        B   : in  STD_LOGIC_VECTOR(2 downto 0);  -- 3-bit input B
        SEL : in  STD_LOGIC;                     -- Selection line
        Y   : out STD_LOGIC_VECTOR(2 downto 0)   -- 3-bit output
    );
end component;

----- Program ROM >>>> Stored Machine language Assembly code -------
component Program_ROM is
    Port ( address : in STD_LOGIC_VECTOR (2 downto 0);
           data : out STD_LOGIC_VECTOR (11 downto 0));
end component;

---- Lookup table for 7 Segment display outputs ----
component LUT_16_7seg is
    Port ( address : in STD_LOGIC_VECTOR (3 downto 0);
           data : out STD_LOGIC_VECTOR (6 downto 0));
end component;



-----Signals--------------------

signal Slow_clock :std_logic;
signal instruction : std_logic_vector (11 downto 0);
signal Mux_A_out ,Mux_B_out : std_logic_vector (3 downto 0); -- 8way MUX outputs
signal Mux_A_Sel, Mux_B_Sel : std_logic_vector (2 downto 0); -- 8way MUX Select signal
signal Reg_EN : std_logic_vector (2 downto 0); -- Register bank select reg for write enable signal
signal Flag_Reg_EN : std_logic; --flag register enable signal
signal Address_to_jump : std_logic_vector (2 downto 0);
signal Jump_Flag : std_logic;
signal Add_Sub_Sel : std_logic;
signal Load_Sel : std_logic;    -- load select for register write data bus
signal Immediate_Value:  std_logic_vector (3 downto 0);

signal Reg_Data_in: std_logic_vector (3 downto 0); --Register Data in Bus
--Register Data outs 
signal Reg_0, Reg_1, Reg_2, Reg_3, Reg_4, Reg_5, Reg_6, Reg_7: std_logic_vector (3 downto 0);
signal Add_Sub_Out : std_logic_vector (3 downto 0);
signal O_flow, Zero : std_logic;

signal Program_C_in, Program_C_out: std_logic_vector (2 downto 0);
signal Program_C_Incrementer_out : std_logic_vector (2 downto 0);


begin


    SlowClock : Slow_Clk
        port map(
        Clk_in => Clock,
        Clk_out => Slow_clock );

    Instruction_Decoder_0: Instruction_Decoder
        port map(
        Instruction     => instruction,
        Jump_reg_val    => Mux_A_out,
        Reg_Sel_A       => Mux_A_Sel,
        Reg_Sel_B       => Mux_B_Sel,
        Reg_En          => Reg_EN,
        Flag_Reg_En     => Flag_Reg_EN,
        Jump_Address    => Address_to_jump,
        Jump_Flag       => Jump_Flag,
        Add_Sub_Sel     => Add_Sub_Sel,
        Load_Sel        => Load_Sel,
        Immediate_Value => Immediate_Value);

    Register_Bank_0 : Reg_Bank
        port map(
        RegSel  => Reg_EN,
        D       => Reg_Data_in,
        Reset   => Reset,
        Clk     => Slow_clock,
        R0      => Reg_0,
        R1      => Reg_1,
        R2      => Reg_2,
        R3      => Reg_3,
        R4      => Reg_4,
        R5      => Reg_5,
        R6      => Reg_6,
        R7      => Reg_7);

    Mux_8way_4bit_A: Mux_8way_4bit
        port map(
        D0  => Reg_0,
        D1  => Reg_1,
        D2  => Reg_2,
        D3  => Reg_3,
        D4  => Reg_4,
        D5  => Reg_5,
        D6  => Reg_6,
        D7  => Reg_7,
        SEL => Mux_A_Sel,
        Y   => Mux_A_out);

    Mux_8way_4bit_B: Mux_8way_4bit
        port map(
        D0  => Reg_0,
        D1  => Reg_1,
        D2  => Reg_2,
        D3  => Reg_3,
        D4  => Reg_4,
        D5  => Reg_5,
        D6  => Reg_6,
        D7  => Reg_7,
        SEL => Mux_B_Sel,
        Y   => Mux_B_out);

    ADD_SUB_UNIT: Add_Sub_4bit
        port map(
        Ins => Add_Sub_Sel,
        A   => Mux_A_out,
        B   => Mux_B_out,
        S   => Add_Sub_Out,
        O_flow  => O_flow,
        Zero    => Zero);
        
    Mux_for_Reg_Write_Data_Bus: Mux_2way_4bit
        port map(
        A   => Immediate_Value,
        B   => Add_Sub_Out,
        SEL => Load_Sel,
        Y   => Reg_Data_in);
    
    Flag_Register_0 :Flag_register
        port map(
        Zero    => Zero,
        Over_f  => O_flow,
        En      => Flag_Reg_EN,
        reset   => Reset,
        Clk     => Slow_clock,
        Zero_Flag  =>   Zero_LED,
        OverFlow_Flag => Over_F_LED);
    
    Program_Counter_0: Program_Counter
        port map(
        D       => Program_C_in,
        Reset   => Reset,
        Clk     => Slow_clock,
        P_count => Program_C_out);

    Program_Count_Incrementer: Adder_3bit
        port map(
        A   => Program_C_out,
        B   => "001",
        S   => Program_C_Incrementer_out);

    Mux_2way_3bit_0 : Mux_2way_3bit
        port map(
        A   => Program_C_Incrementer_out,
        B   => Address_to_jump,
        SEL => Jump_Flag,
        Y   => Program_C_in);

    Program_ROM_0: Program_ROM
        Port map(
        address => Program_C_out,
        data    => instruction);


---- Output Settings ----------------

    -- Zero and Overflow outputs done in above
    
    LUT_16_7seg_0 : LUT_16_7seg
        Port map( 
        address => Reg_7,
        data    => R7_7seg);
    
    R7_LED  <= Reg_7;
    
    ----enable left most 7 segment display panel---
    anode <= "1110";
    

end Behavioral;
