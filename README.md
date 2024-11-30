# Testbench for Arithmetic Logic Unit (ALU) with Randomized Stimulus

## Overview
This project implements a SystemVerilog testbench for a simple Arithmetic Logic Unit (ALU). The ALU performs operations such as addition, subtraction, inversion, and reduction or. The testbench is designed to verify the ALU's functionality using randomized and directed test cases.

## Components
The testbench consists of the following main components:

### 1. **Stimulus**
The `Stimulus` class generates randomized inputs for the ALU, including two 4-bit signed numbers `a` and `b`, a reset signal, and an operation code (`opcode`). The operations supported are:

| Opcode | Operation   |
|--------|-------------|
| `00`   | Addition    |
| `01`   | Subtraction |
| `10`   | Inversion   |
| `11`   | Reduction or|

### 2. **DUT (Device Under Test)**
The `DUT` class implements the ALU logic. The main operation is performed in the `adder` function, which executes the following:
- Addition (`a + b`)
- Subtraction (`a - b`)
- Bitwise inversion (`~a`)
- Reduction or (`|b`)

### 3. **Monitor**
The `Monitor` class verifies the correctness of the operations. It checks the output (`sum`) of the ALU against the expected result for each operation and logs pass or fail messages.

### 4. **Testbench Module**
The `tb_adder` module integrates the Stimulus, DUT, and Monitor classes. It:
- Initializes the components.
- Runs randomized test cases using the `Stimulus` class.
- Executes directed tests for specific corner cases.

## File Structure

- **`tb_adder` Module**: Integrates all components and runs the simulation.
- **`Stimulus` Class**: Generates inputs and opcodes for the ALU.
- **`Monitor` Class**: Verifies the ALU output.
- **`DUT` Class**: Implements the ALU logic.

## Simulation Flow
1. **Randomized Testing**
   - The `Stimulus` class generates random inputs and opcodes.
   - The DUT processes the inputs based on the opcode.
   - The Monitor verifies the output and logs results.

2. **Directed Testing**
   - Specific corner cases (e.g., addition of 6 + 0) are manually executed to ensure correctness.

3. **Waveform Dump**
   - A VCD file (`dump.vcd`) is generated for debugging purposes.

## Code Highlights

### Example Randomized Test
```systemverilog
repeat (20) begin
  stim.generate_inputs();
  dut.adder(stim.a, stim.b, stim.reset, stim.opcode);
  monitor.check(stim.a, stim.b, dut.sum, stim.reset, stim.opcode);
end
```

### Directed Test
```systemverilog
$display("Running Directed Tests...");
dut.adder(6, 'b0000, 0, Stimulus::INV);
monitor.check(6, 'b0000, dut.sum, 0, Stimulus::INV);
$display("Ending Directed Tests...");
```

## How to Run
1. Compile the testbench using a SystemVerilog simulator (e.g., ModelSim, VCS).
   ```bash
   vlog tb_adder.sv
   ```
2. Run the simulation.
   ```bash
   vsim tb_adder
   ```
3. View the waveform using a VCD viewer if needed.
   ```bash
   gtkwave dump.vcd
   ```

## Expected Outputs
- **Randomized Tests**: Log messages indicating whether each randomized test passed or failed.
- **Directed Tests**: Specific logs for manual test cases to verify functionality.
- **Waveform**: A visual representation of the ALU operations over time.

## Future Enhancements
- Extend the ALU to support more operations (e.g., multiplication, division).
- Add constraints in the `Stimulus` class for generating specific edge cases.
- Automate result verification using assertions.

## License
This project is licensed under the MIT License. Feel free to use, modify, and distribute this code.

---
Happy Testing! 🚀
