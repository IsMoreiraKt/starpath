.intel_syntax noprefix
.code16
.section .text
.global _start

#################################################
#                                               #
#   @file starpath.asm                          #
#   @brief                                      #
#   Reimplementation of the winner of the       #
#   Lovebyte 2025 competition                   #
#   (64-byte category).                         #
#   Original code here:                         #
#   https://www.pouet.net/prod.php?which=103622 #
#   This version is an adaptation of            #
#   the original, written in NASM,              #
#   running in 16-bit BIOS mode.                #
#   Credits to the original creator             #
#   and competition organizers.                 #
#                                               #
#################################################

_start:
    # Clear registers (Clear the registers)
    xor ax, ax            # Zero out register AX
    xor bx, bx            # Zero out register BX
    xor cx, cx            # Zero out register CX
    xor dx, dx            # Zero out register DX
    xor si, si            # Zero out register SI

    # Set video mode to 320x200 (256 colors) (Set the video mode to 320x200 with 256 colors)
    mov al, 0x13          # Set video mode number
    int 0x10              # Call BIOS interrupt to change video mode

B:
    cwd                   # Sign-extend AX into DX:AX
    int 0x10              # Call video interrupt to plot pixel on screen

X:
    mov bl, 0xD           # Set background color (sky)

L:
    mov ax, 0xCCCC        # Perform multiplication to calculate pixel data for animation
    mul cx
    mov al, dh
    mul bl
    xchg ax, dx
    sub al, bl
    jc W                  # Jump if carry flag is set
    mul bl
    mov al, dh
    or al, ah
    lea dx, [bx+si]       # Load effective address for next ray to plot
    inc bx                # Increment BX (pixel control)
    and al, dl
    test al, 16
    jz L                  # Repeat loop L if condition is not met
    jmp short Q           # Jump to part Q

W:
    mov al, 27
    add dl, cl
    jz Q                  # Jump to part Q if condition is met

A:
    shld ax, cx, 4        # Perform a shift-left operation to adjust animation

Q:
    mov ah, 0x0C          # Call video interrupt to plot pixel at coordinates
    loop B                # Continue the main rendering loop indefinitely
    inc si                # Increment SI for new coordinates
    jmp short B           # Jump to the start of the loop again

# Filling the boot sector up to 510 bytes (Filling the rest of the boot sector up to 510 bytes)
.org 510
    .word 0xAA55          # Boot signature to identify as a valid boot sector
