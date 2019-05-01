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
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity high_level_main is
    Port ( SW : in STD_LOGIC_VECTOR (15 downto 0);
           BTND : in STD_LOGIC;
           CLK100MHZ : in STD_LOGIC;
           LED : out STD_LOGIC_VECTOR (7 downto 0); 
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0));
end high_level_main;

architecture Structural of high_level_main is
    -- Main 8-bit databus
    signal data_bus : STD_LOGIC_VECTOR (7 downto 0);
    
    -- Two 8-bit sections of the input instruction (from switches)
    signal ext_instruction : STD_LOGIC_VECTOR (7 downto 0);
    signal ext_value : STD_LOGIC_VECTOR (7 downto 0);

    -- ALU opcode and output
    signal alu_opcode : STD_LOGIC_VECTOR (3 downto 0);
    signal alu_result : STD_LOGIC_VECTOR (7 downto 0);
    
    -- Outputs of A, R1, R2 and result registers.
    signal opA_out : STD_LOGIC_VECTOR (7 downto 0);
    signal r1_out : STD_LOGIC_VECTOR (7 downto 0);
    signal r2_out : STD_LOGIC_VECTOR (7 downto 0);
    signal result_out : STD_LOGIC_VECTOR (7 downto 0);

    -- Enables of registers and tristate buffers
    signal ext_value_en : STD_LOGIC;
    signal r1_load : STD_LOGIC;
    signal r2_load : STD_LOGIC;
    signal r1_out_en : STD_LOGIC;
    signal r2_out_en : STD_LOGIC;
    signal opA_load : STD_LOGIC;
    signal result_load : STD_LOGIC;

    -- 2-bit select for multiplexing which register value to display
    -- 00 - display blank
    -- 01 - display R1
    -- 10 - display R2
    -- 11 - display result
    signal display_sel : STD_LOGIC_VECTOR (1 downto 0);
    
    -- The value to display, both on the LEDs and the 7-segment display
    signal display_value : STD_LOGIC_VECTOR (7 downto 0);
    
    -- A vector containing the values for CA, ..., CG.
    signal CAtoCG : STD_LOGIC_VECTOR (0 to 6);
    
    -- Debounced button signal
    signal button : STD_LOGIC;
    
    -- 200Hz clock (output of clock divider)
    signal clk200hz : STD_LOGIC;
    
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

    component tristate_buffer is
        Generic ( width : integer := 8);
        Port ( input : in STD_LOGIC_VECTOR (width - 1 downto 0);
               enable : in STD_LOGIC;
               output : out STD_LOGIC_VECTOR (width - 1 downto 0));
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

    component mux_4to1_8bit is
        Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
               b : in STD_LOGIC_VECTOR (7 downto 0);
               c : in STD_LOGIC_VECTOR (7 downto 0);
               d : in STD_LOGIC_VECTOR (7 downto 0);
               sel : in STD_LOGIC_VECTOR (1 downto 0);
               output : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component display is
        Port ( value : in STD_LOGIC_VECTOR (7 downto 0);
               clk : in STD_LOGIC;
               CAtoCG : out STD_LOGIC_VECTOR (0 to 6);
               AN : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    component fsm is
        Port ( clk : in STD_LOGIC;
               button : in STD_LOGIC;
               instruction : in STD_LOGIC_VECTOR (7 downto 0);
               reset : in STD_LOGIC;
               ext_value_en : out STD_LOGIC;
               r1_load : out STD_LOGIC;
               r2_load : out STD_LOGIC;
               r1_out_en : out STD_LOGIC;
               r2_out_en : out STD_LOGIC;
               opA_load : out STD_LOGIC;
               result_load : out STD_LOGIC;
               display_sel : out STD_LOGIC_VECTOR (1 downto 0));
    end component;

begin
    -- Read input values from switches.
    ext_instruction <= SW (15 downto 8);
    ext_value <= SW (7 downto 0);
    
    -- First 4 bits of instruction are the opcode.
    alu_opcode <= ext_instruction (7 downto 4);
    
    -- Display the value on the LEDs
    LED <= display_value;
    
    CA <= CAtoCG(0);
    CB <= CAtoCG(1);
    CC <= CAtoCG(2);
    CD <= CAtoCG(3);
    CE <= CAtoCG(4);
    CF <= CAtoCG(5);
    CG <= CAtoCG(6);

    divider : clk_divider port map (clk_in => clk100mhz,
                                    clk_out => clk200hz);
                                    
    debouncer_btn : debouncer port map (input => BTND,
                                        clk => clk200hz,
                                        clr => '0',
                                        output => button);
                                        
    alu : alu_8_bit port map (op1 => opA_out,
                              op2 => data_bus,
                              opcode => alu_opcode,
                              result => alu_result);

    ext_value_buf : tristate_buffer generic map (width => 8)
                                    port map (input => ext_value,
                                              enable => ext_value_en,
                                              output => data_bus);
                              
    opA : generic_register generic map (data_width => 8)
                           port map (d => data_bus,
                                     q => opA_out,
                                     enable => opA_load,
                                     clr => '0',
                                     clk => clk200hz);
                                                            
    r1 : generic_register generic map (data_width => 8)
                          port map (d => data_bus,
                                    q => r1_out,
                                    enable => r1_load,
                                    clr => '0',
                                    clk => clk200hz);    
                                         
    buf_r1 : tristate_buffer generic map (width => 8)
                             port map (input => r1_out,
                                       enable => r1_out_en,
                                       output => data_bus);
                               
    r2 : generic_register generic map (data_width => 8)
                          port map (d => data_bus,
                                    q => r2_out,
                                    enable => r2_load,
                                    clr => '0',
                                    clk => clk200hz);
                                    
    buf_r2 : tristate_buffer generic map (width => 8)
                             port map (input => r2_out,
                                       enable => r2_out_en,
                                       output => data_bus);      
                                  
    result : generic_register generic map (data_width => 8)
                              port map (d => alu_result,
                                        q => result_out,
                                        enable => result_load,
                                        clr => '0',
                                        clk => clk200hz);

    display_mux : mux_4to1_8bit port map (a => "00000000",
                                          b => r1_out,
                                          c => r2_out,
                                          d => result_out,
                                          sel => display_sel,
                                          output => display_value);

    display_module : display port map (value => display_value,
                                       clk => clk200hz,
                                       CAtoCG => CAtoCG,
                                       AN => AN);

    state_machine : fsm port map (clk => clk200hz,
                        button => button,
                        instruction => ext_instruction,
                        reset => '0',
                        ext_value_en => ext_value_en,
                        r1_load => r1_load,
                        r2_load => r2_load,
                        r1_out_en => r1_out_en,
                        r2_out_en => r2_out_en,
                        opA_load => opA_load,
                        result_load => result_load,
                        display_sel => display_sel);

end Structural;
