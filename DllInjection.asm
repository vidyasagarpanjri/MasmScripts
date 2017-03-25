; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい
    include \masm32\include\masm32rt.inc
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

comment * -----------------------------------------------------
                     Build this console app with
                  "MAKEIT.BAT" on the PROJECT menu.
        ----------------------------------------------------- *

    .data?
      value dd ?
      dname dd 20 dup(?)
      fname dd 20 dup(?)
      dllLen dd ?

      mAddr dd ?
      lpAddr dd ?
      vpointer dd ?
      
      processinfo PROCESS_INFORMATION <>
      startupinfo STARTUPINFO <>

    .data
      item dd 0
      dreet db "enter the dll",0
      ;dgreet db "%s",0
      dllname db "../mydll.dll",0
      freet db "enter the file",0
      fgreet db "%s",0 
      ;dllname db "kernel32.dll",0
      apiname db "LoadLibrayA",0

    .code

start:
   
; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

    call main
    inkey
    exit

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

main proc

    cls
    print "Hello World",13,10
; enter dll name
    invoke crt_printf, addr dreet
    invoke crt_scanf, addr dllname, addr dname
    ;invoke crt_printf,addr  dllname
; enter file name exe
    invoke crt_printf, addr freet
    invoke crt_scanf, addr fgreet, addr fname
; loaded Kernel32.dl
    invoke LoadLibrary, addr dllname
    mov mAddr,eax
    print mAddr
; getting the address of api LoadLibraryA
    invoke GetProcAddress, mAddr, addr apiname
    mov lpAddr,eax
    print lpAddr
; create process in suspended address    
    invoke CreateProcess, addr fname,0,0,0,0,CREATE_SUSPENDED,0,0, addr startupinfo, addr processinfo

; find the length of dll and save it 
    mov dllLen,eax
; Allocate space for dll code in created process
    invoke VirtualAllocEx,processinfo.hProcess,NULL,dllLen,MEM_COMMIT,PAGE_EXECUTE_READWRITE
    mov vpointer,eax
;Write DLL name into allocated space    
    invoke WriteProcessMemory,processinfo.hProcess,vpointer,addr dname,dllLen,NULL
;Execute the Load
    invoke CreateRemoteThread,processinfo.hProcess,NULL,0,lpAddr,vpointer,0,NULL
    invoke Sleep,1000d
;invoke ResumeThread,processinfo.hThread

;xor eax,eax
;invoke ExitProcess,eax

    ret

main endp

; いいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいいい

end start
