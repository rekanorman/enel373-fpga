----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.03.2019 13:14:08
-- Design Name: 
-- Module Name: alu_4_bit - Behavioral
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
