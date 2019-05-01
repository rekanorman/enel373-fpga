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
end fsm;

architecture Behavioral of fsm is
    type state_type is (idle, read_input, load_R, display_R1, display_R2,
                        load_A, calculate, display_result);
    signal current_state, next_state : state_type := idle;

    -- Signals for button edge detection
    signal button_1 : STD_LOGIC := '0';
    signal button_2 : STD_LOGIC := '0';
    signal button_rising_edge : STD_LOGIC := '0';
    signal button_falling_edge : STD_LOGIC := '0';
    
    -- Values read from the instruction
    signal opcode : STD_LOGIC_VECTOR (3 downto 0);
    signal reg : STD_LOGIC;

begin
    -- Detect edges of button signal
    button_1 <= button when rising_edge(clk);
    button_2 <= button_1 when rising_edge(clk);
    button_rising_edge <= button_1 and not button_2;
    button_falling_edge <= not button_1 and button_2;
    
    -- Parse instruction
    opcode <= instruction (7 downto 4);
    reg <= instruction (3);
    
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
                display_sel <= "11";
                
                if (button_rising_edge = '1') then
                    next_state <= read_input;
                else
                    next_state <= display_result;
                end if;             
        end case;
            
    end process;
end Behavioral;
