// 7-bit ASCII Character ATCG Sequence Highest Similarity Detection for DNA Expression
// Module: SequenceDetector (Smith-Waterman Algorithm)

module SequenceDetector #(parameter target_size = 29626)(
    input wire clk,
    input wire rst,
    input wire [6:0] dna_char,
    input wire [(target_size*7 - 1):0] target_sequence,
    output reg [6:0] max_score
);
    parameter MATCH_SCORE      =  1;
    parameter MISMATCH_PENALTY = -1;
    parameter GAP_PENALTY      = -2;

    reg [6:0] dp[0:target_size];
    reg [6:0] prev_dp[0:target_size];
    integer i;
    reg [6:0] score;
    reg [6:0] max_val;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            max_score <= 0;
            for (i = 0; i <= target_size; i = i + 1) begin
                dp[i]      <= 0;
                prev_dp[i] <= 0;
            end
        end else begin
            max_val = 0;

            for (i = 0; i <= target_size; i = i + 1) begin
                if (i == 0) begin
                    dp[i] <= 0;
                end else begin
                    // Score from diagonal (match/mismatch)
                    if (dna_char == target_sequence[((target_size*7 - 1) - ((i - 1) * 7)) -: 7])
                        score = prev_dp[i - 1] + MATCH_SCORE;
                    else begin
                        if (prev_dp[i - 1] > 0)
                            score = prev_dp[i - 1] + MISMATCH_PENALTY;
                    end

                    // Score from left (gap in target)
                    if (dp[i-1] > 1)
                        score = (dp[i - 1] + GAP_PENALTY > score) ? dp[i - 1] + GAP_PENALTY : score;
                    else
                        score = score;

                    // Score from above (gap in query)
                    if (prev_dp[i] > 1)
                        score = (prev_dp[i] + GAP_PENALTY > score) ? prev_dp[i] + GAP_PENALTY : score;
                    else
                        score = score;

                    dp[i] <= score;

                    if (dp[i] > max_val)
                        max_val = dp[i];
                end
            end

            max_score <= (max_val > max_score) ? max_val : max_score;

            // Shift DP row for next iteration
            for (i = 0; i <= target_size; i = i + 1) begin
                prev_dp[i] <= dp[i];
            end
        end
    end
endmodule
