// 7-bit ASCII Character ATCG Sequence Highest Similarity Detection for DNA Expression
// Testbench: SequenceDetector (Smith-Waterman Algorithm)
// Required input files: chimpanzee_dna.txt, covid_dna.txt
// Output: output.csv

module Testbench #(
    parameter target_size = 29626,
    parameter seq_size    = 3253200
);
    reg clk;
    reg rst;
    reg [6:0] dna_char;
    reg [(seq_size*7 - 1):0]    dna_sequence;
    reg [(target_size*7 - 1):0] target_sequence;
    wire [6:0] max_score;

    SequenceDetector detector (
        .clk(clk),
        .rst(rst),
        .dna_char(dna_char),
        .target_sequence(target_sequence),
        .max_score(max_score)
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

        // Load chimpanzee DNA sequence from file
        file = $fopen("chimpanzee_dna.txt", "r");
        for (i = 0; i < seq_size; i = i + 1) begin
            dna_sequence[((seq_size*7 - 1) - (i * 7)) -: 7] = char_to_ascii($fgetc(file));
        end
        $fclose(file);

        // Load COVID-19 target sequence from file
        file = $fopen("covid_dna.txt", "r");
        for (i = 0; i < target_size; i = i + 1) begin
            target_sequence[((target_size*7 - 1) - (i * 7)) -: 7] = char_to_ascii($fgetc(file));
        end
        $fclose(file);

        #10 rst = 0;

        // Stream chimpanzee DNA characters into the detector
        for (i = 0; i < seq_size; i = i + 1) begin
            dna_char = dna_sequence[((seq_size*7 - 1) - (i * 7)) -: 7];
            #10;
        end

        #20 $finish;
    end

    // CSV output logging
    initial begin
        file = $fopen("output.csv", "w");
        $fwrite(file, "time,rst,clk,dna_char,max_score\n");
        forever begin
            $fwrite(file, "%0t,%0b,%0b,%0d,%0d\n", $time, rst, clk, dna_char, max_score);
            #5;
        end
        $fclose(file);
    end
endmodule
