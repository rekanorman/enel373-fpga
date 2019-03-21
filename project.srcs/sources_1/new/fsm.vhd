----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.03.2019 13:22:18
-- Design Name: 
-- Module Name: fsm - Behavioral
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

entity fsm is
    Port ( button : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           en_op1 : out STD_LOGIC;
           en_op2 : out STD_LOGIC;
           en_opcode : out STD_LOGIC;
           en_result : out STD_LOGIC);
end fsm;

architecture Behavioral of fsm is

type state_type is (read_op1, read_op2, read_opcode, display);
signal current_state, next_state : state_type := read_op1;

begin

process (clk, reset)
begin
    if (reset = '1') then
        current_state <= read_op1;
    elsif (rising_edge(clk)) then
        current_state <= next_state;
    end if;
end process;

process (current_state, button)
begin
    case current_state is
        when read_op1 =>
            en_op1 <= '1';
            en_op2 <= '0';
            en_opcode <= '0';
            en_result <= '0';
            next_state <= read_op1;
            if (rising_edge(button)) then
                next_state <= read_op2;
            end if;
        
        when read_op2 =>
            en_op1 <= '0';
            en_op2 <= '1';
            en_opcode <= '0';
            en_result <= '0';
            next_state <= read_op2;
            if (rising_edge(button)) then
                next_state <= read_opcode;
            end if;
        
        when read_opcode =>
            en_op1 <= '0';
            en_op2 <= '0';
            en_opcode <= '1';
            en_result <= '0';
            next_state <= read_opcode;
            if (rising_edge(button)) then
                next_state <= display;
            end if;
        
        when display =>
            en_op1 <= '0';
            en_op2 <= '0';
            en_opcode <= '0';
            en_result <= '1';
            next_state <= display;
            if (rising_edge(button)) then
                next_state <= read_op1;
            end if;
        
--        when others =>
--            en_op1 <= '0';
--            en_op2 <= '0';
--            en_opcode <= '0';
--            en_result <= '0';
--            next_state <= read_op1;
        
        end case;
        
    end process;
end Behavioral;
