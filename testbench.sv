module tb_adder;
  Stimulus stim;
  DUT dut;
  Monitor monitor;
  

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1,tb_adder);
    stim = new();
    monitor = new();
    dut= new();
    
    repeat (20) begin
      stim.generate_inputs();
      //stim.reset=0;
      dut.adder(stim.a, stim.b, stim.reset, stim.opcode);
      monitor.check(stim.a, stim.b, dut.sum, stim.reset, stim.opcode);
    end

    $display("Running Directed Tests...");
    dut.adder(6, 'b0000, 0, Stimulus::INV);
    monitor.check(6,'b0000, dut.sum, 0, Stimulus::INV);
//     dut.adder('b1111, 'b0000, 0, Stimulus::SUB);
//     dut.adder('b0000, 'b0000, 0, Stimulus::SUB);
//     dut.adder('b0000, 'b1111, 0, Stimulus::SUB);
//     dut.adder('b1111, 'b0000, 0, Stimulus::INV);
//     dut.adder('b1010, 'b0000, 0, Stimulus::INV);
//     dut.adder('b0101, 'b0000, 0, Stimulus::INV);
//     dut.adder('b0000, 'b0000, 0, Stimulus::INV);
//     dut.adder('b1111, 'b0000, 0, Stimulus::ROR);
//     dut.adder('b1111, 'b1111, 0, Stimulus::ROR);
     $display("Ending Directed Tests...");
  end
endmodule