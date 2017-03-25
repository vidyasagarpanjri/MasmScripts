;program for taking the input from user and printing it out to the screen

include \masm32\include\masm32rt.inc

.data ;initialised values/ variables
    input_msg db "Please enter your number\n",0
    output_even db "EVEN",0
    output_odd db "ODD",0
    format db "%d",0 ; formatter to scan and print the data %d is for decimal 

.data? ; uninitialised variables 
    input_number dd ?

.code 

 start:

    ;like printf("hello world");
    push offset input_msg ; pushed the starting address of in put message onto the stack
    call crt_printf ; this function will show the text on screen
    add esp,4   ; emptied the stack
    
    ;like scanf("%d",&variable);
    push offset input_number ; pushed the input_number variable on to the stack 
    push offset format ; pushed the format of the string to the stack
    call crt_scanf ; this function will take the user value
    add esp,8 ; this time we have pushed two words i.e. 8 bytes so we moved our stack pointer to 8 bytes to free stack  
    
    mov eax,dword ptr [input_number] ; this is just to show the value in eax register when we see it in debuggers
                                     ; it takes the value present in the location of [address] and move that into eax 
    
    ;like printf("%d",variable)
    push input_number ; ^^^^ pushed the value onto the stack as we have integer value ^^^^ if the number is int then value,  else the offset of string
    push offset format ; the format
    call crt_printf ; the function to take two argument and print the result
    add esp,8
 
 
    inkey 
    exit
 end start


