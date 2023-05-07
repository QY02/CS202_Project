`timescale 1ns / 1ps

module main (
    input clock,
    output seq
);

reg memWrite = 1'b0;
reg [31:0] address = 32'h0000_0010;
reg [31:0] writeData = 32'ha000_0000;
wire [31:0] readData;

reg [31:0] PC;

// Part of dmemory32 module
//Create a instance of RAM(IP core), binding the ports
RAM ram (
.clka(clk), // input wire clka
.wea(memWrite), // input wire [0 : 0] wea
.addra(address[15:2]), // input wire [13 : 0] addra
.dina(writeData), // input wire [31 : 0] dinas
.douta(readData) // output wire [31 : 0] douta
);
/*The ‘clock’ is from CPU-TOP, suppose its one edge has been used at the upstream module of data memory, such as IFetch, Why Data-Memroy DO NOT use the same edge as other module ? */
assign clk = !clock;

prgrom instmem(
.clka(clock),
.addra(PC[15:2]),
.douta(Instruction)
);


endmodule