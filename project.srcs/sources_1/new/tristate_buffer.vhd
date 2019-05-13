----------------------------------------------------------------------------------
-- Company:  University of Canterbury
-- Authors: Reka Norman (rkn24)
--          Annabelle Ritchie (ari49)
--          Hannah Regan (hbr66) 
-- 
-- Create Date: 27.03.2019 14:17:11
-- Design Name: 
-- Module Name: tristate_buffer - Behavioral
-- Project Name: ENEL373 AlU + FSM + Regs Project
-- Target Devices: 
-- Tool Versions: 
-- Description:  A tristate buffer with a configurable width (number of bits).
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
