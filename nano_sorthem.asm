%include "asm_io.inc"
;NAVID RAYHAN CS 2xa3 FINAL PROJ
SECTION .data

err1: db "incorrect number of command line arguments",10,0
err2: db "enter integer between 2-9", 10,0
msg1: db "inital configuration:",10,0
msg2: db "final configuration:",10,0
base: db "XXXXXXXXXXXXXXXXXXXXXX",10,0

s1: db "        o | o        ",10,0
s2: db "       oo | oo       ",10,0
s3: db "      ooo | ooo      ",10,0
s4: db "     oooo | oooo     ",10,0
s5: db "    ooooo | ooooo    ",10,0
s6: db "   oooooo | oooooo   ",10,0
s7: db "  ooooooo | ooooooo  ",10,0
s8: db " oooooooo | oooooooo ",10,0
s9: db "ooooooooo | ooooooooo",10,0

disk: dd 0

SECTION .bss
peg: resd 9

SECTION .text

global asm_main

asm_main:


        enter 0,0
        pusha

        jmp check_args
        args_checked:

        jmp call_rconf
        conf_called:

        call showp
        add esp, 8

        push ecx
        push peg
        call sorthem
        add esp, 8

        mov ecx, [disk]
        push ecx
        push peg
        mov eax, msg2
        call print_string
        call showp

        add esp, 8
        jmp end

check_args:
        mov eax, dword [ebp+8]
        cmp eax, dword 2
        jne ERR1
        mov ebx, dword [ebp+12]
        mov eax, dword [ebx+4]

        mov bl,byte[eax+1]
        cmp bl,byte 0
        jne ERR2

        mov bl,byte[eax]
        mov eax,0
        mov al, bl
        sub al , '0'

        cmp eax, dword 2
        jb ERR2
        cmp eax, dword 9
        ja ERR2
        jmp args_checked                ;jmp to flag in main

call_rconf:
        push eax
        push peg

        call rconf
        add eax, 1
        add esp, 8
        mov ecx, eax
        mov [disk], ecx
        push ecx
        push peg
        call print_string

        jmp conf_called; jump to flag in main

showp:
        enter 0,0
        pusha

        mov edx, [ebp + 8]              ; mem loc
        mov esi, [ebp + 12]             ; num enterrd
        mov ebx, esi
        sub esi, 1

        MYLOOP: cmp ebx, dword 0
                cmp [edx+esi*4],  dword 9
                je a9
                cmp [edx+esi*4], dword 8
                je a8
                cmp [edx+esi*4], dword 7
                je a7
                cmp [edx+esi*4], dword 6
                je a6
                cmp [edx+esi*4], dword 5
                je a5
                cmp [edx+esi*4], dword 4
                je a4
                cmp [edx+esi*4], dword 3
                je a3
                cmp [edx+esi*4], dword 2
                je a2
                cmp [edx+esi*4], dword 1
                je a1
                mov eax, base
                call print_string
                call read_char
                jmp end

a9:
mov eax, s9
call print_string
sub esi, 1
sub ebx, 1
jmp MYLOOP
a8:
mov eax, s8
call print_string
sub esi, 1
sub ebx, 1
jmp MYLOOP
a7:
mov eax, s7
call print_string
sub esi, 1
sub ebx, 1
jmp MYLOOP
a6:
mov eax, s6
call print_string
sub esi, 1
sub ebx, 1
jmp MYLOOP
a5:
mov eax, s5
call print_string
sub esi, 1
sub ebx, 1
jmp MYLOOP
a4:
mov eax, s4
call print_string
sub esi, 1
sub ebx, 1
jmp MYLOOP
a3:
mov eax, s3
call print_string
sub esi, 1
sub ebx, 1
jmp MYLOOP
a2:
mov eax, s2
call print_string
sub esi, 1
sub ebx, 1
jmp MYLOOP
a1:
mov eax, s1
call print_string
sub esi, 1
sub ebx, 1
jmp MYLOOP

sorthem:
        enter 0,0
        pusha

        mov edx, [ebp+8]
        mov ecx, [ebp+12]
        mov edi, ecx
        cmp edi, dword 1
        je  end
        sub edi, 1
        add edx, 4
        push edi
        push edx
        add edi, 1
        sub edx, 4

        call sorthem            ; recursive step
        add esp, 8
        mov edi, 0

        loop:
                cmp edi, ecx
                je end
                mov eax, [edx+edi*4]
                cmp eax, [edx+edi*4+4]
                ja end
                mov eax, dword [edx+edi*4]
                mov ebx, eax
                mov eax, dword [edx+edi*4+4]
                mov [edx+edi*4], eax
                mov [edx+edi*4+4], dword ebx
                add edi, 1
                jmp loop

ERR1:
        mov eax, err1
        call print_string
        jmp end
ERR2:
        mov eax, err2
        call print_string
        jmp end
end:
        popa
        leave
        ret



