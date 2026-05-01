// 7-Bit ASCII Character ATGC Sequence Matching Length Counter for DNA Expression
// Module: SequenceDetector (Basic - Fixed Target)

module SequenceDetector (
    input wire clk,
    input wire rst,
    input wire [6:0] dna_char,
    input wire [125:0] target,
    output reg [4:0] match_count
);
    integer i;
    reg flag;
    reg [6:0] counter;
    reg [125:0] shift_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            shift_reg <= 0;
            match_count <= 0;
        end else begin
            shift_reg <= {shift_reg[118:0], dna_char};
            counter = 0;
            flag = 0;
            for (i = 0; i < 18; i = i + 1) begin
                if (shift_reg[(i * 7) +: 7] != target[((17-i) * 7) +: 7]) begin
                    flag = 1;
                end else if (!flag) begin
                    counter = counter + 1;
                end
            end
            match_count <= counter;
        end
    end
endmodule
