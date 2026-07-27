# RTL Coding Guidelines

## Sequential Logic
- Use non-blocking assignments (`<=`)
- Trigger on `posedge clk`
- Reset all required registers

## Combinational Logic
- Use blocking assignments (`=`)
- Assign all outputs in every path
- Provide default assignments
- Avoid inferred latches

## FSM
- Use `case` statements
- Include a `default` case
- Use meaningful state names

## Width Matching
- Match signal widths
- Avoid implicit truncation/extension

## General
- One driver per register
- Avoid combinational loops
- Keep module interfaces clean