module TB_Adder();

  reg [31:0] test32_in1;
  reg [31:0] test32_in2;
  reg test32_cin;
  reg test_clk;

  wire [31:0] test32_sum;
  wire test32_cout;

  integer i;  // Declare integer outside procedural blocks

  // Instantiate DUT
  Adder dut32(
    .TClk(test_clk),
    .ra(test32_in1),
    .rb(test32_in2),
    .cin(test32_cin),
    .Sum(test32_sum),
    .Cout(test32_cout)
  );

  // Clock generation
  initial begin
    test_clk = 0;
    forever #5 test_clk = ~test_clk;
  end

  // Apply random stimulus
  initial begin
    for (i = 0; i < 1000; i = i + 1) begin
      @(negedge test_clk);
      test32_in1 = $random;
      test32_in2 = $random;
      test32_cin = $random % 2;
      @(posedge test_clk);
      #10;
    end
    #100 $finish;
  end

  // Monitor output
  initial begin
    $monitor("Time=%0t | IN1=%h IN2=%h CIN=%b | SUM=%h COUT=%b",
      $time, test32_in1, test32_in2, test32_cin, test32_sum, test32_cout);
    $dumpfile("adder_test.vcd");
    $dumpvars(0, TB_Adder);
  end

endmodule

