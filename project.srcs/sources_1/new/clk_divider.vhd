----------------------------------------------------------------------------------
-- Company:  University of Canterbury
-- Authors: Reka Norman (rkn24)
--          Annabelle Ritchie (ari49)
--          Hannah Regan (hbr66)
-- Attribution: Based on Steves_clock_divider.vhd by Steve Weddell, UC ECE,
--              (example code provided for ENEL373).
-- 
-- Create Date:    13.03.2019 14:28:11
-- Design Name: 
-- Module Name:    clk_divider - Behavioral 
-- Project Name:   ENEL373 AlU + FSM + Regs Project
-- Target Devices: Any
-- Tool versions:  Any
-- Description:    This clock divider will take a 100MHz clock and divide it
--                 down to 200 Hz.
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


entity clk_divider is
    Port ( clk_in : in  STD_LOGIC;
           clk_out : out  STD_LOGIC);
end clk_divider;

architecture Behavioral of clk_divider is
    constant clk_limit : STD_LOGIC_VECTOR(27 downto 0) := X"003D090"; -- 200 Hz

	signal clk_ctr : STD_LOGIC_VECTOR(27 downto 0) := (others => '0');
	signal temp_clk : STD_LOGIC := '0';

begin

 	clock: process (clk_in)

		begin
		if clk_in = '1' and clk_in'Event then
		  if clk_ctr = clk_limit then
		  	 temp_clk <= not temp_clk;
			 clk_ctr <= X"0000000";
		  else
		  	 clk_ctr <= clk_ctr + X"0000001";
		  end if;
		end if;

	end process clock;

	clk_out <= temp_clk;	

end Behavioral;


