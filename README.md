# ihp-sg13g2 LibreLane Template

A LibreLane template to implement a full chip design using the ihp-sg13g2 PDK.

<p align="center">
  <a href="img/chip_top.png">
    <img src="img/chip_top.png" alt="KLayout chip render" width=45%>
  </a>
</p>

## Prerequisites

First, install LibreLane by following the Nix-based installation instructions: https://librelane.readthedocs.io/en/latest/installation/nix_installation/index.html

This repository contains a Nix flake that provides a shell with the [`dev`](https://github.com/librelane/librelane/tree/dev) branch of LibreLane.
To install the PDK, enable a Nix shell using `nix-shell` from the root of this repository and run `make clone-pdk`.

## Implement the Design

> [!NOTE]
> If you aren't in the Nix shell, run `nix-shell` from the root of this repository.

With this shell enabled, run the implementation:

```
make librelane
```

## View the Design

After completion, you can view the design using the OpenROAD GUI:

```
make librelane-openroad
```

Or using KLayout:

```
make librelane-klayout
```

## Copying the Design to the Final Folder

To copy your latest run to the `final/` folder in the root directory of the repository, run the following command:

```
make copy-final
```

This will only work if the last run was completed without errors.

## Verification and Simulation

We use [cocotb](https://www.cocotb.org/), a Python-based testbench environment, for the verification of the chip.
The underlying simulator is Icarus Verilog (https://github.com/steveicarus/iverilog).

The testbench is located in `cocotb/chip_top_tb.py`. To run the RTL simulation, run the following command:

```
make sim
```

To run the GL (gate-level) simulation, run the following command:

```
make sim-gl
```

> [!NOTE]
> You need to have the latest implementation of your design in the `final/` folder. After implementing the design, execute 'make copy-final' to copy all necessary files.

In both cases, a waveform file will be generated under `cocotb/sim_build/chip_top.fst`.
You can view it using a waveform viewer, for example, [GTKWave](https://gtkwave.github.io/gtkwave/).

```
make sim-view
```

You can now update the testbench according to your design.

## Implementing Your Own Design

The source files for this template can be found in the `src/` directory. `chip_top.sv` defines the top-level ports and instantiates `chip_core`.
To change the number of power/ground pads of the core domain, change the `NUM_VDD_PADS`/`NUM_VSS_PADS` parameters.
To change the number of power/ground pads of the I/O domain, change the `NUM_IOVDD_PADS`/`NUM_IOVSS_PADS` parameters.
In order to change the number and types of the signal pads, use `NUM_INPUT_PADS`, `NUM_OUTPUT_PADS`, `NUM_BIDIR_PADS` and `NUM_ANALOG_PADS`.

The actual pad positions are defined in the LibreLane configuration file under `librelane/config.yaml`. The variables `PAD_SOUTH`/`PAD_EAST`/`PAD_NORTH`/`PAD_WEST` determine the respective pad placement. The LibreLane configuration also allows you to customize the flow (enable or disable steps), specify the source files, set various variables for the steps, and instantiate macros. For more information about the configuration, please refer to the LibreLane documentation: https://librelane.readthedocs.io/en/latest/

To implement your own design, simply edit `chip_core.sv`. The `chip_core` module receives the clock and reset, as well as the signals from the pads defined in `chip_top`. As an example, a counter is implemented.

> [!NOTE]
> For more comprehensive SystemVerilog support, enable the `USE_SLANG` variable in the LibreLane configuration.
