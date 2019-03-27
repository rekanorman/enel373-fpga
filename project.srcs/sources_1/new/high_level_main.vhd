----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.03.2019 13:15:17
-- Design Name: 
-- Module Name: high_level_main - Structural
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

entity high_level_main is
    Port ( SW : in STD_LOGIC_VECTOR (7 downto 0);
           BTND : in STD_LOGIC;
           CLK100MHZ : in STD_LOGIC;
           LED : out STD_LOGIC_VECTOR (7 downto 0));
end high_level_main;

architecture Structural of high_level_main is
    -- ALU inputs and outputs
    signal alu_op1 : STD_LOGIC_VECTOR (7 downto 0);
    signal alu_op2 : STD_LOGIC_VECTOR (7 downto 0);
    signal alu_opcode : STD_LOGIC_VECTOR (3 downto 0);
    signal alu_result : STD_LOGIC_vectoR (7 downto 0);

    -- Enables of registers
    signal en_reg_op1 : STD_LOGIC;
    signal en_reg_op2 : STD_LOGIC;
    signal en_reg_opcode : STD_LOGIC;
    signal en_reg_result : STD_LOGIC;
    signal leds_on : STD_LOGIC;
    
    signal button : STD_LOGIC;
    signal clk200hz : STD_LOGIC;
    signal leds : STD_LOGIC_VECTOR (7 downto 0);
    
    component alu_8_bit is
        Port ( op1 : in STD_LOGIC_VECTOR (7 downto 0);
               op2 : in STD_LOGIC_VECTOR (7 downto 0);
               opcode : in STD_LOGIC_VECTOR (3 downto 0);
               result : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component generic_register is
        Generic (data_width : integer := 8);
        Port ( d : in STD_LOGIC_VECTOR (data_width - 1 downto 0);
               q : out STD_LOGIC_VECTOR (data_width - 1 downto 0);
               clk : in STD_LOGIC;
               clr : in STD_LOGIC;
               enable : in STD_LOGIC);
    end component;
    
    component debouncer is
        Port ( input : in STD_LOGIC;
               clk : in STD_LOGIC;
               clr : in STD_LOGIC;
               output : out STD_LOGIC);
    end component;
    
    component clk_divider is
        Port ( clk_in : in  STD_LOGIC;
               clk_out : out  STD_LOGIC);
    end component;
    
    component fsm is
        Port ( button : in STD_LOGIC;
               clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               en_op1 : out STD_LOGIC;
               en_op2 : out STD_LOGIC;
               en_opcode : out STD_LOGIC;
               en_result : out STD_LOGIC;
               en_display : out STD_LOGIC);
    end component;

begin    
    divider : clk_divider port map (clk_in => clk100mhz,
                                    clk_out => clk200hz);
                                    
    debouncer_btn : debouncer port map (input => BTND,
                                        clk => clk200hz,
                                        clr => '0',
                                        output => button);
                                        
    alu : alu_8_bit port map (op1 => alu_op1,
                              op2 => alu_op2,
                              opcode => alu_opcode,
                              result => alu_result);
    
    reg_op1 : generic_register generic map (data_width => 8)
                               port map (d => SW(7 downto 0),
                                         q => alu_op1,
                                         enable => en_reg_op1,
                                         clr => '0',
                                         clk => clk200hz);
                               
    reg_op2 : generic_register generic map (data_width => 8)
                               port map (d => SW(7 downto 0),
                                         q => alu_op2,
                                         enable => en_reg_op2,
                                         clr => '0',
                                         clk => clk200hz);
                               
    reg_opcode : generic_register generic map (data_width => 4)
                                  port map (d => SW(3 downto 0),
                                            q => alu_opcode,
                                            enable => en_reg_opcode,
                                            clr => '0',
                                            clk => clk200hz);
                                  
    reg_result : generic_register generic map (data_width => 8)
                                  port map (d => alu_result,
                                            q => leds,
                                            enable => en_reg_result,
                                            clr => '0',
                                            clk => clk200hz);
   
    my_fsm : fsm port map (button => button,
                           clk => clk200hz,
                           reset => '0',
                           en_op1 => en_reg_op1,
                           en_op2 => en_reg_op2,
                           en_opcode => en_reg_opcode,
                           en_result => en_reg_result,
                           en_display => leds_on);
    
    LED (7 downto 0) <= leds when (leds_on = '1') else "00000000";
    
end Structural;
