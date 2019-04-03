----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.04.2019 14:19:32
-- Design Name: 
-- Module Name: bin_to_bcd_8bit_tb - Behavioral
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

entity bin_to_bcd_8bit_tb is
--  Port ( );
end bin_to_bcd_8bit_tb;

architecture Behavioral of bin_to_bcd_8bit_tb is
    signal bin : STD_LOGIC_VECTOR (7 downto 0);
    signal ones : STD_LOGIC_VECTOR (3 downto 0);
    signal tens : STD_LOGIC_VECTOR (3 downto 0);
    signal hundreds : STD_LOGIC_VECTOR (3 downto 0);
    
    component bin_to_bcd_8bit is
        Port ( bin : in  STD_LOGIC_VECTOR (7 downto 0);
               ones : out  STD_LOGIC_VECTOR (3 downto 0);
               tens : out  STD_LOGIC_VECTOR (3 downto 0);
               hundreds : out  STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
begin
    UUT: bin_to_bcd_8bit port map (bin => bin,
                                   ones => ones,
                                   tens => tens,
                                   hundreds => hundreds);
                                   
    process
    begin
        bin <= "01111111";   -- 127
        wait for 1ms;
        bin <= "00000000";   -- 0
        wait for 1ms;
        bin <= "00000010";   -- 2
        wait for 1ms;
        bin <= "00100001";   -- 33
        wait for 1ms;
    end process;

end Behavioral;
