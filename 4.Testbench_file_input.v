// 7-bit ASCII Character ATCG Sequence Matching Length Counter for DNA Expression
// Testbench: SequenceDetector (File Input Version)
// Required input files: dna_char.txt (8000 chars), target.txt (100 chars)
// Output: output.csv

module Testbench;
    reg clk;
    reg rst;
    reg [6:0] dna_char;
    reg [55999:0] dna_sequence;
    reg [699:0] target_sequence;
    wire [6:0] match_count;

    SequenceDetector detector (
        .clk(clk),
        .rst(rst),
        .dna_char(dna_char),
        .target_sequence(target_sequence),
        .match_count(match_count)
    );

    // ASCII conversion function for DNA characters (A, T, C, G)
    function [6:0] char_to_ascii(input [7:0] character);
        case (character)
            "A": char_to_ascii = 7'b1000001;
            "T": char_to_ascii = 7'b1010100;
            "C": char_to_ascii = 7'b1000011;
            "G": char_to_ascii = 7'b1000111;
            default: char_to_ascii = 7'b0000000;
        endcase
    endfunction

    always #5 clk = ~clk;

    integer file, i;

    // Load sequences from file and drive DUT
    initial begin
        clk = 0;
        rst = 1;
        dna_char = 7'b0;

        // Load DNA input sequence from file
        file = $fopen("dna_char.txt", "r");
        for (i = 0; i < 8000; i = i + 1) begin
            dna_sequence[(55999 - (i * 7)) -: 7] = char_to_ascii($fgetc(file));
        end
        $fclose(file);

        // Load target sequence from file
        file = $fopen("target.txt", "r");
        for (i = 0; i < 100; i = i + 1) begin
            target_sequence[(699 - (i * 7)) -: 7] = char_to_ascii($fgetc(file));
        end
        $fclose(file);

        #10 rst = 0;

        // Stream DNA characters into the detector
        for (i = 0; i < 8000; i = i + 1) begin
            dna_char = dna_sequence[(i * 7) +: 7];
            #10;
        end

        #20 $finish;
    end

    // CSV output logging
    initial begin
        file = $fopen("output.csv", "w");
        $fwrite(file, "time,rst,clk,dna_char,match_count\n");
        forever begin
            $fwrite(file, "%0t,%0b,%0b,%0d,%0d\n", $time, rst, clk, dna_char, match_count);
            #5;
        end
        $fclose(file);
    end
endmodule
