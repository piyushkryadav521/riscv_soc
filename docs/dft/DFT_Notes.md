1. DFT Overview
Definition: Integration of hardware design features to simplify manufacturing test application and fault detection.

Core Challenges: Controllability (setting internal nodes to 0 or 1 from inputs) and Observability (monitoring internal node values at outputs).

Objective: Efficiently detect manufacturing defects (stuck-at, bridging, open faults) to minimize Defective Parts Per Million (DPPM).

2. Scan Chain
Mechanism: Converts sequential elements into serial shift registers during test mode by replacing standard flip-flops with scan multiplexed flip-flops.

Modes: Normal mode (functional logic path) and Test mode (serial shift register path).

Impact: Simplifies complex sequential test generation into combinational test generation.

3. ATPG (Automatic Test Pattern Generation)
Definition: EDA software process generating input test vectors for digital circuits using netlists and fault models (e.g., Stuck-At, Transition faults).

Metric: Test Coverage (% of detectable faults tested), ensuring high product reliability and low defect escape rates.

4. MBIST (Memory Built-In Self-Test)
Definition: On-chip hardware controllers dedicated to testing embedded memories (SRAM, ROM) locally.

Mechanism: Automatically runs standard memory test algorithms (e.g., March algorithms) at speed.

Benefits: Reduces external tester (ATE) time, enables at-speed testing, and targets complex memory failure modes.

5. LBIST (Logic Built-In Self-Test)
Definition: Self-testing technique generating test patterns and compressing responses directly on-chip.

Core Components: PRPG (Pseudo-Random Pattern Generator via LFSRs) for input vectors and MISR (Multiple-Input Signature Register) for output response compression.

Benefits: Enables native at-speed testing and reduces test data volume.

6. JTAG (IEEE 1149.1 Boundary Scan)
Definition: Industry standard for board-level interconnect testing and device debugging.

Test Access Port (TAP) Pins: TCK (Clock), TMS (Mode Select), TDI (Data In), TDO (Data Out), and optional TRST (Reset).

Applications: Board-level testing without physical probes, flash programming, and internal DFT access.

7. Advantages of DFT
Lower Test Cost: Minimizes expensive automated test equipment (ATE) time via compression and BIST.

Higher Reliability: Screens out latent manufacturing flaws to reduce field failures.

At-Speed Testing: Detects timing and speed-dependent faults at operational frequencies.

Faster Time-to-Market & Yield Learning: Automates test creation and supplies diagnostic data to optimize silicon fabrication processes.