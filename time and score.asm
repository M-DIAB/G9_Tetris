	;;;;;;;;time;;;;;;;;;;;;;;;;;;;; 
	mov ebx,0xB8000
	add ebx,980
	mov esi,ebx
	
	mov byte[ebx+4],0x54;		|
	mov byte[ebx+5],0x0A;		|
	mov byte[ebx+6],0x49;		|
	mov byte[ebx+7],0x0A;		|
	mov byte[ebx+8],0x4D;		| "TIME:"
	mov byte[ebx+9],0x0A;		|
	mov byte[ebx+10],0x45;		|
	mov byte[ebx+11],0x0A;		|
	mov byte[ebx+12],0x3A;		|
	mov byte[ebx+13],0x0A;		|
	
	mov byte[ebx+14],0x30;		|
	mov byte[ebx+16],0x30;		| "00:00"
	mov byte[ebx+18],0x3A;		|
	mov byte[ebx+20],0x30;		|
	mov byte[ebx+22],0x30;		|
	
	mov byte[a],0x30
	mov byte[b],0x30			; saving variables
	mov byte[c],0x30
	mov byte[d],0x30
	;;;;;;;;;end of time;;;;;;;;;;;;
	
	;;;;;;;;;start of score;;;;;;;;;;
	add ebx,320
	mov ebp,ebx
	mov byte[ebx+164],0x53;		|
	mov byte[ebx+165],0x0E;		|
	mov byte[ebx+166],0x43;		|
	mov byte[ebx+167],0x0E
	mov byte[ebx+168],0x4F;		| "SCORE:"
	mov byte[ebx+169],0x0E
	mov byte[ebx+170],0x52;		|
	mov byte[ebx+171],0x0E
	mov byte[ebx+172],0x45;		|
	mov byte[ebx+173],0x0E
	mov byte[ebx+174],0x3A;		|
	mov byte[ebx+175],0x0E
	
	mov byte[ebx+324],0x30;		|
	mov byte[ebx+326],0x30;		|
	mov byte[ebx+328],0x30;		| "00000"
	mov byte[ebx+330],0x30;		|
	mov byte[ebx+332],0x30;		|
	
	mov byte[e],0x30
	mov byte[f],0x30;			zero the score
	mov byte[g],0x30
	mov byte[h],0x30
	;;;;;;;;;end of score;;;;;;;;;;;;