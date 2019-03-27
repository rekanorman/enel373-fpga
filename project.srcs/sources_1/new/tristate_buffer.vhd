----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.03.2019 14:17:11
-- Design Name: 
-- Module Name: tristate_buffer - Behavioral
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

entity tristate_buffer is
    Generic ( width : integer := 8);
    Port ( input : in STD_LOGIC_VECTOR (width - 1 downto 0);
           enable : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (width - 1 downto 0));
end tristate_buffer;

architecture Behavioral of tristate_buffer is

begin
    process (input, enable)
    begin
        if (enable = '1') then
            output <= input;
        else
            output <= (others => 'Z');
        end if;
    end process;

end Behavioral;
