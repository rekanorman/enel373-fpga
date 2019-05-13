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


entity fsm_tb is
--  Port ( );
end fsm_tb;

architecture Behavioral of fsm_tb is
    component fsm is
        Port ( clk : in STD_LOGIC;
               button : in STD_LOGIC;
               instruction : in STD_LOGIC_VECTOR (7 downto 0);
               reset : in STD_LOGIC;
               ext_value_en : out STD_LOGIC;
               r1_load : out STD_LOGIC;
               r2_load : out STD_LOGIC;
               r1_out_en : out STD_LOGIC;
               r2_out_en : out STD_LOGIC;
               opA_load : out STD_LOGIC;
               result_load : out STD_LOGIC;
               display_sel : out STD_LOGIC_VECTOR (1 downto 0));
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
