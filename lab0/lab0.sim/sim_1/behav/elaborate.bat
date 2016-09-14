@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.1\\bin
call %xv_path%/xelab  -wto 2a5e5d6c56454f2b8c8f56ecd8bd7628 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot counter_testbench_behav xil_defaultlib.counter_testbench -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
