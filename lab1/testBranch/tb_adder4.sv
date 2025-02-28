module tb_adder4();
    logic [3:0] a_i;
    logic [3:0] b_i;
    logic carry_i;
    logic [3:0] sum_o;
    logic carry_o;

    adder4 DUT (
        .a_i(a_i),
        .b_i(b_i),
        .carry_i(carry_i),
        .sum_o(sum_o),
        .carry_o(carry_o)
    );

    initial begin
        $display("Starting testbench for adder4");

        
        for (int i = 0; i < 16; i++) begin
            a_i = i[3:0];
            for (int j = 0; j < 16; j++) begin
                b_i = j[3:0];
                for (int k = 0; k < 2; k++) begin
                    carry_i = k;
                    #10; 

                   
                    $display("a_i=%b, b_i=%b, carry_i=%b, sum_o=%b, carry_o=%b", 
                            a_i, b_i, carry_i, sum_o, carry_o);
                end
            end
        end

        $finish();
    end
endmodule
