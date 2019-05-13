----------------------------------------------------------------------------------
-- Company:  University of Canterbury
-- Authors: Reka Norman (rkn24)
--          Annabelle Ritchie (ari49)
--          Hannah Regan (hbr66)
-- Attribution: Based on bcd_to_7seg.vhd by Steve Weddell, UC ECE,
--              (example code provided for ENEL373).
-- 
-- Create Date:    13.03.2019 14:37:54
-- Design Name: 
-- Module Name:    bcd_to_7seg - Behavioral 
-- Project Name:   ENEL373 AlU + FSM + Regs Project
-- Target Devices:
-- Tool versions:
-- Description:    Converts a 4-bit BCD value representing a single decimal digit
--                 to the values needed to display that digit on a 7-segment display.
--                 Also uses the value 1110 to encode a minus sign, and the
--                 value 1111 to indicate that the display should be blank.
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity bcd_to_7seg is
    Port ( bcd_in : in std_logic_vector (3 downto 0);
           out_7seg : out std_logic_vector (0 to 6));
end bcd_to_7seg;

architecture Behavioral of bcd_to_7seg is

begin
    process (bcd_in)
    begin
        case bcd_in is
            when "0000"	=> out_7seg <= "0000001";  -- if BCD is "0000" write a zero to display
            when "0001"	=> out_7seg <= "1001111";  -- etc...
            when "0010"	=> out_7seg <= "0010010";
            when "0011"	=> out_7seg <= "0000110";
            when "0100"	=> out_7seg <= "1001100";
            when "0101"	=> out_7seg <= "0100100";
            when "0110"	=> out_7seg <= "1100000";
            when "0111"	=> out_7seg <= "0001111";
            when "1000"	=> out_7seg <= "0000000";
            when "1001"	=> out_7seg <= "0001100";
            when "1110" => out_7seg <= "1111110";  -- use "1110" to encode minus sign
            when "1111" => out_7seg <= "1111111";  -- use "1111" to encode display off
            when others => out_7seg <= "1111111";  -- default to off
        end case;
	end process;

end Behavioral;
