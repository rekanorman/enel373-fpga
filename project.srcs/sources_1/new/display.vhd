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
           AN : out STD_LOGIC_VECTOR (7 downto 0));
end display;

architecture Behavioral of display is
    -- Input value converted to positive (in range 0 to 128)
    signal positive_bin_value : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    
    -- 1 if input value is negative (when treated as signed number)
    signal is_negative : STD_LOGIC := '0';
    
    -- BCD values representing the three digits of the input value
    signal ones : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal tens : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal hundreds : STD_LOGIC_VECTOR (3 downto 0) := "0000";
       
    -- One-hot encoding of which display is currently on,
    -- e.g. "0010" means second display from right is on
    signal state : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    
    -- BCD value for the digit (or minus sign) currently being displayed,
    -- depends on current state
    signal current_bcd_display : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    
    -- The value for the outputs CA, ..., CG
    signal CAtoCG : STD_LOGIC_VECTOR (0 to 6) := "0000000";
    
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
    -- Not using the leftmost 4 displays, so turn them off.
    AN(7 downto 4) <= "1111";
    
    -- One bit of AN is enabled at a time to multiplex between displays
    -- (inverted because AN is active low).
    AN(3 downto 0) <= not state;
    
    CA <= CAtoCG(0);
    CB <= CAtoCG(1);
    CC <= CAtoCG(2);
    CD <= CAtoCG(3);
    CE <= CAtoCG(4);
    CF <= CAtoCG(5);
    CG <= CAtoCG(6);
    
    bin_to_bcd : bin_to_bcd_8bit port map (bin => positive_bin_value,
                                           ones => ones,
                                           tens => tens,
                                           hundreds => hundreds);
    
    bcd_7seg : bcd_to_7seg port map (bcd_in => current_bcd_display,
                                     out_7seg => CAtoCG);
    
    -- Take the absolute value of the input value
    positive_bin_value <= abs value;
    
    -- Check whether input value if negative (to know if we need to display minus sign)
    is_negative <= '1' when value < 0 else '0';
    
    -- Update state every clock cycle to multiplex between displays
    process (state, clk)
    begin
        if (rising_edge(clk)) then
            -- rotate left to move to next state.
            state <= state(2 downto 0) & state(3);
        end if;
    end process;
   
    -- Determine the current BCD value to be displayed, based on the current state
    process (state, is_negative, hundreds, tens, ones)
    begin
        case state is
            when "1000" =>
                if (is_negative = '1') then
                    -- display minus sign
                    current_bcd_display <= "1110";
                else
                    -- display off
                    current_bcd_display <= "1111";
                end if;
            when "0100" =>
                current_bcd_display <= hundreds;
            when "0010" =>
                current_bcd_display <= tens;
            when "0001" =>
                current_bcd_display <= ones;
            when others =>
                current_bcd_display <= "1111";    -- default to display off
        end case;
    end process;

end Behavioral;
