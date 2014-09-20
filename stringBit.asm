title DECIMAL_TO_BINARY
; James-Andrew R. Sarmiento
; 2012-26531

.model small 
.data
	value dw 0
	count db 0
.stack 100h
.code
	main proc
	
	mov ax, @data
	mov ds,ax
	
	mov bx, 0
	xor ax, ax
	mov value, 0
	
	;gets the input of the user per input
	getUserInput:
		inc count							  
		mov ah, 01h 						
		int 21h
	    	
	    	cmp al, 13			; exits if given an ENTER
	    	je exitLoop
	    	
		sub al, 48				; make input a decimal
		xor cx, cx
		mov cl, al				; stores input to cl register for later use
		mov ax, value			; stores previous value to ax
		mov bl, 10
		mul bx					; multiplies by 10 to value
		mov value, ax	
		add value, cx			; stores to value. 
								; the whole proces is just like value = value + input 
		cmp count, 5
		jl getUserInput
		
	exitLoop:
	
		mov dl, 0ah				; prints next line
		mov ah, 02h
		int 21h
	
		xor ax, ax				; clear register
		xor cx, cx
		
		mov bx, 0
	bitShift:
		
		mov ax, bx				; copies bx to ax register for division
		mov cl, 4
		div cl
		cmp ah, 0 
		jne next
			printSpace:			; prints space every four characters
				mov dl, 32 							
				mov ah, 02h
				int 21h
			jmp shift
		
		next:			
		shift:				
			shl value, 1		; uses bitshifts to drop leftmost binary to cl register
			jc printOne			; goes to printOne label if the cl is 1, other wise goes to printZero
			jnc printZero			
					
			printOne:
				mov dl, 49 							
				mov ah, 02h
				int 21h
				jmp Increment
			
			printZero:
				mov dl, 48
				mov ah, 02h
				int 21h
				jmp Increment
				
			
	Increment:
		inc bx
	cmp bx, 16
	jl bitShift
					
	mov ax, 4c00h
	int 21h
	
	main endp
	end main
