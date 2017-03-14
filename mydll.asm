; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
    include \masm32\include\masm32rt.inc
; ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤

    ; -------------------------------------------
    ; Build this DLL with the provided MAKEIT.BAT
    ; -------------------------------------------
MyThread PROTO
.data
Msg db 'Heelo from DLL',0
MsgTitle db 'DLL window',0 
.data?
hInstance dd ?
.code
; «««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««

LibMain proc instance:DWORD,reason:DWORD,unused:DWORD 

    .if reason == DLL_PROCESS_ATTACH
      mrm hInstance, instance       ; copy local to global
      mov eax, TRUE                 ; return TRUE so DLL will start

      invoke CreateThread,0,0, addr MyThread,0,0,0

    .elseif reason == DLL_PROCESS_DETACH
    
    .elseif reason == DLL_THREAD_ATTACH
;      invoke CreateThread,0,0, addr MyThread,0,0,0
    .elseif reason == DLL_THREAD_DETACH

    .endif

    ret

LibMain endp

; «««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««

  comment * -----------------------------------------------------
          You should add the procedures your DLL requires AFTER
          the LibMain procedure. For each procedure that you
          wish to EXPORT you must place its name in the "mydll.def"
          file so that the linker will know which procedures to
          put in the EXPORT table in the DLL. Use the following
          syntax AFTER the LIBRARY name on the 1st line.
          LIBRARY mydll
          EXPORTS MyThread
          EXPORTS AnotherProcName
          ------------------------------------------------------- *

; «««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««««

MyThread proc
    InfiniteLoop:
        invoke Sleep,10
        invoke GetAsyncKeyState, VK_F12
        test eax,eax
        jz InfiniteLoop
    invoke MessageBox, 0, addr Msg, addr MsgTitle, 0
    jmp InfiniteLoop
MyThread endp

end LibMain