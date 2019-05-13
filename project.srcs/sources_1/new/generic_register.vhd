----------------------------------------------------------------------------------
-- Company:  University of Canterbury
-- Authors: Reka Norman (rkn24)
--          Annabelle Ritchie (ari49)
--          Hannah Regan (hbr66)
-- 
-- Create Date: 13.03.2019 13:41:13
-- Design Name: 
-- Module Name: generic_register - Behavioral
-- Project Name: ENEL373 AlU + FSM + Regs Project
-- Target Devices: 
-- Tool Versions: 
-- Description:  A register with a configurable width, supporting clear and
--               enable operations.
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


entity generic_register is
    Generic (width : integer := 8);
    Port ( d : in STD_LOGIC_VECTOR (width - 1 downto 0);
           q : out STD_LOGIC_VECTOR (width - 1 downto 0);
           clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           enable : in STD_LOGIC);
end generic_register;

architecture Behavioral of generic_register is
begin

    process (d, clk, enable, clr)
    begin
        if (clr = '1') then
            q <= (others => '0');
        elsif (enable = '1' and rising_edge(clk)) then
            q <= d;
        end if;
    end process;
    
end Behavioral;
