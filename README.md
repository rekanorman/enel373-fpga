# ENEL373: ALU + FSM + Regs Project

**Lab_A01_group_10**

* Reka Norman (rkn24)
* Annabelle Ritchie (ari49)
* Hannah Regan (hbr66)

This project implements a simple 8-bit arithmetic logic unit for an FPGA.

| File Name (.vhd)    | Description                                                                                                                      |
|---------------------|----------------------------------------------------------------------------------------------------------------------------------|
| alu_8_bit           | An 8-bit ALU which performs the operations of addition, subtraction, bitwise AND and bitwise OR.                                 |
| bcd_to_7seg         | Converts a 4-bit BCD value representing a single decimal digit to the values needed to display the digit on a 7-segment display. |
| bin_to_bcd_8bit     | An 8-bit binary to BCD converter. Three 4-bit BCD values representing the three decimal digits are produced.                     |
| clk_divider         | Divides a 100MHz clock to 200Hz.                                                                                                 |
| debouncer           | A button debouncer, which sets the button output to high when the input has been high for five consecutive clock cycles.         |
| display             | Displays an 8-bit binary value as a signed decimal integer on the 7-segment display.                                             |
| fsm                 | Controls the flow of user interaction with the circuit.                                                                          |
| generic_register    | Produces a register with configurable width.                                                                                     |
| mux_4to1_8bit       | A 4-to-1 multiplexer, with 8-bit inputs and outputs, and 2 select bits.                                                          |
| top_level_structure | Structural module for the whole circuit.                                                                                         |
| tristate_buffer     | A tristate buffer with a configurable width.                                                                                     |