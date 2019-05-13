----------------------------------------------------------------------------------
-- Company:  University of Canterbury
-- Authors: Reka Norman (rkn24)
--          Annabelle Ritchie (ari49)
--          Hannah Regan (hbr66)
-- 
-- Create Date: 13.03.2019 13:14:08
-- Design Name: 
-- Module Name: alu_8_bit - Behavioral
-- Project Name: ENEL373 AlU + FSM + Regs Project
-- Target Devices: 
-- Tool Versions: 
-- Description: An 8-bit ALU which performs the operations of addition, subtraction,
--              bitwise AND and bitwise OR. The operands are treated as signed
--              integers, however status flags have not been implemented.
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
use IEEE.STD_LOGIC_SIGNED.ALL;


entity alu_8_bit is
    Port ( op1 : in STD_LOGIC_VECTOR (7 downto 0);
           op2 : in STD_LOGIC_VECTOR (7 downto 0);
           opcode : in STD_LOGIC_VECTOR (3 downto 0);
           result : out STD_LOGIC_VECTOR (7 downto 0));
end alu_8_bit;

architecture Behavioral of alu_8_bit is

begin
    process (op1, op2, opcode)
    begin
        case opcode is
            when "1000" => result <= op1 + op2;
            when "0100" => result <= op1 - op2;
            when "0010" => result <= op1 AND op2;
            when "0001" => result <= op1 OR op2;
            when others => result <= "00000000";
        end case;
    end process;
        
end Behavioral;
