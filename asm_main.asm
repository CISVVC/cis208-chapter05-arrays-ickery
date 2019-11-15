;
; file: asm_main.asm
; author: david serrano
; email: davids2016@student.vvc.edu
; description: multiply an array by an asked scalar
%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
        syswrite: equ 4
        stdout: equ 1
        exit: equ 1
        SUCCESS: equ 0
        kernelcall: equ 80h
        array dd 5, 2, 1, 6, 3 
        length dd 5
        scalar dd 3
        prompt db "Enter a number to multiply by: ", 0


; uninitialized data is put in the .bss segment
;
segment .bss
        input1 resd 1
;
; code is put in the .text segment
;
segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha
; *********** Start  Assignment Code *******************
        ; Pushes starting address of array and length value of array
        mov eax, array
        push eax
        mov eax, [length]
        push eax
        
        ; Create prompt asking for scalar value then push it
        mov eax, prompt
        call print_string
        call read_int
        push eax

        ; Call function that multiplies array by scalar
        call array_multiply
        ; Pop out things with pushed prioe
        pop eax
        pop eax
        pop eax

        ; Prepare to loop through array to print values
        mov ecx, [length]
        mov edx, 0
        
        ; Loop through array and print values
loop2:
        mov eax, [array+edx]
        call print_int
        call print_nl
        add edx, 4
        loop loop2
; *********** End Assignment Code **********************

        popa
        mov     eax, SUCCESS       ; return back to the C program
        leave                     
        ret
array_multiply:
        push ebp
        mov ebp, esp

        mov ebx, [ebp+16]
        mov ecx, [ebp+12]
        mov edx, 0
loop1:
        mov eax, [ebx + edx]
        imul eax, [ebp+8]
        mov [ebx+ edx], eax
        add edx, 4
        loop loop1



        pop ebp
        ret






