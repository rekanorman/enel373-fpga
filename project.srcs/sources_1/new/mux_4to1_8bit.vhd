----------------------------------------------------------------------------------
-- Company:  University of Canterbury
-- Authors: Reka Norman (rkn24)
--          Annabelle Ritchie (ari49)
--          Hannah Regan (hbr66)
-- 
-- Create Date: 01.05.2019 13:09:50
-- Design Name: 
-- Module Name: mux_4to1_8bit - Behavioral
-- Project Name: ENEL373 AlU + FSM + Regs Project
-- Target Devices: 
-- Tool Versions: 
-- Description:  A 4-to-1 multiplexer, with 8-bit inputs and output,
--               and 2 select bits.
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
