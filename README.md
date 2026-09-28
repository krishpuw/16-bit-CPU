# 16-bit Single-Cycle Processor (Verilog / FPGA)

A 16-bit, single-cycle, non-pipelined processor implemented in Verilog, verified in simulation, and deployed to a Xilinx Basys 3 FPGA board.

Built for CSE 490, Spring 2026, University at Buffalo.

**Team:** Marco Bianco, Krish Puwar ([@krishpuw](https://github.com/krishpuw)), Andrew Collado

## Overview

Every instruction completes in a single clock cycle — fetch through write-back, with no pipelining. The processor has:

- 16-bit word size, byte-addressable memory
- 16 general-purpose registers (`$s0`–`$s15`)
- 10 instructions across three formats: **R-type**, **I-type**, **J-type**
- Instructions supported: `add`, `sub`, `sll`, `and`, `addi`, `addif`, `lw`, `sw`, `beq`, `bne`, `jmp`

Built and simulated in **Xilinx Vivado 2025.2** (behavioral simulation via `xsim`), then synthesized and run on a **Basys 3 FPGA**.

## Architecture

The design is 10 Verilog modules wired together at the top level in structural Verilog; each individual module is written behaviorally.

| Module | File | Role |
|---|---|---|
| Program Counter | `program_counter.v` | Tracks the next instruction address (PC+2, branch target, or jump target) |
| Instruction Memory | `instruction_memory.v` | 128-entry byte-addressed array; combines two bytes (big-endian) into a 16-bit instruction, loaded from `program.mem` |
| Register File | `register_file.v` | 16×16-bit registers, 2 async read ports, 1 sync write port |
| ALU | `ALU.v` | add / sub / sll / and, plus a zero flag for branching |
| ALU Control | `alu_control.v` | Maps `ALUOp` + function code to the ALU's operation code |
| Sign Extension | `sign_extension.v` | Sign-extends 4-bit immediates and the 12-bit jump offset to 16 bits |
| Multiplexer | `mux.v` | 2-to-1 16-bit mux, instantiated multiple times (ALU input select, write-back select, PC update select) |
| Data Memory | `data_memory.v` | 128-entry byte-addressed array, big-endian, sync write / async read |
| Control Unit | `control_unit.v` | Decodes opcode (+ function code for R-type) into all datapath control signals |
| Top-Level Structural | `structural.v` | Instantiates and wires together all of the above; only its own logic is the PC+2 adder |

### Datapath

PC → instruction memory → control unit (decodes opcode) → register file reads → mux selects ALU's second operand (register vs. sign-extended immediate) → ALU executes → result addresses data memory (`lw`/`sw`) or feeds the write-back mux → register file write-back. Branch instructions use the ALU's zero flag to choose between PC+2 and the branch target; jump always overrides with the jump target.

### Control signal table

| Instruction | RegWrite | MemRead | MemWrite | MemToReg | ALUSrc | Branch/Jump |
|---|---|---|---|---|---|---|
| add/sub/sll/and | 1 | 0 | 0 | 0 | 0 | None |
| addi / addif | 1 | 0 | 0 | 0 | 1 | None |
| lw | 1 | 1 | 0 | 1 | 1 | None |
| sw | 0 | 0 | 1 | X | 1 | None |
| beq | 0 | 0 | 0 | 0 | 0 | Branch if zero=1 |
| bne | 0 | 0 | 0 | 0 | 0 | Branch if zero=0 |
| jmp | 0 | 0 | 0 | X | X | Always jump |

## Repository structure (suggested)

```
src/
  program_counter.v
  instruction_memory.v
  register_file.v
  ALU.v
  alu_control.v
  sign_extension.v
  mux.v
  data_memory.v
  control_unit.v
  structural.v
sim/
  structural_tb.v      # top-level testbench
  program.mem           # hex-encoded test program, loaded via $readmemh
docs/
  CSE490_Project_1_-_Report.pdf
```

## Building and simulating

1. Open the project in **Xilinx Vivado 2025.2**, add all files under `src/` as design sources and `structural_tb.v` as a simulation source.
2. Place `program.mem` where the simulator expects it (by default, alongside the compiled simulation, e.g. `project_1.sim/sim_1/behav/xsim/`).
3. Run behavioral simulation. The testbench drives a 10 ns clock, holds reset high for the first 10 ns, then runs for ~1000 ns — enough to step through the full test program.
4. Watch the `$monitor` output for PC, instruction bits, register read values, ALU inputs/result, write-back data, and the zero flag each cycle.

**Note:** `$readmemh` works in simulation but is not supported for initializing memory directly on hardware — the instruction/data memory contents must be initialized another way when targeting the Basys 3 board.

## Test program

`program.mem` exercises every instruction type:

| PC | Assembly | Expected result |
|---|---|---|
| 0 | `addi $s1, $s0, 5` | R1 = 5 |
| 2 | `addi $s2, $s0, 6` | R2 = 6 |
| 4 | `addi $s3, $s0, 3` | R3 = 3 |
| 6 | `add $s2, $s3` | R2 = 9 |
| 8 | `sub $s2, $s3` | R2 = 65530 (−6 unsigned) |
| 10 | `and $s1, $s2` | R1 = 0 |
| 12 | `sll $s2, $s3` | R2 = 3072 |
| 14 | `sw $s2, 0($s0)` | Mem[0] = 3072 |
| 16 | `lw $s4, 0($s0)` | R4 = 3072 |
| 18 | `beq $s4, $s2, +1` | branches, skips PC=20 |
| 22 | `addi $s5, $s0, 7` | R5 = 7 |
| 24 | `bne $s5, $s3, +1` | falls through |
| 26 | `addi $s6, $s0, -7` | R6 = 65529 |
| 28 | `addi $s6, $s0, -8` | R6 = 65528 |
| 30 | `jmp +1` | PC = 34, program ends |

Simulation confirmed every value above matched, including negative immediates via sign extension and the big-endian memory round-trip through `sw`/`lw`.

## Hardware verification

Synthesized cleanly for the Basys 3 target — all 10 modules compiled with no errors. Two warning classes were reviewed and resolved/accepted before generating the bitstream:
- An unconnected `regtomem` port on `control_unit` in `structural.v`
- Unused upper address bits in the memory modules (expected, since only 64 of the available locations are used)

## Design notes / challenges

- **Sign extension:** the 4-bit immediate must be sign-extended (replicate bit 3), not zero-extended, or negative immediates like `-1` (`0b1111`) silently become `15`.
- **Branch/jump offsets:** shifted left by 1 before adding to PC, matching MIPS convention — since every instruction is 2 bytes and PC is always even, the low bit of any valid target is always 0, so it's not encoded.
- **Big-endian memory:** both instruction and data memory store the high byte at the lower address; getting this backwards corrupts every fetched instruction and loaded value.
- **Conditional write-back (`addif`):** the ALU always computes a result, but `RegWrite` is only asserted if the condition register is nonzero — handled in the control unit.
- Initial approach used `$readmemh` to load instructions, which works for simulation but isn't supported for hardware initialization on the board.

## Work distribution

| Member | Assigned components | Other contributions |
|---|---|---|
| Marco Bianco | ALU, multiplexer, data memory | Testbench, simulation |
| Krish Puwar | Sign extension, control unit, program counter | `program.mem`, debugging |
| Andrew Collado | Register file, instruction memory | Final report |

## Tools

- Xilinx Vivado 2025.2 (simulation, synthesis, bitstream generation)
- Xilinx Basys 3 FPGA board

## References

- Xilinx / AMD, *Vivado Design Suite User Guide*
- Digilent, *Basys 3 FPGA Board Reference Manual*
- ChipVerify, *Verilog display tasks*
- Circuit Fever, *Structural modeling in Verilog*
