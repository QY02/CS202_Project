# **CS202 Project CPU Implementation** 



**秦尧 12112016**

**谢尚儒 12112017**

**陶毅诚 12112003**



# Developer's infomation

| Name   | Task                                                         | Contributions |
| ------ | ------------------------------------------------------------ | ------------- |
| 秦尧   | VGA, Decoder, MemOrIO, IFetch, LED, Report                   | 33.3%         |
| 陶毅诚 | CPU-top, ALU,D-memory, Switch, Keyboard, Report ,Bonus video | 33.3%         |
| 谢尚儒 | All assemble scripts, UART, Controller, Report               | 33.3%         |



# CPU architecture design

## CPU characteristics

### ISA

We implemented the **MIPS32 Instruction Set**.

#### 1.R Type Instructions

**（1）R Type Instruction Format**

| 000000 （op) | Rs    | Rt    | Rd    | shamt | funct |
| ------------ | ----- | ----- | ----- | ----- | ----- |
| 6bits        | 5bits | 5bits | 5bits | 5bits | 6bits |

**（2）Specific R Type Instructions**

【1】with 3 registers

| 指令 | [31 : 26] | [25 : 21] | [20 : 16] | [15 : 11] | [10 : 6] | [5 : 0]    |
| ---- | --------- | --------- | --------- | --------- | -------- | ---------- |
| nor  | 000000    | rs        | rt        | rd        | 00000    | 100111(27) |
| add  | 000000    | rs        | rt        | rd        | 00000    | 100000(32) |
| addu | 000000    | rs        | rt        | rd        | 00000    | 100001(33) |
| sub  | 000000    | rs        | rt        | rd        | 00000    | 100010(34) |
| subu | 000000    | rs        | rt        | rd        | 00000    | 100011(35) |
| and  | 000000    | rs        | rt        | rd        | 00000    | 100100(36) |
| or   | 000000    | rs        | rt        | rd        | 00000    | 100101(37) |
| xor  | 000000    | rs        | rt        | rd        | 00000    | 100110(38) |
| slt  | 000000    | rs        | rt        | rd        | 00000    | 101010(42) |
| sltu | 000000    | rs        | rt        | rd        | 00000    | 101011(43) |
| sllv | 000000    | rs        | rt        | rd        | 00000    | 000100(4)  |
| srlv | 000000    | rs        | rt        | rd        | 00000    | 000110(6)  |
| srav | 000000    | rs        | rt        | rd        | 00000    | 000111(7)  |

【2】with 2 registers

| 指令 | [31 : 26] | [25 : 21] | [20 : 16] | [15 : 11] | [10 : 6] | [5 : 0]    |
| ---- | --------- | --------- | --------- | --------- | -------- | ---------- |
| sll  | 000000    | 00000     | rt        | rd        | sa       | 100000(32) |
| srl  | 000000    | 00000     | rt        | rd        | sa       | 000010(2)  |
| sra  | 000000    | 00000     | rt        | rd        | sa       | 000011(3)  |

【3】with one register 

| 指令 | [31 : 26] | [25 : 21] | [20 : 16] | [15 : 11] | [10 : 6] | [5 : 0]   |
| ---- | --------- | --------- | --------- | --------- | -------- | --------- |
| jr   | 000000    | rs        | 00000     | 00000     | 00000    | 001000(8) |

#### 2.I Type Instructions

**（1）I Type Instruction Format**

| OP    | Rs    | Rt    | imm    |
| ----- | ----- | ----- | ------ |
| 6bits | 5bits | 5bits | 16bits |

**（2）Specific I Type Instructions**

【1】For ALU

| 指令  | [31 : 26] | [25 : 21] | [20 : 16] | [15 : 0] |
| ----- | --------- | --------- | --------- | -------- |
| addi  | 001000    | rs        | rt        | imm      |
| addiu | 001001    | rs        | rt        | imm      |
| andi  | 001100    | rs        | rt        | imm      |
| ori   | 001101    | rs        | rt        | imm      |
| xori  | 001110    | rs        | rt        | imm      |
| slti  | 001010    | rs        | rt        | imm      |
| sltiu | 001011    | rs        | rt        | imm      |

【2】For memory 

| 指令 | [31 : 26] | [25 : 21] | [20 : 16] | [15 : 0] |
| ---- | --------- | --------- | --------- | -------- |
| lw   | 100011    | rs        | rt        | imm      |
| sw   | 101011    | rs        | rt        | imm      |

【3】LUI

| 指令 | [31 : 26] | [25 : 21] | [20 : 16] | [15 : 0] |
| ---- | --------- | --------- | --------- | -------- |
| lui  | 001111    | 00000     | rt        | imm      |

【4】For branch

| 指令 | [31 : 26] | [25 : 21] | [20 : 16] | [15 : 0] |
| ---- | --------- | --------- | --------- | -------- |
| beq  | 000100    | rs        | rt        | imm      |
| bne  | 000101    | rs        | rt        | imm      |

#### 3. J Type Instructions

**（1）J Type Instruction Format**

| OP    | Imme   |
| ----- | ------ |
| 6bits | 26bits |

**（2）Specific J Type Instructions**

| 指令 | [31 : 26] | [25 : 0] |
| ---- | --------- | -------- |
| j    | 000010    | address  |
| jal  | 001100    | address  |

### Registers

We have 32 registers. Each register has 32 bits.

### Addressing Mode design

We chose **Harvard architecture**.

Addressing unit, size of instruction space, data space

### Support for external IO

We choose **MMIO** (and the corresponding addresses of related peripherals), using **round-robin** IO.

### CPU的CPI，属于单周期还是多周期CPU，是否支持pipeline(如支持，是几级流水，采用什么方式解决的流水线冲突问题)。



## CPU interface

All codes below is in `cpu_top.xdc`.

### CPU Clock

```verilog
set_property IOSTANDARD LVCMOS33 [get_ports {fpga_clk}]
set_property PACKAGE_PIN Y18 [get_ports {fpga_clk}]
```

### Reset

```verilog
set_property IOSTANDARD LVCMOS33 [get_ports {reset_h}]
set_property PACKAGE_PIN P1 [get_ports {reset_h}]
```

### UART

```verilog
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN Y19} [get_ports rx]
set_property -dict {IOSTANDARD LVCMOS33 PACKAGE_PIN V18} [get_ports tx]
```

### Switch

```verilog
set_property IOSTANDARD LVCMOS33 [get_ports {switch[23]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[22]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[21]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[20]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[19]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[18]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[17]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[16]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switch[0]}]
set_property PACKAGE_PIN AA8 [get_ports {switch[18]}]
set_property PACKAGE_PIN V8 [get_ports {switch[17]}]
set_property PACKAGE_PIN V9 [get_ports {switch[16]}]
set_property PACKAGE_PIN Y9 [get_ports {switch[23]}]
set_property PACKAGE_PIN W9 [get_ports {switch[22]}]
set_property PACKAGE_PIN Y7 [get_ports {switch[21]}]
set_property PACKAGE_PIN Y8 [get_ports {switch[20]}]
set_property PACKAGE_PIN AB8 [get_ports {switch[19]}]
set_property PACKAGE_PIN AB6 [get_ports {switch[15]}]
set_property PACKAGE_PIN AB7 [get_ports {switch[14]}]
set_property PACKAGE_PIN V7 [get_ports {switch[13]}]
set_property PACKAGE_PIN AA6 [get_ports {switch[12]}]
set_property PACKAGE_PIN Y6 [get_ports {switch[11]}]
set_property PACKAGE_PIN T6 [get_ports {switch[10]}]
set_property PACKAGE_PIN R6 [get_ports {switch[9]}]
set_property PACKAGE_PIN V5 [get_ports {switch[8]}]
set_property PACKAGE_PIN U6 [get_ports {switch[7]}]
set_property PACKAGE_PIN W5 [get_ports {switch[6]}]
set_property PACKAGE_PIN W6 [get_ports {switch[5]}]
set_property PACKAGE_PIN U5 [get_ports {switch[4]}]
set_property PACKAGE_PIN T5 [get_ports {switch[3]}]
set_property PACKAGE_PIN T4 [get_ports {switch[2]}]
set_property PACKAGE_PIN R4 [get_ports {switch[1]}]
set_property PACKAGE_PIN W4 [get_ports {switch[0]}]
```

### LED

```verilog
set_property PACKAGE_PIN K17 [get_ports {led_out[23]}]
set_property PACKAGE_PIN L13 [get_ports {led_out[22]}]
set_property PACKAGE_PIN M13 [get_ports {led_out[21]}]
set_property PACKAGE_PIN K14 [get_ports {led_out[20]}]
set_property PACKAGE_PIN K13 [get_ports {led_out[19]}]
set_property PACKAGE_PIN M20 [get_ports {led_out[18]}]
set_property PACKAGE_PIN N20 [get_ports {led_out[17]}]
set_property PACKAGE_PIN N19 [get_ports {led_out[16]}]
set_property PACKAGE_PIN M17 [get_ports {led_out[15]}]
set_property PACKAGE_PIN M16 [get_ports {led_out[14]}]
set_property PACKAGE_PIN M15 [get_ports {led_out[13]}]
set_property PACKAGE_PIN K16 [get_ports {led_out[12]}]
set_property PACKAGE_PIN L16 [get_ports {led_out[11]}]
set_property PACKAGE_PIN L15 [get_ports {led_out[10]}]
set_property PACKAGE_PIN L14 [get_ports {led_out[9]}]
set_property PACKAGE_PIN J17 [get_ports {led_out[8]}]
set_property PACKAGE_PIN F21 [get_ports {led_out[7]}]
set_property PACKAGE_PIN G22 [get_ports {led_out[6]}]
set_property PACKAGE_PIN G21 [get_ports {led_out[5]}]
set_property PACKAGE_PIN D21 [get_ports {led_out[4]}]
set_property PACKAGE_PIN E21 [get_ports {led_out[3]}]
set_property PACKAGE_PIN D22 [get_ports {led_out[2]}]
set_property PACKAGE_PIN E22 [get_ports {led_out[1]}]
set_property PACKAGE_PIN A21 [get_ports {led_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[23]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[22]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[21]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[20]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[19]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[18]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[17]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[16]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_out[0]}]
```

### VGA

```verilog
set_property PACKAGE_PIN M21 [get_ports {hsync}]
set_property PACKAGE_PIN L21 [get_ports {vsync}]

set_property PACKAGE_PIN H20 [get_ports {vga_rgb[0]}]
set_property PACKAGE_PIN G20 [get_ports {vga_rgb[1]}]
set_property PACKAGE_PIN K21 [get_ports {vga_rgb[2]}]
set_property PACKAGE_PIN K22 [get_ports {vga_rgb[3]}]
set_property PACKAGE_PIN H17 [get_ports {vga_rgb[4]}]
set_property PACKAGE_PIN H18 [get_ports {vga_rgb[5]}]
set_property PACKAGE_PIN J22 [get_ports {vga_rgb[6]}]
set_property PACKAGE_PIN H22 [get_ports {vga_rgb[7]}]
set_property PACKAGE_PIN G17 [get_ports {vga_rgb[8]}]
set_property PACKAGE_PIN G18 [get_ports {vga_rgb[9]}]
set_property PACKAGE_PIN J15 [get_ports {vga_rgb[10]}]
set_property PACKAGE_PIN H15 [get_ports {vga_rgb[11]}]
```

### Seven-segment Display

```verilog
set_property PACKAGE_PIN C19 [get_ports {seg_en[0]}]
set_property PACKAGE_PIN E19 [get_ports {seg_en[1]}]
set_property PACKAGE_PIN D19 [get_ports {seg_en[2]}]
set_property PACKAGE_PIN F18 [get_ports {seg_en[3]}]
set_property PACKAGE_PIN E18 [get_ports {seg_en[4]}]
set_property PACKAGE_PIN B20 [get_ports {seg_en[5]}]
set_property PACKAGE_PIN A20 [get_ports {seg_en[6]}]
set_property PACKAGE_PIN A18 [get_ports {seg_en[7]}]

set_property PACKAGE_PIN E13 [get_ports {seg_out[0]}]
set_property PACKAGE_PIN C15 [get_ports {seg_out[1]}]
set_property PACKAGE_PIN C14 [get_ports {seg_out[2]}]
set_property PACKAGE_PIN E17 [get_ports {seg_out[3]}]
set_property PACKAGE_PIN F16 [get_ports {seg_out[4]}]
set_property PACKAGE_PIN F14 [get_ports {seg_out[5]}]
set_property PACKAGE_PIN F13 [get_ports {seg_out[6]}]
set_property PACKAGE_PIN F15 [get_ports {seg_out[7]}]
```



## CPU internal structure

### Connection Schematic of submodules inside the CPU



### Design Specification of submodules

#### CPU_top(cpu_top.v)

#### ALU(alu.v)

#### Data Memory(dmemory32.v)

#### Instruction Fetch(ifetch.v)

#### MemOrIO(MemOrIO.v)

#### Decoder(decoder.v)

#### Controller(contol32.v)



# Test Demonstration

## On Board Test

### **Basic Test Scenario 1**

Note: 3+8 switch on the development board are used for input, of which 3 switches (x2,.. x0) are used for number input of test cases, 8 switches (sw7,.. sw0) are used for input of test data, and LED lights or seven-segments display tubes are used for output

| **ID** | **Testcase Description**                                     |
| ------ | ------------------------------------------------------------ |
| 3‘b000 | Enter the test number **a**, display **a** on the LED light. At the same time, use one LED light to determine **whether a is a power of two** (e.g. 8'h01 and 8'h10 are powers of two, the LED light is on. 8'ha0 and 8'h0a are not powers of two, the LED light is not on) |
| 3‘b001 | Input the test number **a**, display **a** on the output device. At the same time, use one LED light to display **whether a is an odd number**(e.g, 8'h01 and 8'hab are odd numbers, the LED light will be on. 8'ha0 and 8'hbc are not odd numbers, the LED light is not on) |
| 3‘b010 | Execute testcase 3'b111 first, then calculate the bitwise **OR** operation of **a** and **b**, and display the results on the output device |
| 3‘b011 | Execute testcase 3'b111 first, then calculate the bitwise **NOR** operation of **a** and **b**, and display the results on the output device |
| 3‘b100 | Execute test case 3'b111 first, then calculate the bitwise **XOR** operation of **a** and **b**, and display the results on the output device |
| 3‘b101 | First execute test case 3'b111, then execute the **SLT** instruction, **compare a and b as signed numbers**, and use the output device to demonstrate whether the relationship between a and b is valid.(Relationship established, light on, relationship not established, light off) |
| 3‘b110 | First execute test case 3'b111, then execute the **SLTU** instruction, **compare a and b as unsigned numbers**, and use the output device to demonstrate whether the relationship between a and b is valid(Relationship established, light on, relationship not established, light off) |
| 3‘b111 | Input test number a, input test number b, and display the values of a and b on the output device |

### Test Results

| ID     | Input/Operation | Output/Behavior |
| ------ | --------------- | --------------- |
| 3'b000 |                 |                 |
| 3'b001 |                 |                 |
| 3'b010 |                 |                 |
| 3'b011 |                 |                 |
| 3'b100 |                 |                 |
| 3'b101 |                 |                 |
| 3'b110 |                 |                 |
| 3'b111 |                 |                 |

### **Basic Test Scenario 2-1**

3+8 switch on the development board are used for input, of which 3 switch (x3-x0) are used for the number input of test cases, and 8 switch (sw7,.. Sw0) are used for the input of test data (sw7 corresponds to the highest bit bit of 8bit bit7, sw0 corresponds to the lowest bit bit bit of 8bit bit0);

| **ID** | **Testcase Description**                                     |
| ------ | ------------------------------------------------------------ |
| 3‘b000 | Enter the numerical value of **a** (**a is considered a signed number**), **calculate the cumulative sum of 1 to a,** and display the cumulative sum on the output device **(if a is a negative number, give a blinking prompt**) |
| 3‘b001 | Enter the numerical value of **a (a is considered an unsigned number), recursively calculate the sum of 1 to a**, record the number of times the stack was pushed and pushed, and **display the sum of the times the stack was pushed and popped on the output device** |
| 3‘b010 | Enter the numerical value of **a (a is considered an unsigned number)**, **recursively calculate the sum of 1 to a,** record the data of stack entry and exit, and **display the parameters which is pushed to the stack on the output device**. **Each parameter of the stack is displayed for 2-3 seconds** (indicating that the output here does not pay attention to the stack entry and exit information of $ra) |
| 3‘b011 | Enter the numerical value of **a (a is considered an unsigned number)**, **recursively calculate the sum of 1 to a,** record the data of stack entry and exit, and **display the parameters which is popped from the stack on the output device**. **Each parameter of the stack is displayed for 2-3 seconds** (indicating that the output here does not pay attention to the stack entry and exit information of $ra) |
| 3‘b100 | Input test number **a** and test number **b** to implement the **addition of signed numbers** (**a, b, and the sum of additions are all 8 bits, where the highest bit is considered the sign bit. If the sign bit is 1, it represents the 2’s complement of the negative number**), and determine whether overflow occurs. **Output the operation result and overflow judgment** |
| 3‘b101 | Input test number **a** and test number **b** to **subtract signed numbers** (**a, b, and the difference are all 8 bits, where the highest bit is considered as the sign bit. If the sign bit is 1, it represents the 2’s complement of the negative number**), and determine whether overflow occurs. Output the operation result and overflow judgment |
| 3‘b110 | Input test number **a** and test number **b** to implement **the multiplication of signed numbers (a and b are both 8 bits, the product is 16 bits, and the highest bit is considered as the sign bit. If the sign bit is 1, it represents the 2’s complement of the negative number)**, and **output the product** |
| 3‘b111 | Input test number **a** and test number **b** to achieve **division of signed numbers (a, b, quotient and remainder are both 8 bits, where the highest bit is considered the sign bit. If the sign bit is 1, it represents the complement of the negative number**), and **output quotient and remainder (quotient and remainder are displayed alternately, each lasting for 5 seconds)** |

### Test Results

| ID     | Input/Operation | Output/Behavior |
| ------ | --------------- | --------------- |
| 3'b000 |                 |                 |
| 3'b001 |                 |                 |
| 3'b010 |                 |                 |
| 3'b011 |                 |                 |
| 3'b100 |                 |                 |
| 3'b101 |                 |                 |
| 3'b110 |                 |                 |
| 3'b111 |                 |                 |

# Bonus

- 1)Implement support for complex peripheral interfaces (such as VGA interfaces, mini keyboard interfaces, etc.)

  Ø Explanation: In this course, only access to complex peripheral interfaces achieved through software and hardware collaboration is supported (that is, accessing related complex peripherals through corresponding instructions or corresponding address information in instructions, rather than just using hardware control to achieve the use of complex peripherals)。

  Ø 2)Use the uart interface to load different programs onto the CPU for execution without rewriting the FPGA chip。 Ø 3)Optimize performance based on existing Minisys ISA implemented CPUs (pipeline, cache, SIMD, etc.)

  Ø Explanation: Relevant comparison cases and proof of performance improvement need to be provided simultaneously。 Ø 4)ISA for existing Minisys, instruction type extension, function extension, and implementation。
   Ø 5)Better user experience

  Ø For example, the results of bit operations are displayed with LED, and the results of arithmetic operations are displayed with 7 segments of Nixie tube, etc

  

# Problems and Summary

## Problems



## Summary

