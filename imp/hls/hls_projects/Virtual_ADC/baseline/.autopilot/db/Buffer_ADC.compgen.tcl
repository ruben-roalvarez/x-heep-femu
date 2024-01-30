# This script segment is generated automatically by AutoPilot

if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler Buffer_ADC_gmem_m_axi BINDTYPE {interface} TYPE {adapter} IMPL {m_axi}
}


# clear list
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_begin
    cg_default_interface_gen_bundle_begin
    AESL_LIB_XILADAPTER::native_axis_begin
}

set axilite_register_dict [dict create]
set port_control {
DDR_size { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 16
	offset_end 23
}
DDR_cons_addr { 
	dir O
	width 32
	depth 1
	mode ap_vld
	offset 24
	offset_end 31
}
DDR_prod_addr { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 40
	offset_end 47
}
DDR_Ready { 
	dir I
	width 32
	depth 1
	mode ap_none
	offset 48
	offset_end 55
}
DDR_Master { 
	dir I
	width 64
	depth 1
	mode ap_none
	offset 56
	offset_end 67
}
ADC_buffer_error_i { 
	dir I
	width 1
	depth 1
	mode ap_none
	offset 68
	offset_end 75
}
ADC_buffer_error_o { 
	dir O
	width 1
	depth 1
	mode ap_vld
	offset 76
	offset_end 83
}
}
dict set axilite_register_dict control $port_control


# Native S_AXILite:
if {${::AESL::PGuard_simmodel_gen}} {
	if {[info proc ::AESL_LIB_XILADAPTER::s_axilite_gen] == "::AESL_LIB_XILADAPTER::s_axilite_gen"} {
		eval "::AESL_LIB_XILADAPTER::s_axilite_gen { \
			id 1 \
			corename Buffer_ADC_control_axilite \
			name Buffer_ADC_control_s_axi \
			ports {$port_control} \
			op interface \
			interrupt_clear_mode TOW \
			interrupt_trigger_type default \
			is_flushable 0 \
			is_datawidth64 0 \
			is_addrwidth64 1 \
		} "
	} else {
		puts "@W \[IMPL-110\] Cannot find AXI Lite interface model in the library. Ignored generation of AXI Lite  interface for 'control'"
	}
}

if {${::AESL::PGuard_rtl_comp_handler}} {
	::AP::rtl_comp_handler Buffer_ADC_control_s_axi BINDTYPE interface TYPE interface_s_axilite
}

# XIL_BRAM:
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc ::AESL_LIB_XILADAPTER::xil_bram_gen] == "::AESL_LIB_XILADAPTER::xil_bram_gen"} {
eval "::AESL_LIB_XILADAPTER::xil_bram_gen { \
    id 3 \
    name ADC_mem \
    reset_level 0 \
    sync_rst true \
    dir O \
    corename ADC_mem \
    op interface \
    ports { ADC_mem_address1 { O 11 vector } ADC_mem_ce1 { O 1 bit } ADC_mem_we1 { O 1 bit } ADC_mem_d1 { O 32 vector } } \
} "
} else {
puts "@W \[IMPL-110\] Cannot find bus interface model in the library. Ignored generation of bus interface for 'ADC_mem'"
}
}


# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 4 \
    name ADC_Ready \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_ADC_Ready \
    op interface \
    ports { ADC_Ready { I 1 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 5 \
    name ADC_buffer_cons_addr \
    type other \
    dir I \
    reset_level 0 \
    sync_rst true \
    corename dc_ADC_buffer_cons_addr \
    op interface \
    ports { ADC_buffer_cons_addr { I 10 vector } } \
} "
}

# Direct connection:
if {${::AESL::PGuard_autoexp_gen}} {
eval "cg_default_interface_gen_dc { \
    id 6 \
    name ADC_buffer_prod_addr \
    type other \
    dir O \
    reset_level 0 \
    sync_rst true \
    corename dc_ADC_buffer_prod_addr \
    op interface \
    ports { ADC_buffer_prod_addr { O 10 vector } } \
} "
}


# Adapter definition:
set PortName ap_clk
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_clock] == "cg_default_interface_gen_clock"} {
eval "cg_default_interface_gen_clock { \
    id -1 \
    name ${PortName} \
    reset_level 0 \
    sync_rst true \
    corename apif_ap_clk \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-113\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}


# Adapter definition:
set PortName ap_rst_n
set DataWd 1 
if {${::AESL::PGuard_autoexp_gen}} {
if {[info proc cg_default_interface_gen_reset] == "cg_default_interface_gen_reset"} {
eval "cg_default_interface_gen_reset { \
    id -2 \
    name ${PortName} \
    reset_level 0 \
    sync_rst true \
    corename apif_ap_rst_n \
    data_wd ${DataWd} \
    op interface \
}"
} else {
puts "@W \[IMPL-114\] Cannot find bus interface model in the library. Ignored generation of bus interface for '${PortName}'"
}
}



# merge
if {${::AESL::PGuard_autoexp_gen}} {
    cg_default_interface_gen_dc_end
    cg_default_interface_gen_bundle_end
    AESL_LIB_XILADAPTER::native_axis_end
}


