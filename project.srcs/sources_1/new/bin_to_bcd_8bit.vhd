----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.04.2019 14:11:19
-- Design Name: 
-- Module Name: bin_to_bcd_8bit - Behavioral
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
-- From Double Dabble Wikipedia page
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity bin_to_bcd_8bit is
    Port ( bin : in  STD_LOGIC_VECTOR (7 downto 0);
           ones : out  STD_LOGIC_VECTOR (3 downto 0);
           tens : out  STD_LOGIC_VECTOR (3 downto 0);
           hundreds : out  STD_LOGIC_VECTOR (3 downto 0));
end bin_to_bcd_8bit;

architecture Behavioral of bin_to_bcd_8bit is

begin

bcd1: process(bin)

  -- temporary variable
  variable temp : STD_LOGIC_VECTOR (7 downto 0);
  
  -- variable to store the output BCD number
  -- organized as follows
  -- hundreds = bcd(11 downto 8)
  -- tens = bcd(7 downto 4)
  -- units = bcd(3 downto 0)
  variable bcd : UNSIGNED (11 downto 0) := (others => '0');

  -- by
  -- https://en.wikipedia.org/wiki/Double_dabble
  
  begin
    -- zero the bcd variable
    bcd := (others => '0');
    
    -- read input into temp variable
    temp(7 downto 0) := bin;
    
    -- cycle 8 times as we have 8 input bits
    -- this could be optimized, we do not need to check and add 3 for the 
    -- first 3 iterations as the number can never be >4
    for i in 0 to 7 loop
    
      if bcd(3 downto 0) > 4 then 
        bcd(3 downto 0) := bcd(3 downto 0) + 3;
      end if;
      
      if bcd(7 downto 4) > 4 then 
        bcd(7 downto 4) := bcd(7 downto 4) + 3;
      end if;
    
      -- hundreds can't be >4 for a 8-bit input number
      -- so don't need to do anything to upper 4 bits of bcd
    
      -- shift bcd left by 1 bit, copy MSB of temp into LSB of bcd
      bcd := bcd(10 downto 0) & temp(7);
    
      -- shift temp left by 1 bit
      temp := temp(6 downto 0) & '0';
    
    end loop;
 
    -- set outputs
    ones <= STD_LOGIC_VECTOR(bcd(3 downto 0));
    tens <= STD_LOGIC_VECTOR(bcd(7 downto 4));
    hundreds <= STD_LOGIC_VECTOR(bcd(11 downto 8));
  
  end process bcd1;            
  
end Behavioral;
