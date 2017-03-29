; After a long struggle and searching and googling i found this golden words.

;The concept of argc and argv are C run time specific. At OS low level they do not exist. 
;They exist in C because the C runtime does execute some pre-startup code 
;and prepares this for you before execution reaches the main() function.
;We can eventually have them in ASM but in that case you must link and use the C runtime library.

;However in ASM it is kind of a custom to write your own by using the GetCommandLine API and 
;parsing the command line string as shown Below ;)

;ref:http://www.masmforum.com/board/index.php?PHPSESSID=786dd40408172108b65a5a36b09c88c0&topic=14702.0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    include \masm32\include\masm32rt.inc
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

comment * -----------------------------------------------------
                     Build this console app with
                  "MAKEIT.BAT" on the PROJECT menu.
        ----------------------------------------------------- *

    .data?
      ItemBuffer dd ? ;buffer to save the arcument ;

    .data
      item dd 0

    .code

start:
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    call main ; call mail
    inkey ; wait for keyboard input
    exit ; exit the process 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

main proc 
    cls ; clear screen 
    push ebp ; push the baspointer , to save the retun pointer in LInked list of function called 
    mov ebp, esp ; make stack pointer as base pointer of local function 
    invoke GetCL,1,addr ItemBuffer; this is imp I am using the macro in order to skip the stack operation 
                                    ; 1= position of the Argument , To save value 
    push offset ItemBuffer ; push the offset
    call crt_printf ; call the printf to print on the screen 
    print "Hello World",13,10
    pop ebp; get the value of previous stacks base pointer 
    ret

main endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

end start
