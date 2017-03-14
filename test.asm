.386
.model flat, stdcall
    option casemap:none
    include \masm32\include\windows.inc
    include \masm32\include\kernel32.inc
    includelib \masm32\lib\kernel32.lib 
    include \masm32\include\user32.inc
    includelib \masm32\lib\user32.lib
    includelib \masm32\lib\masm32.lib
    include \masm32\include\masm32.inc
.data
    msg db "vidya sagar panjri",0
.code
start:
    push offset msg
    call StdOut
    push 0
    call ExitProcess
end start 