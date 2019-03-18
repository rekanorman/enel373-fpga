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

entity alu_4_bit is
    Port ( opA : in STD_LOGIC_VECTOR (3 downto 0);
           opB : in STD_LOGIC_VECTOR (3 downto 0);
           opcode : in STD_LOGIC_VECTOR (1 downto 0);
           result : out STD_LOGIC_VECTOR (3 downto 0));
end alu_4_bit;

architecture Behavioral of alu_4_bit is

begin
    process (opA, opB, opcode)
    begin
        case opcode is
            when "00" => result <= opA + opB;
            when "01" => result <= opA - opB;
            when "10" => result <= opA AND opB;
            when "11" => result <= opA OR opB;
        end case;
    end process;
        

end Behavioral;
