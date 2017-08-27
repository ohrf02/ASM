.486
option casemap: none ;case sensitive

;; MASM MACROS
include \masm32\include\masm32rt.inc  
includelib \masm32\lib\masm32rt.lib

;;Code
.code

;The proc returns the value of the given index in the fibonacci-sequence.
Fibo:
	push ebp
	mov ebp, esp
	
	;Makes space for one local variable.
	sub esp, 8
	push ecx
	
	;Reads the index of the requested fibonacci-sequence's number.
	mov ecx, [ebp + 8]
	
	;If the index is 1 or 2 => return 1.
	cmp ecx, 1
	jz return_1
	
	cmp ecx, 2
	jz return_1
	
	;Calculate the value of (Fibo(n-1) + Fibo(n-2)) = Fibo(n).
	dec ecx
	push ecx
	call Fibo
	
	;Stores the value of Fibo(n-1) in the stack.
	mov [ebp - 8], eax
	
	;Decrease the index by one to get the index of Fibo(n-2).
	pop ecx
	dec ecx
	push ecx
	call Fibo
	
	;The sum of Fibo(n-1) + Fibo(n-2) is now in eax.
	add eax, [ebp - 8]
	
	jmp end_of_fibo
	
return_1:
	mov eax, 1
		
end_of_fibo:	
	pop ecx
	add esp, 8
	
	mov esp, ebp
	pop ebp

	ret
	
	
_start:
	;The index of the requested fibonacci number.
	push dword ptr 11
	call Fibo
	
	;Fibo returns the fibonacci-sequence's value of the given index.
	print str$(eax)
	
	;In cdecl the function does not clean the given parameters in the stack (so the user needs to do it).
	add esp, 4
		
end_prog:
    push eax 
    call ExitProcess
end _start
