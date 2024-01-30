; ModuleID = '/home/rrodrigu/x-heep-femu/imp/hls/hls_projects/Virtual_ADC/baseline/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

%"struct.ap_uint<64>" = type { %"struct.ap_int_base<64, false>" }
%"struct.ap_int_base<64, false>" = type { %"struct.ssdm_int<64, false>" }
%"struct.ssdm_int<64, false>" = type { i64 }
%"struct.ap_uint<32>" = type { %"struct.ap_int_base<32, false>" }
%"struct.ap_int_base<32, false>" = type { %"struct.ssdm_int<32, false>" }
%"struct.ssdm_int<32, false>" = type { i32 }
%"struct.ap_uint<10>" = type { %"struct.ap_int_base<10, false>" }
%"struct.ap_int_base<10, false>" = type { %"struct.ssdm_int<10, false>" }
%"struct.ssdm_int<10, false>" = type { i10 }
%"struct.ap_uint<1>" = type { %"struct.ap_int_base<1, false>" }
%"struct.ap_int_base<1, false>" = type { %"struct.ssdm_int<1, false>" }
%"struct.ssdm_int<1, false>" = type { i1 }

; Function Attrs: noinline
define void @apatb_Buffer_ADC_ir(%"struct.ap_uint<32>"* nocapture readonly %DDR_size, %"struct.ap_uint<32>"* noalias nocapture nonnull dereferenceable(4) %DDR_cons_addr, %"struct.ap_uint<32>"* nocapture readonly %DDR_prod_addr, %"struct.ap_uint<32>"* nocapture readonly %DDR_Ready, %"struct.ap_uint<64>"* noalias nocapture nonnull readonly "maxi" %DDR_Master, %"struct.ap_uint<32>"* noalias nocapture nonnull %ADC_mem, %"struct.ap_uint<1>"* nocapture readonly %ADC_Ready, %"struct.ap_uint<10>"* nocapture readonly %ADC_buffer_cons_addr, %"struct.ap_uint<10>"* noalias nocapture nonnull dereferenceable(2) %ADC_buffer_prod_addr, %"struct.ap_uint<1>"* noalias nocapture nonnull dereferenceable(1) %ADC_buffer_error) local_unnamed_addr #0 {
entry:
  %DDR_cons_addr_copy = alloca i32, align 512
  %DDR_Master_copy = alloca i64, align 512
  %malloccall = call i8* @malloc(i64 8192)
  %ADC_mem_copy = bitcast i8* %malloccall to [2048 x i32]*
  %ADC_buffer_prod_addr_copy = alloca i10, align 512
  %ADC_buffer_error_copy = alloca i1, align 512
  %0 = bitcast %"struct.ap_uint<32>"* %ADC_mem to [2048 x %"struct.ap_uint<32>"]*
  call fastcc void @copy_in(%"struct.ap_uint<32>"* nonnull %DDR_cons_addr, i32* nonnull align 512 %DDR_cons_addr_copy, %"struct.ap_uint<64>"* nonnull %DDR_Master, i64* nonnull align 512 %DDR_Master_copy, [2048 x %"struct.ap_uint<32>"]* nonnull %0, [2048 x i32]* %ADC_mem_copy, %"struct.ap_uint<10>"* nonnull %ADC_buffer_prod_addr, i10* nonnull align 512 %ADC_buffer_prod_addr_copy, %"struct.ap_uint<1>"* nonnull %ADC_buffer_error, i1* nonnull align 512 %ADC_buffer_error_copy)
  call void @apatb_Buffer_ADC_hw(%"struct.ap_uint<32>"* %DDR_size, i32* %DDR_cons_addr_copy, %"struct.ap_uint<32>"* %DDR_prod_addr, %"struct.ap_uint<32>"* %DDR_Ready, i64* %DDR_Master_copy, [2048 x i32]* %ADC_mem_copy, %"struct.ap_uint<1>"* %ADC_Ready, %"struct.ap_uint<10>"* %ADC_buffer_cons_addr, i10* %ADC_buffer_prod_addr_copy, i1* %ADC_buffer_error_copy)
  call void @copy_back(%"struct.ap_uint<32>"* %DDR_cons_addr, i32* %DDR_cons_addr_copy, %"struct.ap_uint<64>"* %DDR_Master, i64* %DDR_Master_copy, [2048 x %"struct.ap_uint<32>"]* %0, [2048 x i32]* %ADC_mem_copy, %"struct.ap_uint<10>"* %ADC_buffer_prod_addr, i10* %ADC_buffer_prod_addr_copy, %"struct.ap_uint<1>"* %ADC_buffer_error, i1* %ADC_buffer_error_copy)
  call void @free(i8* %malloccall)
  ret void
}

declare noalias i8* @malloc(i64) local_unnamed_addr

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_in(%"struct.ap_uint<32>"* noalias readonly "unpacked"="0", i32* noalias nocapture align 512 "unpacked"="1.0", %"struct.ap_uint<64>"* noalias readonly "unpacked"="2", i64* noalias nocapture align 512 "unpacked"="3.0", [2048 x %"struct.ap_uint<32>"]* noalias readonly "unpacked"="4", [2048 x i32]* noalias nocapture "unpacked"="5.0", %"struct.ap_uint<10>"* noalias readonly "unpacked"="6", i10* noalias nocapture align 512 "unpacked"="7.0", %"struct.ap_uint<1>"* noalias readonly "unpacked"="8", i1* noalias nocapture align 512 "unpacked"="9.0") unnamed_addr #1 {
entry:
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<32>"(i32* align 512 %1, %"struct.ap_uint<32>"* %0)
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<64>.33"(i64* align 512 %3, %"struct.ap_uint<64>"* %2)
  call fastcc void @"onebyonecpy_hls.p0a2048struct.ap_uint<32>"([2048 x i32]* %5, [2048 x %"struct.ap_uint<32>"]* %4)
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<10>.14"(i10* align 512 %7, %"struct.ap_uint<10>"* %6)
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<1>"(i1* align 512 %9, %"struct.ap_uint<1>"* %8)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0struct.ap_uint<32>"(i32* noalias nocapture align 512 "unpacked"="0.0" %dst, %"struct.ap_uint<32>"* noalias readonly "unpacked"="1" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq %"struct.ap_uint<32>"* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %src.0.0.03 = getelementptr %"struct.ap_uint<32>", %"struct.ap_uint<32>"* %src, i64 0, i32 0, i32 0, i32 0
  %1 = load i32, i32* %src.0.0.03, align 4
  store i32 %1, i32* %dst, align 512
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0struct.ap_uint<64>"(%"struct.ap_uint<64>"* noalias "unpacked"="0" %dst, i64* noalias nocapture readonly align 512 "unpacked"="1.0" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq %"struct.ap_uint<64>"* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %dst.0.0.04 = getelementptr %"struct.ap_uint<64>", %"struct.ap_uint<64>"* %dst, i64 0, i32 0, i32 0, i32 0
  %1 = load i64, i64* %src, align 512
  store i64 %1, i64* %dst.0.0.04, align 8
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a2048struct.ap_uint<32>"([2048 x i32]* noalias nocapture "unpacked"="0.0" %dst, [2048 x %"struct.ap_uint<32>"]* noalias readonly "unpacked"="1" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [2048 x %"struct.ap_uint<32>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a2048struct.ap_uint<32>"([2048 x i32]* %dst, [2048 x %"struct.ap_uint<32>"]* nonnull %src, i64 2048)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a2048struct.ap_uint<32>"([2048 x i32]* nocapture "unpacked"="0.0" %dst, [2048 x %"struct.ap_uint<32>"]* readonly "unpacked"="1" %src, i64 "unpacked"="2" %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [2048 x %"struct.ap_uint<32>"]* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [2048 x %"struct.ap_uint<32>"], [2048 x %"struct.ap_uint<32>"]* %src, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %dst.addr.0.0.06 = getelementptr [2048 x i32], [2048 x i32]* %dst, i64 0, i64 %for.loop.idx2
  %1 = load i32, i32* %src.addr.0.0.05, align 4
  store i32 %1, i32* %dst.addr.0.0.06, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0struct.ap_uint<10>"(%"struct.ap_uint<10>"* noalias "unpacked"="0" %dst, i10* noalias nocapture readonly align 512 "unpacked"="1.0" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq %"struct.ap_uint<10>"* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %dst.0.0.04 = getelementptr %"struct.ap_uint<10>", %"struct.ap_uint<10>"* %dst, i64 0, i32 0, i32 0, i32 0
  %1 = bitcast i10* %src to i16*
  %2 = load i16, i16* %1
  %3 = trunc i16 %2 to i10
  store i10 %3, i10* %dst.0.0.04, align 2
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0struct.ap_uint<1>"(i1* noalias nocapture align 512 "unpacked"="0.0" %dst, %"struct.ap_uint<1>"* noalias readonly "unpacked"="1" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq %"struct.ap_uint<1>"* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %src.0.0.03 = getelementptr %"struct.ap_uint<1>", %"struct.ap_uint<1>"* %src, i64 0, i32 0, i32 0, i32 0
  %1 = bitcast i1* %src.0.0.03 to i8*
  %2 = load i8, i8* %1
  %3 = trunc i8 %2 to i1
  store i1 %3, i1* %dst, align 512
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_out(%"struct.ap_uint<32>"* noalias "unpacked"="0", i32* noalias nocapture readonly align 512 "unpacked"="1.0", %"struct.ap_uint<64>"* noalias "unpacked"="2", i64* noalias nocapture readonly align 512 "unpacked"="3.0", [2048 x %"struct.ap_uint<32>"]* noalias "unpacked"="4", [2048 x i32]* noalias nocapture readonly "unpacked"="5.0", %"struct.ap_uint<10>"* noalias "unpacked"="6", i10* noalias nocapture readonly align 512 "unpacked"="7.0", %"struct.ap_uint<1>"* noalias "unpacked"="8", i1* noalias nocapture readonly align 512 "unpacked"="9.0") unnamed_addr #4 {
entry:
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<32>.39"(%"struct.ap_uint<32>"* %0, i32* align 512 %1)
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<64>"(%"struct.ap_uint<64>"* %2, i64* align 512 %3)
  call fastcc void @"onebyonecpy_hls.p0a2048struct.ap_uint<32>.21"([2048 x %"struct.ap_uint<32>"]* %4, [2048 x i32]* %5)
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<10>"(%"struct.ap_uint<10>"* %6, i10* align 512 %7)
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<1>.7"(%"struct.ap_uint<1>"* %8, i1* align 512 %9)
  ret void
}

declare void @free(i8*) local_unnamed_addr

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0struct.ap_uint<1>.7"(%"struct.ap_uint<1>"* noalias "unpacked"="0" %dst, i1* noalias nocapture readonly align 512 "unpacked"="1.0" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq %"struct.ap_uint<1>"* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %dst.0.0.04 = getelementptr %"struct.ap_uint<1>", %"struct.ap_uint<1>"* %dst, i64 0, i32 0, i32 0, i32 0
  %1 = bitcast i1* %src to i8*
  %2 = load i8, i8* %1
  %3 = trunc i8 %2 to i1
  store i1 %3, i1* %dst.0.0.04, align 1
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0struct.ap_uint<10>.14"(i10* noalias nocapture align 512 "unpacked"="0.0" %dst, %"struct.ap_uint<10>"* noalias readonly "unpacked"="1" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq %"struct.ap_uint<10>"* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %src.0.0.03 = getelementptr %"struct.ap_uint<10>", %"struct.ap_uint<10>"* %src, i64 0, i32 0, i32 0, i32 0
  %1 = bitcast i10* %src.0.0.03 to i16*
  %2 = load i16, i16* %1
  %3 = trunc i16 %2 to i10
  store i10 %3, i10* %dst, align 512
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0a2048struct.ap_uint<32>.21"([2048 x %"struct.ap_uint<32>"]* noalias "unpacked"="0" %dst, [2048 x i32]* noalias nocapture readonly "unpacked"="1.0" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [2048 x %"struct.ap_uint<32>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @"arraycpy_hls.p0a2048struct.ap_uint<32>.24"([2048 x %"struct.ap_uint<32>"]* nonnull %dst, [2048 x i32]* %src, i64 2048)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @"arraycpy_hls.p0a2048struct.ap_uint<32>.24"([2048 x %"struct.ap_uint<32>"]* "unpacked"="0" %dst, [2048 x i32]* nocapture readonly "unpacked"="1.0" %src, i64 "unpacked"="2" %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [2048 x %"struct.ap_uint<32>"]* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %src.addr.0.0.05 = getelementptr [2048 x i32], [2048 x i32]* %src, i64 0, i64 %for.loop.idx2
  %dst.addr.0.0.06 = getelementptr [2048 x %"struct.ap_uint<32>"], [2048 x %"struct.ap_uint<32>"]* %dst, i64 0, i64 %for.loop.idx2, i32 0, i32 0, i32 0
  %1 = load i32, i32* %src.addr.0.0.05, align 4
  store i32 %1, i32* %dst.addr.0.0.06, align 4
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0struct.ap_uint<64>.33"(i64* noalias nocapture align 512 "unpacked"="0.0" %dst, %"struct.ap_uint<64>"* noalias readonly "unpacked"="1" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq %"struct.ap_uint<64>"* %src, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %src.0.0.03 = getelementptr %"struct.ap_uint<64>", %"struct.ap_uint<64>"* %src, i64 0, i32 0, i32 0, i32 0
  %1 = load i64, i64* %src.0.0.03, align 8
  store i64 %1, i64* %dst, align 512
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @"onebyonecpy_hls.p0struct.ap_uint<32>.39"(%"struct.ap_uint<32>"* noalias "unpacked"="0" %dst, i32* noalias nocapture readonly align 512 "unpacked"="1.0" %src) unnamed_addr #2 {
entry:
  %0 = icmp eq %"struct.ap_uint<32>"* %dst, null
  br i1 %0, label %ret, label %copy

copy:                                             ; preds = %entry
  %dst.0.0.04 = getelementptr %"struct.ap_uint<32>", %"struct.ap_uint<32>"* %dst, i64 0, i32 0, i32 0, i32 0
  %1 = load i32, i32* %src, align 512
  store i32 %1, i32* %dst.0.0.04, align 4
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

declare void @apatb_Buffer_ADC_hw(%"struct.ap_uint<32>"*, i32*, %"struct.ap_uint<32>"*, %"struct.ap_uint<32>"*, i64*, [2048 x i32]*, %"struct.ap_uint<1>"*, %"struct.ap_uint<10>"*, i10*, i1*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_back(%"struct.ap_uint<32>"* noalias "unpacked"="0", i32* noalias nocapture readonly align 512 "unpacked"="1.0", %"struct.ap_uint<64>"* noalias "unpacked"="2", i64* noalias nocapture readonly align 512 "unpacked"="3.0", [2048 x %"struct.ap_uint<32>"]* noalias "unpacked"="4", [2048 x i32]* noalias nocapture readonly "unpacked"="5.0", %"struct.ap_uint<10>"* noalias "unpacked"="6", i10* noalias nocapture readonly align 512 "unpacked"="7.0", %"struct.ap_uint<1>"* noalias "unpacked"="8", i1* noalias nocapture readonly align 512 "unpacked"="9.0") unnamed_addr #4 {
entry:
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<32>.39"(%"struct.ap_uint<32>"* %0, i32* align 512 %1)
  call fastcc void @"onebyonecpy_hls.p0a2048struct.ap_uint<32>.21"([2048 x %"struct.ap_uint<32>"]* %4, [2048 x i32]* %5)
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<10>"(%"struct.ap_uint<10>"* %6, i10* align 512 %7)
  call fastcc void @"onebyonecpy_hls.p0struct.ap_uint<1>.7"(%"struct.ap_uint<1>"* %8, i1* align 512 %9)
  ret void
}

define void @Buffer_ADC_hw_stub_wrapper(%"struct.ap_uint<32>"*, i32*, %"struct.ap_uint<32>"*, %"struct.ap_uint<32>"*, i64*, [2048 x i32]*, %"struct.ap_uint<1>"*, %"struct.ap_uint<10>"*, i10*, i1*) #5 {
entry:
  %10 = alloca %"struct.ap_uint<32>"
  %11 = alloca %"struct.ap_uint<64>"
  %malloccall = tail call i8* @malloc(i64 8192)
  %12 = bitcast i8* %malloccall to [2048 x %"struct.ap_uint<32>"]*
  %13 = alloca %"struct.ap_uint<10>"
  %14 = alloca %"struct.ap_uint<1>"
  call void @copy_out(%"struct.ap_uint<32>"* %10, i32* %1, %"struct.ap_uint<64>"* %11, i64* %4, [2048 x %"struct.ap_uint<32>"]* %12, [2048 x i32]* %5, %"struct.ap_uint<10>"* %13, i10* %8, %"struct.ap_uint<1>"* %14, i1* %9)
  %15 = bitcast [2048 x %"struct.ap_uint<32>"]* %12 to %"struct.ap_uint<32>"*
  call void @Buffer_ADC_hw_stub(%"struct.ap_uint<32>"* %0, %"struct.ap_uint<32>"* %10, %"struct.ap_uint<32>"* %2, %"struct.ap_uint<32>"* %3, %"struct.ap_uint<64>"* %11, %"struct.ap_uint<32>"* %15, %"struct.ap_uint<1>"* %6, %"struct.ap_uint<10>"* %7, %"struct.ap_uint<10>"* %13, %"struct.ap_uint<1>"* %14)
  call void @copy_in(%"struct.ap_uint<32>"* %10, i32* %1, %"struct.ap_uint<64>"* %11, i64* %4, [2048 x %"struct.ap_uint<32>"]* %12, [2048 x i32]* %5, %"struct.ap_uint<10>"* %13, i10* %8, %"struct.ap_uint<1>"* %14, i1* %9)
  ret void
}

declare void @Buffer_ADC_hw_stub(%"struct.ap_uint<32>"*, %"struct.ap_uint<32>"*, %"struct.ap_uint<32>"*, %"struct.ap_uint<32>"*, %"struct.ap_uint<64>"*, %"struct.ap_uint<32>"*, %"struct.ap_uint<1>"*, %"struct.ap_uint<10>"*, %"struct.ap_uint<10>"*, %"struct.ap_uint<1>"*)

attributes #0 = { noinline "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="arraycpy_hls" }
attributes #4 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
attributes #5 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
