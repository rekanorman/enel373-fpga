----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.05.2019 13:09:50
-- Design Name: 
-- Module Name: mux_4to1_8bit - Behavioral
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

entity mux_4to1_8bit is
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           b : in STD_LOGIC_VECTOR (7 downto 0);
           c : in STD_LOGIC_VECTOR (7 downto 0);
           d : in STD_LOGIC_VECTOR (7 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           output : out STD_LOGIC_VECTOR (7 downto 0));
end mux_4to1_8bit;

architecture Behavioral of mux_4to1_8bit is

begin
    process (a, b, c, d, sel)
    begin
        case sel is
            when "00" => output <= a;
            when "01" => output <= b;
            when "10" => output <= c;
            when "11" => output <= d;
        end case;
    end process;

end Behavioral;
