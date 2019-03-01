;
; file: asm_io.asm
; Assembly I/O routines
; To assemble for Linux
;   nasm -f elf -d ELF_TYPE asm_io.asm


%define NL 10
%define CF_MASK 00000001h
%define PF_MASK 00000004h
%define AF_MASK 00000010h
%define ZF_MASK 00000040h
%define SF_MASK 00000080h
%define DF_MASK 00000400h
%define OF_MASK 00000800h


;
; Linux C doesn't put underscores on labels
;
%ifdef ELF_TYPE
  %define _scanf   scanf
  %define _printf  printf
  %define _getchar getchar
  %define _putchar putchar
%endif

%ifdef OBJ_TYPE
segment .data public align=4 class=data use32
%else
segment .data
