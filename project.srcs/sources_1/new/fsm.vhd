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
           en_result : out STD_LOGIC;
           en_display : out STD_LOGIC);
end fsm;

architecture Behavioral of fsm is
    type state_type is (read_op1, read_op2, read_opcode, calculate, display);
    signal current_state, next_state : state_type := read_op1;

    -- Signals for button edge detection
    signal button_1 : STD_LOGIC := '0';
    signal button_2 : STD_LOGIC := '0';
    signal button_rising_edge : STD_LOGIC := '0';
    signal button_falling_edge : STD_LOGIC := '0';

begin
    -- Detect edges of button signal
    button_1 <= button when rising_edge(clk);
    button_2 <= button_1 when rising_edge(clk);
    button_rising_edge <= button_1 and not button_2;
    button_falling_edge <= not button_1 and button_2;
    
    process (clk, reset)
    begin
        if (reset = '1') then
            current_state <= read_op1;
        elsif (rising_edge(clk)) then
            current_state <= next_state;
        end if;
    end process;
    
    process (current_state, button_rising_edge)
    begin
        case current_state is
            when read_op1 =>
                en_op1 <= '1';
                en_op2 <= '0';
                en_opcode <= '0';
                en_result <= '0';
                en_display <= '0';
                
                if (button_rising_edge = '1') then
                    next_state <= read_op2;
                else
                    next_state <= read_op1;
                end if;
            
            when read_op2 =>
                en_op1 <= '0';
                en_op2 <= '1';
                en_opcode <= '0';
                en_result <= '0';
                en_display <= '0';

                if (button_rising_edge = '1') then
                    next_state <= read_opcode;
                else
                    next_state <= read_op2;
                end if;
            
            when read_opcode =>
                en_op1 <= '0';
                en_op2 <= '0';
                en_opcode <= '1';
                en_result <= '0';
                en_display <= '0';

                if (button_rising_edge = '1') then
                    next_state <= calculate;
                else
                    next_state <= read_opcode;
                end if;

            when calculate =>
                en_op1 <= '0';
                en_op2 <= '0';
                en_opcode <= '0';
                en_result <= '1';
                en_display <= '0';

                if (button_rising_edge = '1') then
                    next_state <= display;
                else
                    next_state <= calculate;
                end if;
                
            when display =>
                en_op1 <= '0';
                en_op2 <= '0';
                en_opcode <= '0';
                en_result <= '0';
                en_display <= '1';

                if (button_rising_edge = '1') then
                    next_state <= read_op1;
                else
                    next_state <= display;
                end if;
            
            when others =>
                en_op1 <= '0';
                en_op2 <= '0';
                en_opcode <= '0';
                en_result <= '0';
                en_display <= '0';
                next_state <= read_op1;
            
        end case;
            
    end process;
end Behavioral;
