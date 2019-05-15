----------------------------------------------------------------------------------
-- Company:  University of Canterbury
-- Authors: Reka Norman (rkn24)
--          Annabelle Ritchie (ari49)
--          Hannah Regan (hbr66)
-- 
-- Create Date: 07.05.2019 12:20:02
-- Design Name: 
-- Module Name: alu_8bit_tb - Behavioral
-- Project Name: ENEL373 AlU + FSM + Regs Project
-- Target Devices: 
-- Tool Versions: 
-- Description:  A testbench file for the 8-bit ALU module (alu_8_bit.vhdl)
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


entity alu_8bit_tb is
--  Port ( );
end alu_8bit_tb;

architecture Behavioral of alu_8bit_tb is
    component alu_8_bit is
        Port ( op1 : in STD_LOGIC_VECTOR (7 downto 0);
               op2 : in STD_LOGIC_VECTOR (7 downto 0);
               opcode : in STD_LOGIC_VECTOR (3 downto 0);
               result : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    signal op1 : STD_LOGIC_VECTOR (7 downto 0);
    signal op2 : STD_LOGIC_VECTOR (7 downto 0);
    signal opcode : STD_LOGIC_VECTOR (3 downto 0);
    signal result : STD_LOGIC_VECTOR (7 downto 0);
    
begin
    UUT : alu_8_bit port map (op1 => op1,
                              op2 => op2,
                              opcode => opcode,
                              result => result);
                    
    process
    begin
        -- 3 + 4
        -- Expected result = 7 (0000 0111)
        op1 <= "00000011";
        op2 <= "00000100";
        opcode <= "1000";
        wait for 5ms;
        
        -- 5 + (-16)
        -- Expected result = -11 (1111 0101)
        op1 <= "00000101";
        op2 <= "11110000";
        opcode <= "1000";
        wait for 5ms;

        -- 10 - 3
        -- Expected result = 7 (0000 0111)
        op1 <= "00001010";
        op2 <= "00000011";
        opcode <= "0100";
        wait for 5ms;
                
        -- 5 - 8
        -- Expected result = -3 (1111 1101)
        op1 <= "00000101";
        op2 <= "00001000";
        opcode <= "0100";
        wait for 5ms;
                
        -- 0000 1111 AND 0011 1100
        -- Expected result = 0000 1100
        op1 <= "00001111";
        op2 <= "00111100";
        opcode <= "0010";
        wait for 5ms;
        
        -- 0000 1111 AND 1000 0000
        -- Expected result = 0000 0000
        op1 <= "00001111";
        op2 <= "10000000";
        opcode <= "0010";
        wait for 5ms;
        
        -- 0000 1111 OR 1111 0000
        -- Expected result = 1111 1111
        op1 <= "00001111";
        op2 <= "11110000";
        opcode <= "0001";
        wait for 5ms;
        
        -- 0000 1111 OR 0011 1100
        -- Expected result = 0011 1111
        op1 <= "00001111";
        op2 <= "00111100";
        opcode <= "0001";
        wait for 5ms;
    
    end process;
        
end Behavioral;
