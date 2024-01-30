############################################################
## This file is generated automatically by Vitis HLS.
## Please DO NOT edit it.
## Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
## Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
############################################################
open_project Virtual_ADC
set_top Buffer_ADC
add_files ../virtual_adc/buffer_adc.cpp
add_files ../virtual_adc/buffer_adc.h
add_files -tb ../virtual_adc/main.cpp -cflags "-Wno-unknown-pragmas"
open_solution "baseline" -flow_target vivado
set_part {xc7z020-clg400-1}
create_clock -period 10 -name default
config_export -display_name Virtual_ADC -format ip_catalog -output /home/rrodrigu/x-heep-femu/imp/hls/ips -rtl verilog -vendor esl -version 1.0
source "./Virtual_ADC/baseline/directives.tcl"
csim_design -clean
csynth_design
cosim_design
export_design -rtl verilog -format ip_catalog -output /home/rrodrigu/x-heep-femu/imp/hls/ips
