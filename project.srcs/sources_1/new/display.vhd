----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.04.2019 13:36:56
-- Design Name: 
-- Module Name: display - Behavioral
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
use IEEE.STD_LOGIC_SIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display is
    Port ( value : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (3 downto 0));
end display;

architecture Behavioral of display is
    -- one-hot encoding of which display is currently on,
    -- e.g. "0010" means second display from right is on
    signal state : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    
    -- the value for the outputs CA, ..., CG
    signal out_7seg : STD_LOGIC_VECTOR (0 downto 6) := "0000000";
    
    component bin_to_bcd_8bit is
        Port ( bin : in  STD_LOGIC_VECTOR (7 downto 0);
               ones : out  STD_LOGIC_VECTOR (3 downto 0);
               tens : out  STD_LOGIC_VECTOR (3 downto 0);
               hundreds : out  STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    component bcd_to_7seg is
           Port ( bcd_in : in std_logic_vector (3 downto 0);
                  out_7seg : out    std_logic_vector (0 to 6));
    end component;

begin
    -- one bit of AN is enabled at a time to multiplex between displays
    AN <= state;
    
    CA <= out_7seg(0);
    CB <= out_7seg(1);
    CC <= out_7seg(2);
    CD <= out_7seg(3);
    CE <= out_7seg(4);
    CF <= out_7seg(5);
    CG <= out_7seg(6);

    -- update state every clock cycle to multiplex between displays
    process (state, clk)
    begin
        if (rising_edge(clk)) then
            -- rotate left to move to next state.
            state <= state(2 downto 0) & state(3);
        end if;
    end process;
    
--    process ()
--    begin
        
--    end process;


end Behavioral;
