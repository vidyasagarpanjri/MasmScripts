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
// to initianlise the constants
.data
// variable msg ="vidya sagar panjri" with null at end
    msg db "vidya sagar panjri",0
// actual code
.code
start:
// entering the starting value of variable
    push offset msg
// calling the output function available in masm.
    call StdOut
//then push null
    push 0
//call the exit funtion to exit the process
    call ExitProcess
end start 
