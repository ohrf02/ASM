.486
option casemap: none ;case sensitive

;; MASM MACROS
include \masm32\include\masm32rt.inc  
includelib \masm32\lib\masm32rt.lib

.data

string1 db 'Test @@##@', 00h
string2 db 'Test @@##@', 00h

;;Code
.code

;The proc returns in eax 0 if the given strings are the same, or 1 otherwise.
Strcmp:

	push ebp
	mov ebp, esp
	
	;Saves the registers' value.
	push edi
	push esi
	
	;Reads the offset of the given strings.
	mov edi, [ebp + 8]
	mov esi, [ebp + 12]
	
;Goes over the strings's chars till the chars are not matching,
;or the strings have come to their end.
cmp_loop:
	mov bl, [edi]
	cmp bl, [esi]
	
	;If the chars are not matching => returns 1.
	jnz if_not_matched
	
	cmp [esi], byte ptr 0
	
	;If the strings have come to their end(NULL char) => returns 0.
	jz if_matched
	
	;Increase esi and edi by 1 (goes to the next char of the string).
	inc esi
	inc edi
	jmp cmp_loop

if_matched:
	mov eax, 0
	jmp end_of_Strcmp
	
if_not_matched:
	mov eax, 1
	jmp end_of_Strcmp
	
end_of_Strcmp:
	pop esi
	pop edi
	
	mov esp, ebp
	pop ebp

	ret
	

_start:

	push  offset string1
	push  offset string2
	call Strcmp

	print str$(eax)
	
end_prog:
    push eax 
    call ExitProcess
end _start
