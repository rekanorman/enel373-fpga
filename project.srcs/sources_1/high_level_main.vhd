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
           LED : out STD_LOGIC_VECTOR (3 downto 0));
end high_level_main;

architecture Structural of high_level_main is

signal alu_result : STD_LOGIC_vectoR (3 downto 0);
signal button : STD_LOGIC;
signal clk : STD_LOGIC;

component alu_4_bit is
    Port ( opA : in STD_LOGIC_VECTOR (3 downto 0);
           opB : in STD_LOGIC_VECTOR (3 downto 0);
           opcode : in STD_LOGIC_VECTOR (1 downto 0);
           result : out STD_LOGIC_VECTOR (3 downto 0));
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

begin
    clk_divided : clk_divider port map (Clk_in=>clk100mhz, Clk_out=>clk);
    debouncer_btn : debouncer port map (input=>BTND, clk=>clk100mhz, clr=>'0', output=>button);
    alu : alu_4_bit Port map (opA=>SW(15 downto 12), opB=>SW(11 downto 8), opcode=>SW(1 downto 0), result=>alu_result);
    register_4_bit : generic_register generic map (data_width=>4) port map (d=>alu_result, q=>LED(3 downto 0), enable=>'1', clr=>'0', clk=>clk);

end Structural;
