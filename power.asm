.486
option casemap: none ;case sensitive

;; MASM MACROS
include \masm32\include\masm32rt.inc  
includelib \masm32\lib\masm32rt.lib

;;Code
.code

;The powering proc.
Pow:
	push ebp
	mov ebp, esp
	
	push ebx
	
	;Moves the exponent- 1(because the loop counts the 0!) to ecx.
	mov ecx, [ebp + 12]
	dec ecx
	
	;Moves the base to ebx and eax .
	mov ebx, [ebp + 8]
	mov eax, ebx
	
;The powering loop.
power_loop:
	mul ebx
	loop power_loop
	
	pop ebx
	
	mov esp, ebp
	pop ebp
	
	ret
	

_start:

	push  2
	push  8   
	call Pow

	print str$(eax), 10, 13 

end_prog:
    push eax 
    call ExitProcess
end _start
