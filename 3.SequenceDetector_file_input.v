// 7-bit ASCII Character ATCG Sequence Matching Length Counter for DNA Expression
// Module: SequenceDetector (File Input Version)

module SequenceDetector (
    input wire clk,
    input wire rst,
    input wire [6:0] dna_char,
    input wire [699:0] target_sequence,
    output reg [6:0] match_count
);
    integer i;
    reg flag;
    reg [6:0] counter;
    reg [699:0] shift_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            shift_reg <= 0;
            match_count <= 0;
        end else begin
            shift_reg <= {dna_char, shift_reg[699:7]};
            counter = 0;
            flag = 0;
            for (i = 0; i < 100; i = i + 1) begin
                if (shift_reg[(699 - (i * 7)) -: 7] != target_sequence[(699 - (i * 7)) -: 7]) begin
                    flag = 1;
                end else if (!flag) begin
                    counter = counter + 1;
                end
            end
            match_count <= counter;
        end
    end
endmodule
