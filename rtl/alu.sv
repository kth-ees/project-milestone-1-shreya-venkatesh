module alu #(
  BW = 16 // bitwidth
  ) (
  input  logic unsigned [BW-1:0] in_a,
  input  logic unsigned [BW-1:0] in_b,
  input  logic             [3:0] opcode,
  output logic unsigned [BW-1:0] out,
  output logic             [2:0] flags // {overflow, negative, zero}
  );

    logic overflow, negative, zero;
    logic signed [BW-1:0] result;
    logic logical_result;

    always_comb begin
        overflow = 1'b0;
        logical_result = 1'b0;
        result = '0;
        
        case (opcode)
            3'd0: result = in_a + in_b;                    // Addition
            3'd1: result = in_a - in_b;                    // Subtraction
            3'd2: begin                                    // Logical AND
                logical_result = (in_a != 0) && (in_b != 0);
                result = { {(BW-1){1'b0}}, logical_result };
            end
            3'd3: begin                                    // Logical OR
                logical_result = (in_a != 0) || (in_b != 0);
                result = { {(BW-1){1'b0}}, logical_result };
            end
            3'd4: begin                                    // Logical XOR
                logical_result = (in_a != 0) ^ (in_b != 0);
                result = { {(BW-1){1'b0}}, logical_result };
            end
            3'd5: result = in_a + 1'b1;                    // Increment A
            3'd6: result = in_a;                           // Passthrough A
            3'd7: result = in_b;                           // Passthrough B
            default: result = '0;
        endcase
      
        if (opcode == 3'd0) begin 
            overflow = (in_a[BW-1] == in_b[BW-1]) && (result[BW-1] != in_a[BW-1]);
        end else if (opcode == 3'd1) begin 
            overflow = (in_a[BW-1] != in_b[BW-1]) && (result[BW-1] != in_a[BW-1]);
        end else begin
            overflow = 1'b0; 
        end
        //Flags
        negative = result[BW-1];
        zero = (result == 0);
        out = result;
        flags = {overflow, negative, zero};
    end
endmodule




