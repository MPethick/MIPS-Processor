//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.12.2020 20:06:05
// Design Name: 
// Module Name: memory_tb
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

module memory_tb;

    parameter real CLOCK_PERIOD = 100ns;
    parameter int DATA_WIDTH = 32;
    parameter int ADDRESS_WIDTH = 4;
    
    logic rst_n;
    logic [DATA_WIDTH - 1 : 0] write_data;
    logic [ADDRESS_WIDTH - 1 : 0] address;
    logic ctrl_mem_write;
    logic ctrl_mem_read;
    logic [DATA_WIDTH - 1 : 0] read_data;
    logic clk = 0;
    
    initial forever begin
        #(CLOCK_PERIOD/2);
        clk = ~clk;
    end
    
    initial begin
        #1ms;
        rst_n = 1'b0;
        #1ms;
        rst_n = 1'b1;
        write_data = 32'hdeadbeef;
        address = 4'h5;
        ctrl_mem_write = 1'b1;
        ctrl_mem_read = 1'b0;
        #1ms;
        ctrl_mem_write = 1'b0;
        ctrl_mem_read = 1'b1;
        address = 4'h7;
        #1ms;
        assert(read_data == '0) else $fatal("Data read back incorrectly as %x", read_data);
        #1ms;
        address = 4'h5;
        #1ms;
        assert(read_data == 32'hdeadbeef) else $fatal("Data read back incorrectly as %x", read_data);
        #1ms;
        $finish;
    end
    
    memory # (
        .DATA_WIDTH    (DATA_WIDTH),
        .ADDRESS_WIDTH (ADDRESS_WIDTH)
    ) memory (
        .clk           (clk),
        .rst_n         (rst_n),
        .write_data    (write_data),
        .address       (address),
        .ctrl_mem_write(ctrl_mem_write),
        .ctrl_mem_read (ctrl_mem_read),
        .read_data     (read_data)
    );
        
endmodule
