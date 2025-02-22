;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                               ;
;   @file starpath.asm                          ;
;   @brief                                      ;
;   Reimplementation of the winner of the       ;
;   Lovebyte 2025 competition                   ;
;   (64-byte category).                         ;
;   Original code here:                         ;
;   https://www.pouet.net/prod.php?which=103622 ;
;   This version is a adaptation of             ;
;   the original, written in NASM,              ;
;   running in 16-bit BIOS mode.                ;
;   Credits to the original creator             ;
;   and competition organizers.                 ;
;                                               ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
[bits 16]
[org 0x7c00]

; Clear registers
xor ax, ax
xor bx, bx
xor cx, cx
xor dx, dx
xor si, si

; Set video mode to 320x200 with 256 colors
mov al, 0x13
int 0x10

; Main rendering loop
B:
cwd                 ; Calculate DX:AX / CX to get raycasting coordinates
int 0x10            ; Interrupt to plot pixel on screen

; Color selection for background and animation effects
X:
mov bl, 0xD         ; Set background color for the sky

L:
mov ax, 0xCCCC      ; Perform multiplication to calculate pixel data for animation
mul cx
mov al, dh
mul bl
xchg ax, dx
sub al, bl
jc W                ; Conditional jump if carry flag is set
mul bl
mov al, dh
or al, ah
lea dx, [bx+si]     ; Load effective address for next ray to plot
inc bx
and al, dl
test al, 16
jz L                ; Repeat if the condition is not met
jmp short Q         ; Jump to continue drawing

W:
mov al, 27
add dl, cl
jz Q                ; If condition is met, finish drawing loop

; Bit-shift operation to adjust animation
A:
shld ax, cx, 4

Q:
mov ah, 0x0C        ; Interrupt to plot the pixel at coordinates
loop B              ; Continue the main loop indefinitely
inc si              ; Increment SI for new coordinates
jmp short B         ; Jump to the start of the loop again

; Fill the rest of the boot sector with zeros and add boot signature
times 510 - ($ - $$) db 0  
dw 0xAA55          ; Boot signature to make the BIOS recognize this as a bootable sector
