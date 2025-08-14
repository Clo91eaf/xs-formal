# Xiangshan Formal Verification Flow

nix flow build from [chisel-nix](https://github.com/chipsalliance/chisel-nix)

## environment

```shell
export CDS_LIC_FILE=xxx@hostname
export JASPER_HOME=/path/to/cadence/JASPER2103/
```
## flow

move your rtl files to ./rtl

entering a environment which have jg command.
```shell
nix run .#cds-fhs-env --impure
```

basic flow in `jg shell` to prove the properties in `rtl/LoadQueueRAR.sv
or you can also use gui to achieve this commands
```shell
clear -all

# Analyze source files and property files
analyze -sv12 -f /path/to/rtl/filelist.f

set_task_compile_time_limit 100000
set_property_compile_time_limit 100000

# Elaborate design and properties
elaborate

# Set up Clocks and Resets
clock clock
reset reset

# Get design information to check general complexity
get_design_info

# Prove properties
prove -all
```

Or

run the batch in ./nix/scripts/FPV.tcl and get report directly.
```shell
nix build .#jg-fpv --impure
```

report is under ./result

## Result

| id   | Name                               |    Result    |  Engine  |  Bound  |  Time    |
|--|--|--|--|--|--
| [1]  | LoadQueueRAR.asm0                  |       temporary  |     ?    |            |  0.000 s      |
| [2]  | LoadQueueRAR.asm1                  |       temporary  |     ?    |            |  0.000 s      |
| [3]  | LoadQueueRAR.ast0                  |       proven     |     PRE  |  Infinite  |  0.000 s      |
| [4]  | LoadQueueRAR.ast0:precondition1    |       covered    |     N    |         1  |  0.019 s      |

