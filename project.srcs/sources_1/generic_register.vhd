----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.03.2019 13:41:13
-- Design Name: 
-- Module Name: generic_register - Behavioral
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

entity generic_register is
    generic (
        data_width : integer := 8
    );
    Port ( d : in STD_LOGIC_VECTOR (data_width-1 downto 0);
           q : out STD_LOGIC_VECTOR (data_width-1 downto 0);
           clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           enable : in STD_LOGIC);
end generic_register;

architecture Behavioral of generic_register is

begin
    
    process (d, clk, enable)
    begin
        if (clr = '1') then
            q <= (others => '0');
        elsif (enable = '1' and rising_edge(clk)) then
            q <= d;
        end if;
    end process;

end Behavioral;
