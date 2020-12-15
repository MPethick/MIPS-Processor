`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: 
// 
// Create Date: 15.12.2020 19:17:30
// Design Name: 
// Module Name: memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module memory # (
    parameter int DATA_WIDTH = 32,
    parameter int ADDRESS_WIDTH = 32
)
(
    input logic clk,
    input logic rst_n,
    
    input logic [DATA_WIDTH-1 : 0] write_data,
    input logic [ADDRESS_WIDTH - 1 : 0] address,
    
    input logic ctrl_mem_write,
    input logic ctrl_mem_read,
    
    output logic [DATA_WIDTH - 1 : 0] read_data
);

    typedef struct packed {
    logic [(2 ** ADDRESS_WIDTH) - 1 : 0][DATA_WIDTH - 1 : 0] mem;
    } mem_t;
    
    mem_t curr;
    mem_t next;
    
    always_ff@(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            curr <= '0;
        end else begin
            curr <= next;
        end
    end
    
    always_comb begin
        next = curr;
        read_data = '0;
        if(ctrl_mem_write && !ctrl_mem_read) begin
            next.mem[address] = write_data;
        end 
        else if(ctrl_mem_read) begin
             read_data = curr.mem[address];
        end
    end

endmodule