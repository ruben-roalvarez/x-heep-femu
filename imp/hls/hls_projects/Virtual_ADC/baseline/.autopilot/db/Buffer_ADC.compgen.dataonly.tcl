# This script segment is generated automatically by AutoPilot

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


