module alu (
    input  logic [31:0]  a_i,      // Первый операнд
    input  logic [31:0]  b_i,      // Второй операнд
    input  logic [4:0]   alu_op_i, // Код операции
    output logic [31:0]  result_o, // Результат операции
    output logic         flag_o    // Флаг сравнения
);

    // Импортируем пакет с кодами операций
import alu_opcodes_pkg::*;

logic tmp_carty_i = 1'b0;

logic [31:0] tmp_res; 
   adder32 milashkaadder(
            .a_i(a_i),
            .b_i(b_i),
            .carry_i(1'b0),
            .sum_o(tmp_res),
            .carry_o()
            );
    
    
    
    always_comb begin
        result_o = 32'b0; // По умолчанию результат = 0
        case (alu_op_i)
            ALU_ADD:  result_o = tmp_res;
            ALU_SUB:  result_o = a_i - b_i;
            ALU_XOR:  result_o = a_i ^ b_i;
            ALU_OR:   result_o = a_i | b_i;
            ALU_AND:  result_o = a_i & b_i;
            ALU_SLL:  result_o = a_i << b_i[4:0]; // Сдвиг влево
            ALU_SRL:  result_o = a_i >> b_i[4:0]; // Логический сдвиг вправо
            ALU_SRA:  result_o = $signed(a_i) >>> b_i[4:0]; // Арифметический сдвиг вправо
            ALU_SLTS: result_o = ($signed(a_i) < $signed(b_i)) ? 32'd1 : 32'd0;
            ALU_SLTU: result_o = (a_i < b_i) ? 32'd1 : 32'd0;
            default:  result_o = 32'b0;
        endcase
    end

    always_comb begin
        flag_o = 1'b0; // По умолчанию флаг = 0
        case (alu_op_i)
            ALU_LTS:  flag_o = ($signed(a_i) < $signed(b_i));
            ALU_LTU:  flag_o = (a_i < b_i);
            ALU_GES:  flag_o = ($signed(a_i) >= $signed(b_i));
            ALU_GEU:  flag_o = (a_i >= b_i);
            ALU_EQ:   flag_o = (a_i == b_i);
            ALU_NE:   flag_o = (a_i != b_i);
            default:  flag_o = 1'b0;
        endcase
    end

endmodule
