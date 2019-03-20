----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.03.2019 13:15:17
-- Design Name: 
-- Module Name: high_level_main - Structural
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity high_level_main is
    Port ( SW : in STD_LOGIC_VECTOR (15 downto 0);
           BTND : in STD_LOGIC;
           CLK100MHZ : in STD_LOGIC;
           LED : out STD_LOGIC_VECTOR (7 downto 0));
end high_level_main;

architecture Structural of high_level_main is

signal alu_result : STD_LOGIC_vectoR (7 downto 0);
signal alu_op1 : STD_LOGIC_VECTOR (7 downto 0);
signal alu_op2 : STD_LOGIC_VECTOR (7 downto 0);
signal alu_opcode : STD_LOGIC_VECTOR (3 downto 0);

signal en_reg_op1 : STD_LOGIC;
signal en_reg_op2 : STD_LOGIC;
signal en_reg_opcode : STD_LOGIC;
signal en_reg_result : STD_LOGIC;

signal button : STD_LOGIC;
signal clk : STD_LOGIC;
signal leds : STD_LOGIC_VECTOR (7 downto 0);

component alu_8_bit is
    Port ( opA : in STD_LOGIC_VECTOR (7 downto 0);
           opB : in STD_LOGIC_VECTOR (7 downto 0);
           opcode : in STD_LOGIC_VECTOR (3 downto 0);
           result : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component generic_register is
    generic (
        data_width : integer := 8
    );
    Port ( d : in STD_LOGIC_VECTOR (data_width-1 downto 0);
           q : out STD_LOGIC_VECTOR (data_width-1 downto 0);
           clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           enable : in STD_LOGIC);
end component;

component debouncer is
    Port ( input : in STD_LOGIC;
           clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           output : out STD_LOGIC);
end component;

component clk_divider is
    Port ( Clk_in : in  STD_LOGIC;
           Clk_out : out  STD_LOGIC);
end component;

component fsm is
    Port ( button : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           en_op1 : out STD_LOGIC;
           en_op2 : out STD_LOGIC;
           en_opcode : out STD_LOGIC;
           en_result : out STD_LOGIC);
end component;

begin
    clk_divided : clk_divider port map (Clk_in=>clk100mhz, Clk_out=>clk);
    debouncer_btn : debouncer port map (input=>BTND, clk=>clk100mhz, clr=>'0', output=>button);
    alu : alu_8_bit Port map (opA=>alu_op1, opB=>alu_op2, opcode=>alu_opcode, result=>alu_result);
    
    reg_op1 : generic_register generic map (data_width=>8) port map (d=>SW(7 downto 0), q=>alu_op1, enable=>en_reg_op1, clr=>'0', clk=>clk);
    reg_op2 : generic_register generic map (data_width=>8) port map (d=>SW(7 downto 0), q=>alu_op2, enable=>en_reg_op2, clr=>'0', clk=>clk);
    reg_opcode : generic_register generic map (data_width=>4) port map (d=>SW(3 downto 0), q=>alu_opcode, enable=>en_reg_opcode, clr=>'0', clk=>clk);
    reg_result : generic_register generic map (data_width=>8) port map (d=>alu_result, q=>leds, enable=>en_reg_result, clr=>'0', clk=>clk);
   
    my_fsm : fsm Port map (button=>button, clk=>clk100mhz, reset=>'0', en_op1=>en_reg_op1, en_op2=>en_reg_op2, en_opcode=>en_reg_opcode, en_result=>en_reg_result);
    
    LED (7 downto 0) <= leds when (en_reg_result = '1') else "00000000";
end Structural;
