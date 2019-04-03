library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

-- Author: Steve Weddell
-- Date: June 25, 2004
-- Purpose: VHDL Module for BCD to 7-segment Decoder
-- Usage: Laboratory 1; Example VHDL file for ENEL353


entity bcd_to_7seg is
		   Port ( bcd_in : in std_logic_vector (3 downto 0);
                  out_7seg : out	std_logic_vector (0 to 6));
end bcd_to_7seg;

architecture Behavioral of bcd_to_7seg is

begin
	my_seg_proc: process (bcd_in)		-- Enter this process whenever BCD input changes state
		begin
			case bcd_in is					 -- abcdefg segments
				when "0000"	=> out_7seg <= "0000001";	  -- if BCD is "0000" write a zero to display
				when "0001"	=> out_7seg <= "1001111";	  -- etc...
				when "0010"	=> out_7seg <= "0010010";
				when "0011"	=> out_7seg <= "0000110";
				when "0100"	=> out_7seg <= "1001100";
				when "0101"	=> out_7seg <= "0100100";
				when "0110"	=> out_7seg <= "1100000";
				when "0111"	=> out_7seg <= "0001111";
				when "1000"	=> out_7seg <= "0000000";
				when "1001"	=> out_7seg <= "0001100";
				when "1111" => out_7seg <= "1111110";    -- use "1111" to encode minus sign
				when others => out_7seg <= "-------";
			end case;
	end process my_seg_proc;

end Behavioral;
