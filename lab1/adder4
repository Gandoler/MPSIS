module fulladder(
    input logic a_i,
    input logic b_i,
    input logic carry_i,  
    output logic sum_o, 
    output logic carry_o
);
assign sum_o = (a_i ^ b_i) ^ carry_i;
assign carry_o = (a_i & b_i) | ((a_i ^ b_i) & carry_i);
endmodule


module adder4(
    input logic [3:0] a_i,
    input logic [3:0] b_i,
    input logic carry_i,
    output logic [3:0] sum_o,
    output logic carry_o
);
    logic carry_0, carry_1, carry_2, carry_3;

    fulladder sum0(
        .a_i(a_i[0]),
        .b_i(b_i[0]),
        .carry_i(carry_i),
        .sum_o(sum_o[0]),
        .carry_o(carry_0)
    );

    fulladder sum1(
        .a_i(a_i[1]),
        .b_i(b_i[1]),
        .carry_i(carry_0),
        .sum_o(sum_o[1]),
        .carry_o(carry_1)
    );

    fulladder sum2(
        .a_i(a_i[2]),
        .b_i(b_i[2]),
        .carry_i(carry_1),
        .sum_o(sum_o[2]),
        .carry_o(carry_2)
    );

    fulladder sum3(
        .a_i(a_i[3]),
        .b_i(b_i[3]),
        .carry_i(carry_2),
        .sum_o(sum_o[3]),
        .carry_o(carry_o)
    );

endmodule
