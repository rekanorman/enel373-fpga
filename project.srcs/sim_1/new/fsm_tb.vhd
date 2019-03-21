----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.03.2019 20:19:58
-- Design Name: 
-- Module Name: fsm_tb - Behavioral
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

entity fsm_tb is
--  Port ( );
end fsm_tb;

architecture Behavioral of fsm_tb is
    component fsm is
    Port ( button : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           en_op1 : out STD_LOGIC;
           en_op2 : out STD_LOGIC;
           en_opcode : out STD_LOGIC;
           en_result : out STD_LOGIC);
    end component;

    signal button : STD_LOGIC := '0';
    signal clk : STD_LOGIC := '0';
    signal en_op1 : STD_LOGIC;
    signal en_op2 : STD_LOGIC;
    signal en_opcode : STD_LOGIC;
    signal en_result : STD_LOGIC;

begin
    UUT: fsm port map(button => button,
                      clk => clk,
                      reset => '0',
                      en_op1 => en_op1,
                      en_op2 => en_op2,
                      en_opcode => en_opcode,
                      en_result => en_result);
                      
    clk <= not clk after 5ms;
    
    process
    begin
        -- Push button repeatedly to cycle between states
        wait for 1000 ms;
        button <= '1';
        wait for 500 ms;
        button <= '0';
        
    end process;
    
end Behavioral;
