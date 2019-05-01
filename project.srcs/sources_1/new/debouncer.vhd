----------------------------------------------------------------------------------
-- Code retrieved from the Digital Design using Digilent FPGA boards textbook.
-- 
-- Create Date: 13.03.2019 14:22:29
-- Design Name: 
-- Module Name: debouncer - Behavioral
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
