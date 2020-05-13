; ModuleID = 'Clang.m'
source_filename = "Clang.m"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

%0 = type opaque
%1 = type opaque
%struct._objc_cache = type opaque
%struct._class_t = type { %struct._class_t*, %struct._class_t*, %struct._objc_cache*, i8* (i8*, i8*)**, %struct._class_ro_t* }
%struct._class_ro_t = type { i32, i32, i32, i8*, i8*, %struct.__method_list_t*, %struct._objc_protocol_list*, %struct._ivar_list_t*, i8*, %struct._prop_list_t* }
%struct.__method_list_t = type { i32, i32, [0 x %struct._objc_method] }
%struct._objc_method = type { i8*, i8*, i8* }
%struct._objc_protocol_list = type { i64, [0 x %struct._protocol_t*] }
%struct._protocol_t = type { i8*, i8*, %struct._objc_protocol_list*, %struct.__method_list_t*, %struct.__method_list_t*, %struct.__method_list_t*, %struct.__method_list_t*, %struct._prop_list_t*, i32, i32, i8**, i8*, %struct._prop_list_t* }
%struct._ivar_list_t = type { i32, i32, [0 x %struct._ivar_t] }
%struct._ivar_t = type { i64*, i8*, i8*, i32, i32 }
%struct._prop_list_t = type { i32, i32, [0 x %struct._prop_t] }
%struct._prop_t = type { i8*, i8* }

@_objc_empty_cache = external global %struct._objc_cache
@"OBJC_METACLASS_$_NSObject" = external global %struct._class_t
@OBJC_CLASS_NAME_ = private unnamed_addr constant [6 x i8] c"Clang\00", section "__TEXT,__objc_classname,cstring_literals", align 1
@"\01l_OBJC_METACLASS_RO_$_Clang" = private global %struct._class_ro_t { i32 1, i32 40, i32 40, i8* null, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @OBJC_CLASS_NAME_, i32 0, i32 0), %struct.__method_list_t* null, %struct._objc_protocol_list* null, %struct._ivar_list_t* null, i8* null, %struct._prop_list_t* null }, section "__DATA, __objc_const", align 8
@"OBJC_METACLASS_$_Clang" = global %struct._class_t { %struct._class_t* @"OBJC_METACLASS_$_NSObject", %struct._class_t* @"OBJC_METACLASS_$_NSObject", %struct._objc_cache* @_objc_empty_cache, i8* (i8*, i8*)** null, %struct._class_ro_t* @"\01l_OBJC_METACLASS_RO_$_Clang" }, section "__DATA, __objc_data", align 8
@"OBJC_CLASS_$_NSObject" = external global %struct._class_t
@OBJC_METH_VAR_NAME_ = private unnamed_addr constant [5 x i8] c"test\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_ = private unnamed_addr constant [8 x i8] c"v16@0:8\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.1 = private unnamed_addr constant [5 x i8] c"name\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.2 = private unnamed_addr constant [8 x i8] c"@16@0:8\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.3 = private unnamed_addr constant [9 x i8] c"setName:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.4 = private unnamed_addr constant [11 x i8] c"v24@0:8@16\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@"\01l_OBJC_$_INSTANCE_METHODS_Clang" = private global { i32, i32, [3 x %struct._objc_method] } { i32 24, i32 3, [3 x %struct._objc_method] [%struct._objc_method { i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_METH_VAR_NAME_, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_, i32 0, i32 0), i8* bitcast (void (%0*, i8*)* @"\01-[Clang test]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_METH_VAR_NAME_.1, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.2, i32 0, i32 0), i8* bitcast (%1* (%0*, i8*)* @"\01-[Clang name]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_METH_VAR_NAME_.3, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.4, i32 0, i32 0), i8* bitcast (void (%0*, i8*, %1*)* @"\01-[Clang setName:]" to i8*) }] }, section "__DATA, __objc_const", align 8
@"OBJC_IVAR_$_Clang._name" = hidden constant i64 8, section "__DATA, __objc_ivar", align 8
@OBJC_METH_VAR_NAME_.5 = private unnamed_addr constant [6 x i8] c"_name\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.6 = private unnamed_addr constant [12 x i8] c"@\22NSString\22\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@"\01l_OBJC_$_INSTANCE_VARIABLES_Clang" = private global { i32, i32, [1 x %struct._ivar_t] } { i32 32, i32 1, [1 x %struct._ivar_t] [%struct._ivar_t { i64* @"OBJC_IVAR_$_Clang._name", i8* getelementptr inbounds ([6 x i8], [6 x i8]* @OBJC_METH_VAR_NAME_.5, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @OBJC_METH_VAR_TYPE_.6, i32 0, i32 0), i32 3, i32 8 }] }, section "__DATA, __objc_const", align 8
@OBJC_PROP_NAME_ATTR_ = private unnamed_addr constant [5 x i8] c"name\00", section "__TEXT,__cstring,cstring_literals", align 1
@OBJC_PROP_NAME_ATTR_.7 = private unnamed_addr constant [24 x i8] c"T@\22NSString\22,C,N,V_name\00", section "__TEXT,__cstring,cstring_literals", align 1
@"\01l_OBJC_$_PROP_LIST_Clang" = private global { i32, i32, [1 x %struct._prop_t] } { i32 16, i32 1, [1 x %struct._prop_t] [%struct._prop_t { i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_PROP_NAME_ATTR_, i32 0, i32 0), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @OBJC_PROP_NAME_ATTR_.7, i32 0, i32 0) }] }, section "__DATA, __objc_const", align 8
@"\01l_OBJC_CLASS_RO_$_Clang" = private global %struct._class_ro_t { i32 0, i32 8, i32 16, i8* null, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @OBJC_CLASS_NAME_, i32 0, i32 0), %struct.__method_list_t* bitcast ({ i32, i32, [3 x %struct._objc_method] }* @"\01l_OBJC_$_INSTANCE_METHODS_Clang" to %struct.__method_list_t*), %struct._objc_protocol_list* null, %struct._ivar_list_t* bitcast ({ i32, i32, [1 x %struct._ivar_t] }* @"\01l_OBJC_$_INSTANCE_VARIABLES_Clang" to %struct._ivar_list_t*), i8* null, %struct._prop_list_t* bitcast ({ i32, i32, [1 x %struct._prop_t] }* @"\01l_OBJC_$_PROP_LIST_Clang" to %struct._prop_list_t*) }, section "__DATA, __objc_const", align 8
@"OBJC_CLASS_$_Clang" = global %struct._class_t { %struct._class_t* @"OBJC_METACLASS_$_Clang", %struct._class_t* @"OBJC_CLASS_$_NSObject", %struct._objc_cache* @_objc_empty_cache, i8* (i8*, i8*)** null, %struct._class_ro_t* @"\01l_OBJC_CLASS_RO_$_Clang" }, section "__DATA, __objc_data", align 8
@"OBJC_LABEL_CLASS_$" = private global [1 x i8*] [i8* bitcast (%struct._class_t* @"OBJC_CLASS_$_Clang" to i8*)], section "__DATA,__objc_classlist,regular,no_dead_strip", align 8
@llvm.compiler.used = appending global [15 x i8*] [i8* getelementptr inbounds ([6 x i8], [6 x i8]* @OBJC_CLASS_NAME_, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_METH_VAR_NAME_, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_METH_VAR_NAME_.1, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.2, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_METH_VAR_NAME_.3, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.4, i32 0, i32 0), i8* bitcast ({ i32, i32, [3 x %struct._objc_method] }* @"\01l_OBJC_$_INSTANCE_METHODS_Clang" to i8*), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @OBJC_METH_VAR_NAME_.5, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @OBJC_METH_VAR_TYPE_.6, i32 0, i32 0), i8* bitcast ({ i32, i32, [1 x %struct._ivar_t] }* @"\01l_OBJC_$_INSTANCE_VARIABLES_Clang" to i8*), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_PROP_NAME_ATTR_, i32 0, i32 0), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @OBJC_PROP_NAME_ATTR_.7, i32 0, i32 0), i8* bitcast ({ i32, i32, [1 x %struct._prop_t] }* @"\01l_OBJC_$_PROP_LIST_Clang" to i8*), i8* bitcast ([1 x i8*]* @"OBJC_LABEL_CLASS_$" to i8*)], section "llvm.metadata"

; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[Clang test]"(%0*, i8*) #0 {
  %3 = alloca %0*, align 8
  %4 = alloca i8*, align 8
  store %0* %0, %0** %3, align 8
  store i8* %1, i8** %4, align 8
  ret void
}

; Function Attrs: noinline optnone ssp uwtable
define internal %1* @"\01-[Clang name]"(%0*, i8*) #0 {
  %3 = alloca %0*, align 8
  %4 = alloca i8*, align 8
  store %0* %0, %0** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load i8*, i8** %4, align 8
  %6 = load %0*, %0** %3, align 8
  %7 = bitcast %0* %6 to i8*
  %8 = tail call i8* @objc_getProperty(i8* %7, i8* %5, i64 8, i1 zeroext false)
  %9 = bitcast i8* %8 to %1*
  ret %1* %9
}

declare i8* @objc_getProperty(i8*, i8*, i64, i1)

; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[Clang setName:]"(%0*, i8*, %1*) #0 {
  %4 = alloca %0*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca %1*, align 8
  store %0* %0, %0** %4, align 8
  store i8* %1, i8** %5, align 8
  store %1* %2, %1** %6, align 8
  %7 = load i8*, i8** %5, align 8
  %8 = load %0*, %0** %4, align 8
  %9 = bitcast %0* %8 to i8*
  %10 = load %1*, %1** %6, align 8
  %11 = bitcast %1* %10 to i8*
  call void @objc_setProperty_nonatomic_copy(i8* %9, i8* %7, i8* %11, i64 8)
  ret void
}

declare void @objc_setProperty_nonatomic_copy(i8*, i8*, i8*, i64)

attributes #0 = { noinline optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6, !7}
!llvm.ident = !{!8}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 10, i32 15]}
!1 = !{i32 1, !"Objective-C Version", i32 2}
!2 = !{i32 1, !"Objective-C Image Info Version", i32 0}
!3 = !{i32 1, !"Objective-C Image Info Section", !"__DATA,__objc_imageinfo,regular,no_dead_strip"}
!4 = !{i32 4, !"Objective-C Garbage Collection", i32 0}
!5 = !{i32 1, !"Objective-C Class Properties", i32 64}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = !{i32 7, !"PIC Level", i32 2}
!8 = !{!"Apple clang version 11.0.0 (clang-1100.0.33.17)"}
