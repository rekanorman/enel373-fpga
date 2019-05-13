----------------------------------------------------------------------------------
-- Company:  University of Canterbury
-- Authors: Reka Norman (rkn24)
--          Annabelle Ritchie (ari49)
--          Hannah Regan (hbr66)
-- Attribution: Code based on debounce4.vhd (Listing 24.1) from
--              "Digital Design using Digilent FPGA boards" by Haskell and Hanna.
-- 
-- Create Date: 13.03.2019 14:22:29
-- Design Name: 
-- Module Name: debouncer - Behavioral
-- Project Name: ENEL373 AlU + FSM + Regs Project
-- Target Devices: 
-- Tool Versions: 
-- Description:  A button debouncer module, which only sets the output to high
--               when the input has been high for five consecutive clock cycles.
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


entity debouncer is
    Port ( input : in STD_LOGIC;
           clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           output : out STD_LOGIC);
end debouncer;

architecture Behavioral of debouncer is

signal delay1, delay2, delay3, delay4, delay5 : STD_LOGIC;

begin

    process(input, clk, clr)
    begin
    
        if clr = '1' then
            delay1 <= '0';
            delay2 <= '0';
            delay3 <= '0';
            delay4 <= '0';
            delay5 <= '0';
        elsif rising_edge(clk) then
            delay1 <= input;
            delay2 <= delay1;
            delay3 <= delay2;
            delay4 <= delay3;
            delay5 <= delay4;
        end if;
    end process;
    
    output <= delay1 and delay2 and delay3 and delay4 and delay5;

end Behavioral;
