----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.03.2019 13:44:20
-- Design Name: 
-- Module Name: debouncer_tb - Behavioral
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

entity debouncer_tb is
--  Port ( );
end debouncer_tb;

architecture Behavioral of debouncer_tb is

    component debouncer is
        Port ( input : in STD_LOGIC;
               clk : in STD_LOGIC;
               clr : in STD_LOGIC;
               output : out STD_LOGIC);
    end component;
    
    signal input : STD_LOGIC;
    signal clk : STD_LOGIC := '0';
    signal output : STD_LOGIC;
    
begin
    UUT : debouncer port map(input => input, clk => clk, clr => '0', output => output);

    clk <= not clk after 2ms;

    process
    begin
        input <= '0';
        wait for 100ms;
        input <= '1';
        wait for 100ms;
        
    end process;

end Behavioral;
