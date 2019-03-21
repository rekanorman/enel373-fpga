----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.03.2019 21:04:16
-- Design Name: 
-- Module Name: high_level_main_tb - Behavioral
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

entity high_level_main_tb is
--  Port ( );
end high_level_main_tb;

architecture Behavioral of high_level_main_tb is
    component high_level_main is
        Port ( SW : in STD_LOGIC_VECTOR (7 downto 0);
               BTND : in STD_LOGIC;
               CLK100MHZ : in STD_LOGIC;
               LED : out STD_LOGIC_VECTOR (7 downto 0));
               
    end component;
    
    signal sw : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    signal btnd : STD_LOGIC := '0';
    signal clk100mhz : STD_LOGIC := '0';
    signal led : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    
begin
    UUT : high_level_main port map(SW => sw, BTND => btnd, CLK100MHZ => clk100mhz, LED => led);
    
    -- create 10kHz clock, clk divider with clk_limit = X"0000010" will reduce this to about 300Hz.
    clk100mhz <= not clk100mhz after 50us;
    
    -- simulate person entering data into fpga
    process
    begin
        -- enter operand 1 and push button
        wait for 1000ms;
        sw <= "00000010";
        wait for 1000ms;
        btnd <= '1';
        wait for 200ms;
        btnd <= '0';
        
        -- enter operand 2 and push button
        wait for 1000ms;
        sw <= "00000001";
        wait for 1000ms;
        btnd <= '1';
        wait for 200ms;
        btnd <= '0';

        -- enter opcode and push button
        wait for 1000ms;
        sw <= "00000001";
        wait for 1000ms;
        btnd <= '1';
        wait for 200ms;
        btnd <= '0';
        
        -- view displayed result
        wait for 2000ms;
        
        -- push button to restart program
        btnd <= '1';
        wait for 200ms;
        btnd <= '0';
        
    end process;

end Behavioral;
