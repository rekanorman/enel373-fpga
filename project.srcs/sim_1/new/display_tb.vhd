----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2019 10:53:50
-- Design Name: 
-- Module Name: display_tb - Behavioral
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

entity display_tb is
--  Port ( );
end display_tb;

architecture Behavioral of display_tb is
    component display is
        Port ( value : in STD_LOGIC_VECTOR (7 downto 0);
               clk : in STD_LOGIC;
               CAtoCG : out STD_LOGIC_VECTOR (0 to 6);
               AN : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    signal value : STD_LOGIC_VECTOR (7 downto 0);
    signal clk : STD_LOGIC := '0';
    signal CAtoCG : STD_LOGIC_VECTOR (0 to 6);
    signal AN : STD_LOGIC_VECTOR (7 downto 0);

begin
    UUT : display port map (value => value,
                            clk => clk,
                            CAtoCG => CAtoCG,
                            AN => AN);
    
    clk <= not clk after 5ms;
    
    process
    begin
        value <= "11111111";    -- -1
        wait for 100ms;
        value <= "01110001";    -- 113
        wait for 100ms;
        value <= "10000000";    -- -128
        wait for 100ms;
        value <= "00100000";    -- 32
        wait for 100ms;
    end process;

end Behavioral;
