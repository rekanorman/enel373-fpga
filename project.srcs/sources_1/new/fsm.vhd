----------------------------------------------------------------------------------
-- Company:  University of Canterbury
-- Authors: Reka Norman (rkn24)
--          Annabelle Ritchie (ari49)
--          Hannah Regan (hbr66)
-- 
-- Create Date: 20.03.2019 13:22:18
-- Design Name: 
-- Module Name: fsm - Behavioral
-- Project Name: ENEL373 AlU + FSM + Regs Project
-- Target Devices: 
-- Tool Versions: 
-- Description:  A FSM to control the flow of user interaction with the circuit.
--               The states include reading input from the switches, loading 
--               values into various registers, storing the ALU result, and
--               displaying the contents of registers. The outputs of the FSM
--               are the enable bits of registers and tristate buffers, allowing
--               the FSM to control data flow through the circuit.
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


entity fsm is
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
           result_out_en : out STD_LOGIC;
           display_sel : out STD_LOGIC_VECTOR (1 downto 0));
end fsm;

architecture Behavioral of fsm is
    type state_type is (idle, read_input, load_R, display_R1, display_R2,
                        load_A, calculate, store_result, display_result);
    signal current_state, next_state : state_type := idle;

    -- Signals for button edge detection
    signal button_1 : STD_LOGIC := '0';
    signal button_2 : STD_LOGIC := '0';
    signal button_rising_edge : STD_LOGIC := '0';
    
    -- Values read from the instruction input via switches.
    signal opcode : STD_LOGIC_VECTOR (3 downto 0);
    signal reg : STD_LOGIC;    -- 0 means R1, 1 means R2
    signal store : STD_LOGIC;  -- If 1, store result back into R1/R2

begin
    -- Detect edges of button signal.
    button_1 <= button when rising_edge(clk);
    button_2 <= button_1 when rising_edge(clk);
    button_rising_edge <= button_1 and not button_2;
    
    -- Extract the various parts of the instruction.
    opcode <= instruction (7 downto 4);
    reg <= instruction (3);
    store <= instruction (2);
    
    process (clk, reset)
    begin
        if (reset = '1') then
            current_state <= idle;
        elsif (rising_edge(clk)) then
            current_state <= next_state;
        end if;
    end process;
    
    process (current_state, button_rising_edge)
    begin
        case current_state is
            when idle =>
                ext_value_en <= '0';
                r1_load <= '0';
                r2_load <= '0';
                r1_out_en <= '0';
                r2_out_en <= '0';
                opA_load <= '0';
                result_load <= '0';
                result_out_en <= '0';
                display_sel <= "00";
                
                if (button_rising_edge = '1') then
                    next_state <= read_input;
                else
                    next_state <= idle;
                end if;           

            when read_input =>
                ext_value_en <= '0';
                r1_load <= '0';
                r2_load <= '0';
                r1_out_en <= '0';
                r2_out_en <= '0';
                opA_load <= '0';
                result_load <= '0';
                result_out_en <= '0';
                display_sel <= "00";
                
                if (opcode = "0000") then
                    next_state <= load_R;
                else
                    next_state <= load_A;
                end if;
                
            when load_R =>
                ext_value_en <= '1';
                if reg = '0' then
                    r1_load <= '1';
                    r2_load <= '0';
                else
                    r1_load <= '0';
                    r2_load <= '1';
                end if;
                
                r1_out_en <= '0';
                r2_out_en <= '0';
                opA_load <= '0';
                result_load <= '0';
                result_out_en <= '0';
                display_sel <= "00";
                
                if reg = '0' then
                    next_state <= display_R1;
                else
                    next_state <= display_R2;
                end if;
                    
            when display_R1 =>
                ext_value_en <= '0';
                r1_load <= '0';
                r2_load <= '0';
                r1_out_en <= '0';
                r2_out_en <= '0';
                opA_load <= '0';
                result_load <= '0';
                result_out_en <= '0';
                display_sel <= "01";
                
                if (button_rising_edge = '1') then
                    next_state <= read_input;
                else
                    next_state <= display_R1;
                end if; 

            when display_R2 =>
                ext_value_en <= '0';
                r1_load <= '0';
                r2_load <= '0';
                r1_out_en <= '0';
                r2_out_en <= '0';
                opA_load <= '0';
                result_load <= '0';
                result_out_en <= '0';
                display_sel <= "10";
                
                if (button_rising_edge = '1') then
                    next_state <= read_input;
                else
                    next_state <= display_R2;
                end if;

            when load_A =>
                ext_value_en <= '1';
                r1_load <= '0';
                r2_load <= '0';
                r1_out_en <= '0';
                r2_out_en <= '0';
                opA_load <= '1';
                result_load <= '0';
                result_out_en <= '0';
                display_sel <= "00";
                
                next_state <= calculate;

            when calculate =>
                ext_value_en <= '0';
                r1_load <= '0';
                r2_load <= '0';
                                
                if reg = '0' then
                    r1_out_en <= '1';
                    r2_out_en <= '0';
                else
                    r1_out_en <= '0';
                    r2_out_en <= '1';
                end if;

                opA_load <= '0';
                result_load <= '1';
                result_out_en <= '0';
                display_sel <= "00";
                
                if store = '1' then
                    next_state <= store_result;
                else
                    next_state <= display_result;
                end if;

            when store_result =>
                ext_value_en <= '0';
                
                if reg = '0' then
                    r1_load <= '1';
                    r2_load <= '0';
                else
                    r1_load <= '0';
                    r2_load <= '1';
                end if;

                r1_out_en <= '0';
                r2_out_en <= '0';
                opA_load <= '0';
                result_load <= '0';
                result_out_en <= '1';
                display_sel <= "00";
                
                next_state <= display_result;
                
            when display_result =>
                ext_value_en <= '0';
                r1_load <= '0';
                r2_load <= '0';
                r1_out_en <= '0';
                r2_out_en <= '0';
                opA_load <= '0';
                result_load <= '0';
                result_out_en <= '0';
                display_sel <= "11";
                
                if (button_rising_edge = '1') then
                    next_state <= read_input;
                else
                    next_state <= display_result;
                end if;             
        end case;
            
    end process;
end Behavioral;
