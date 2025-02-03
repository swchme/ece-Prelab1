# Lab 1: Thirty-One Day Month

VHDL template for ECE 281 [Lab 1](https://usafa-ece.github.io/ece281-book/lab/lab1.html)

Targeted toward Digilent Basys3 in Vivado 2024.

Tested on Windows 10.

## Usage

Clone and cd into the directory.

You should see a `.xpr` file. Open it with Vivado!

## GitHub Actions Testbench

The workflow uses the [setup-ghdl-ci](https://github.com/ghdl/setup-ghdl-ci) GitHub action
to run a *nightly* build of [GHDL](https://ghdl.github.io/ghdl/).

First, the workflow uses GHDL to **analyze** all `.vhd` files in `src/`.

Then it **elaborates** `thirtyOneDayMonth_tb` entity.

Finally, the workflow **runs** the simulation. If successful then it will quietly exit with a `0` code.
If any of the `assert` statements fail then GHDL will cease the simulation and exit with non-zero code; this will also cause the workflow to fail.
Assert statements of other severity levels will be reported, but not fail the workflow.
