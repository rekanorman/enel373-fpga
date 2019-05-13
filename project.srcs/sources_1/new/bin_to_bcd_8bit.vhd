----------------------------------------------------------------------------------
-- Company:  University of Canterbury
-- Authors: Reka Norman (rkn24)
--          Annabelle Ritchie (ari49)
--          Hannah Regan (hbr66)
-- Attribution: Based on the VHDL implementation of the Double Dabble algorithm
--              from Wikepedia (https://en.wikipedia.org/wiki/Double_dabble).
-- 
-- Create Date: 03.04.2019 14:11:19
-- Design Name: 
-- Module Name: bin_to_bcd_8bit - Behavioral
-- Project Name: ENEL373 AlU + FSM + Regs Project
-- Target Devices: 
-- Tool Versions: 
-- Description: A binary to BCD converter, which takes an 8-bit binary value
--              and converts into three 4-bit BCD values representing the three
--              decimal digits of the input value.
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


entity bin_to_bcd_8bit is
    Port ( bin : in  STD_LOGIC_VECTOR (7 downto 0);
           ones : out  STD_LOGIC_VECTOR (3 downto 0);
           tens : out  STD_LOGIC_VECTOR (3 downto 0);
           hundreds : out  STD_LOGIC_VECTOR (3 downto 0));
end bin_to_bcd_8bit;

architecture Behavioral of bin_to_bcd_8bit is

begin
    process (bin)

    variable temp : STD_LOGIC_VECTOR (7 downto 0);
    
    -- Variable to store the output BCD number organized as follows:
    --   hundreds = bcd(11 downto 8)
    --   tens = bcd(7 downto 4)
    --   units = bcd(3 downto 0)
    variable bcd : STD_LOGIC_VECTOR (11 downto 0) := (others => '0');
    
    begin
        -- Zero the bcd variable.
        bcd := (others => '0');
        
        -- Read the input binary value into the temp variable.
        temp(7 downto 0) := bin;
        
        -- Cycle 8 times as we have 8 input bits.
        for i in 0 to 7 loop
        
            if bcd(3 downto 0) > 4 then 
                bcd(3 downto 0) := bcd(3 downto 0) + 3;
            end if;
            
            if bcd(7 downto 4) > 4 then 
                bcd(7 downto 4) := bcd(7 downto 4) + 3;
            end if;
            
            -- Hundreds can't be > 4 for an 8-bit input number
            -- so don't need to do anything to upper 4 bits of bcd.
            
            -- Shift bcd left by 1 bit, copy MSB of temp into LSB of bcd.
            bcd := bcd(10 downto 0) & temp(7);
            
            -- Shift temp left by 1 bit.
            temp := temp(6 downto 0) & '0';
        
        end loop;
        
        -- Extract outputs from bcd.
        ones <= STD_LOGIC_VECTOR(bcd(3 downto 0));
        tens <= STD_LOGIC_VECTOR(bcd(7 downto 4));
        hundreds <= STD_LOGIC_VECTOR(bcd(11 downto 8));
    
    end process;            
  
end Behavioral;
