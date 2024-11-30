class Stimulus;
  typedef enum bit[1:0] {ADD, SUB, INV, ROR} op_code;
  rand op_code opcode;
  rand bit signed [0:3] a, b;
  rand bit reset;

  function void generate_inputs();
    randomize();
    //$display("%s",opcode);
  endfunction
endclass

class Monitor;
  function void check(bit signed[0:3] a, bit signed[0:3] b, bit signed[0:4] sum, bit reset, bit[1:0] opcode);
    if (reset==0) begin
      if (opcode == 'b00)
        check_sum(a,b,sum);
      else if (opcode == 'b01)
        check_sub(a,b,sum);
      else if (opcode == 'b10)
        check_inv(a,sum);
  	  else 
        check_ror(b,sum);
    end
    else if (reset==1) begin
      a ='b0000;
      b ='b0000;
      $display("PASS: reset operation complete--- of a= %b -- b= %b", a,b);
    end
    else begin
      $display("FAIL: reset operation Failed");
    end

  endfunction
  
  function void check_sum(bit signed[0:3] a, bit signed[0:3] b, bit signed[0:4] sum);
    if (sum == a + b)
      $display("PASS: %p + %p = %p", a, b, sum);
    else
      $display("FAIL: %p + %p != %p", a, b, sum);
  endfunction
  function void check_sub(bit signed[0:3] a, bit signed[0:3] b, bit signed[0:4] sub);
    if (sub == a - b)
      $display("PASS: %p - %p = %p", a, b, sub);
    else
      $display("FAIL: %p - %p != %p", a, b, sub);
  endfunction
  function void check_inv(bit signed[0:3] a, bit signed[0:4] inv);
    if (inv == ~a)
      $display("PASS: ~ of %b = %p", a, inv);
    else
      $display("FAIL: ~ of %b != %b", a, inv);
  endfunction
  function void check_ror(bit signed[0:3] b, bit signed[0:4] ror);
    if (ror == |b)
      $display("PASS: | of %b = %d", b, ror);
    else
      $display("FAIL: | of %b != %d", b, ror);
  endfunction

endclass

class DUT;
  bit signed[0:4] sum;


  function void adder(bit signed[0:3] a, bit signed[0:3] b, bit reset, bit[1:0] opcode);
    
     if (opcode == 'b00) begin
      sum = a + b;
      
    end 
    else if (opcode == 'b01) begin
      sum = a - b;
      
    end 
    else if (opcode == 'b10) begin
      sum = ~a;
      
    end 
    else if (opcode == 'b11) begin
      sum = |b;
      
    end
    else begin
      a='b0000;
      b='b0000;
      
    end
  endfunction
endclass
