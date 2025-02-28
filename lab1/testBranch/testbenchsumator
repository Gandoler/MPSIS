module testbench();
logic a, b, carry_i, sum,carry_o;

  fulladder DUT(                 
    .a_i    (a),
    .b_i    (b),
    .carry_i(carry_i),
    .sum_o  (sum),
    .carry_o(carry_o)
);

  initial begin
    $display("Starting testbench for fulladder");
    
    for (int i = 0; i < 8; i++) begin
            a = i[2:0];
            for (int j = 0; j < 8; j++) begin
                b = j[2:0];
                for (int k = 0; k < 2; k++) begin
                    carry_i = k;
                    #10;
                    $display("a=%b, b=%b, carry_i=%b, sum=%b, carry_o=%b", a, b, carry_i, sum, carry_o);
                end
            end
        end
    
    $finish();
	end

endmodule
