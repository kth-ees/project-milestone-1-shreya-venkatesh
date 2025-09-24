module alu_tb;

  parameter BW = 16; // bitwidth

  logic unsigned [BW-1:0] in_a;
  logic unsigned [BW-1:0] in_b;
  logic             [3:0] opcode;
  logic unsigned [BW-1:0] out;
  logic             [2:0] flags; // {overflow, negative, zero}

  // Instantiate the ALU
  alu #(BW) dut (
    .in_a(in_a),
    .in_b(in_b),
    .opcode(opcode),
    .out(out),
    .flags(flags)
  );

  // Generate stimuli to test the ALU
  initial begin
        in_a = 20; in_b = 5; opcode = 3'b000; #10; 
        in_a = 20; in_b = 5; opcode = 3'b001; #10; 
        in_a = 20; in_b = 5; opcode = 3'b010; #10; 
        in_a = 20; in_b = 5; opcode = 3'b011; #10; 
        in_a = 20; in_b = 5; opcode = 3'b100; #10; 
        in_a = 20; in_b = 0; opcode = 3'b101; #10; 
        in_a = 20; in_b = 0; opcode = 3'b110; #10; 
        in_a = 0;  in_b = 20; opcode = 3'b111; #10; 

        repeat (20) begin
            in_a   = $urandom_range(-50, 50);
            in_b   = $urandom_range(-50, 50);
            opcode = $urandom_range(0, 7);
            #10;
        end

        $finish;
    end
  end
endmodule
