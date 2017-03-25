;program for taking the input from user and printing it out to the screen

include \masm32\include\masm32rt.inc

.data ;initialised values/ variables
    input_msg db "Please enter your number  :",0
    output_even db "EVEN",13,10,0 ; 13, 10 is for CR LR, new line \r\n
    output_odd db "ODD",13,10,0
    format db "%d",0 ; formatter to scan and print the data %d is for decimal 

.data? ; uninitialised variables 
    input_number dd ?  ; to save user input

.code 

 start:

    ;like printf("Please enter your name");
    push offset input_msg ; pushed the starting address of in put message onto the stack
    call crt_printf ; this function will show the text on screen
    add esp,4   ; emptied the stack
    
    ;like scanf("%d",&variable);
    push offset input_number ; pushed the input_number variable on to the stack 
    push offset format ; pushed the format of the string to the stack
    call crt_scanf ; this function will take the user value
    add esp,8 ; this time we have pushed two words i.e. 8 bytes so we moved our stack pointer to 8 bytes to free stack  
    
    mov eax,dword ptr [input_number] ; moved the value to eax
    xor edx,edx ; clear the edx register as we have only 32 bit int
    mov ecx,2 ; divisor to ecx, 
                ; if the remainder is 0 then value is even else odd
    div ecx ; div always divides 64 bit values edx:eax
            ; divisor can be any registor  like ecx
            ; q=eax and remainder =edx
    test edx,edx ; if edx if zero or not

    jz @@even ; if zero jump to even label
    ; else run this code print "ODD"
    push offset output_odd
    call crt_printf ; the function to take two argument and print the result
    add esp,4
    exit

    @@even: ; print "EVEN"
        push offset output_even ; print even 
        call crt_printf ; the function to take two argument and print the result
        add esp,4
 exit
 end start


