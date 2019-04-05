----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2019 11:20:54
-- Design Name: 
-- Module Name: display_demo - Behavioral
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

entity display_demo is
    Port ( SW : in STD_LOGIC_VECTOR (7 downto 0);
           CLK100MHZ : in STD_LOGIC;
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0));
end display_demo;

architecture Behavioral of display_demo is
    signal clk200hz : STD_LOGIC;
    
    component display is
        Port ( value : in STD_LOGIC_VECTOR (7 downto 0);
               clk : in STD_LOGIC;
               CA : out STD_LOGIC;
               CB : out STD_LOGIC;
               CC : out STD_LOGIC;
               CD : out STD_LOGIC;
               CE : out STD_LOGIC;
               CF : out STD_LOGIC;
               CG : out STD_LOGIC;
               AN : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component clk_divider is
        Port ( clk_in : in  STD_LOGIC;
               clk_out : out  STD_LOGIC);
    end component;

begin
    divider : clk_divider port map (clk_in => CLK100MHZ,
                                    clk_out => clk200hz);
                                    
    display_module : display port map (value => SW,
                                       clk => clk200hz,
                                       CA => CA,
                                       CB => CB,
                                       CC => CC,
                                       CD => CD,
                                       CE => CE,
                                       CF => CF,
                                       CG => CG,
                                       AN => AN);

end Behavioral;
