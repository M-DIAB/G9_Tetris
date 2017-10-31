	ghgh:
xor edi,edi
lopo:

	mov byte[esi],0x50;         |
	mov byte[esi+2],0x52;       |
	mov byte[esi+4],0x45;       |
	mov byte[esi+6],0x53;       |
	mov byte[esi+8],0x53;       |
	  ;       	                |
	mov byte[esi+12],0x41;      |
	mov byte[esi+14],0x4E;      |
	mov byte[esi+16],0x59;      |
	   ;                        |
	mov byte[esi+20],0x4B;      |
	mov byte[esi+22],0x45;      |  "press any key to start"
	mov byte[esi+24],0x59;      |
	
	mov byte[esi+28],0x54;      |
	mov byte[esi+30],0x4F; 		|
              
	mov byte[esi+34],0x53;      |
	mov byte[esi+36],0x54;      |
	mov byte[esi+38],0x41;      |
	mov byte[esi+40],0x52;      |
	mov byte[esi+42],0x54;



mov ebx,0xB8000
add ebx,14
cmp edi,3200
je ghgh
add ebx,edi
;------------------------
	mov byte[ebx],  0xDC;
	mov byte[ebx+2], 0xDC;
	mov byte[ebx+4],0xDC;
	mov byte[ebx+6],0xDC;			T
	mov byte[ebx+8],0xDC;
	mov byte[ebx+164],0xDB
	mov byte[ebx+324],0xDB;
	mov byte[ebx+484],0xDB;
	mov byte[ebx+644],0xDF;
	
	
;-------------------------------
add ebx,12
	mov byte[ebx],0xDC;
	mov byte[ebx+160],0xDB;
	mov byte[ebx+320],0xDB;
	mov byte[ebx+480],0xDB;
	mov byte[ebx+640],0xDF;
	mov byte[ebx+2],0xDC;				E
	mov byte[ebx+4],0xDC;
	mov byte[ebx+642],0xDF;
	mov byte[ebx+644],0xDF;
	mov byte[ebx+322],0xDB;
	mov byte[ebx+324],0xDB;
	
;-----------------------------------
add ebx,8
	mov byte[ebx],  0xDC;
	mov byte[ebx+2], 0xDC;
	mov byte[ebx+4],0xDC;
	mov byte[ebx+6],0xDC;			T
	mov byte[ebx+8],0xDC;
	mov byte[ebx+164],0xDB
	mov byte[ebx+324],0xDB;
	mov byte[ebx+484],0xDB;
	mov byte[ebx+644],0xDF;
;----------------------------------
add ebx,12
	mov byte[ebx],0xDC;
	mov byte[ebx+160],0xDB;
	mov byte[ebx+320],0xDB;
	mov byte[ebx+480],0xDB;				R
	mov byte[ebx+640],0xDF;
	mov byte[ebx+2],0xDC;
	mov byte[ebx+4],0xDC;
	mov byte[ebx+166],0xDB;
	mov byte[ebx+322],0xDB;
	mov byte[ebx+324],0xDB;
	mov byte[ebx+486],0xDB;
	mov byte[ebx+648],0xDF;
;-------------------------------
add ebx,12
	mov byte[ebx],0xDC;
	mov byte[ebx+160],0xDB;
	mov byte[ebx+320],0xDB;
	mov byte[ebx+480],0xDB;				I
	mov byte[ebx+640],0xDF;

;------------------------------
add ebx,4
	mov byte[ebx],0xDC;
	mov byte[ebx+2],0xDC;
	mov byte[ebx+4],0xDC;
	mov byte[ebx+160],0xDB;	
	mov byte[ebx+322],0xDB;				S
	mov byte[ebx+484],0xDB;	
	mov byte[ebx+640],0xDF;
	mov byte[ebx+642],0xDF;
	mov byte[ebx+644],0xDF;
	
	add edi,160
	
	delg:
	
	mov edx,0				
	ininlop:										
	xor eax,eax
	in al, 0x64;
	and al,1
	jnz prebo
	inc edx					;|
	cmp edx,6200000			;| delay
	jne ininlop				;|
	
	xor ecx,ecx
	mov ebx,0xB8000
	r_d:
	cmp ecx,4000
	je lopo 
	mov byte[ebx+ecx],0xFF
	add ecx,2
	jmp r_d
	
	

	prebo:
	xor ecx,ecx
	mov ebx,0xB8000
	r_x:
	cmp ecx,4000
	je stage2
	mov byte[ebx+ecx],0xFF
	add ecx,2
	jmp r_x
;=============================================

stage2:






;===================="ready"====================
mov ebx,0xB82A8
	
	
	mov byte[ebx],0xDC;
	mov byte[ebx+160],0xDB;
	mov byte[ebx+320],0xDB;
	mov byte[ebx+480],0xDB;				R
	mov byte[ebx+640],0xDF;
	call del2
	mov byte[ebx+2],0xDC;
	mov byte[ebx+4],0xDC;
	mov byte[ebx+166],0xDB;
	mov byte[ebx+322],0xDB;
	mov byte[ebx+324],0xDB;
	mov byte[ebx+486],0xDB;
	mov byte[ebx+648],0xDF;
	call del2
	
	;----------------------------------
	
	add ebx,12
	mov byte[ebx],0xDC;
	mov byte[ebx+160],0xDB;
	mov byte[ebx+320],0xDB;
	mov byte[ebx+480],0xDB;
	mov byte[ebx+640],0xDF;
	call del2
	mov byte[ebx+2],0xDC;				E
	mov byte[ebx+4],0xDC;
	mov byte[ebx+642],0xDF;
	mov byte[ebx+644],0xDF;
	mov byte[ebx+322],0xDB;
	mov byte[ebx+324],0xDB;
	call del2
	;----------------------------------
	add ebx,8
	mov byte[ebx+640],0xDF;
	mov byte[ebx+482],0xDB;
	mov byte[ebx+324],0xDB;
	mov byte[ebx+166],0xDB;
	call del2
	mov byte[ebx+8],0xDC;                A
	mov byte[ebx+170],0xDB;
	mov byte[ebx+332],0xDB;
	mov byte[ebx+494],0xDB;
	mov byte[ebx+656],0xDF;
	mov byte[ebx+326],0xDC;
	mov byte[ebx+328],0xDC;
	mov byte[ebx+330],0xDC;
	call del2
	;-------------------------------------
	add ebx,20
	mov byte[ebx],    0xDC;
	mov byte[ebx+2],  0xDC;
	mov byte[ebx+4],  0xDC;
	call del2
	mov byte[ebx+160],0xDB;
	mov byte[ebx+320],0xDB;				D
	mov byte[ebx+480],0xDB;
	mov byte[ebx+640],0xDF;
	call del2
	mov byte[ebx+642],0xDF;
	mov byte[ebx+644],0xDF;
	mov byte[ebx+486],0xDB;
	mov byte[ebx+328],0xDB;
	mov byte[ebx+166],0xDB;
	call del2
;-------------------------------------
add ebx,12
	mov byte[ebx],    0xDC;
	mov byte[ebx+8],  0xDC;
	mov byte[ebx+162],0xDB;
	mov byte[ebx+166],0xDB;				Y
	mov byte[ebx+324],0xDB;
	mov byte[ebx+484],0xDB;
	mov byte[ebx+644],0xDF;
	
	call del3

	
	xor ecx,ecx
	mov ebx,0xB82A8
	r_r:
	cmp ecx,980
	je GO
	mov byte[ebx+ecx],0x20
	add ecx,2
	jmp r_r
	

	

	del2:
	mov edx,0				;|
	inin:					;|
	inc edx					;|
	cmp edx,22000000		;| delay
	jne inin				;|
	ret						;|
	
	del3:
	mov edx,0				;|
	ininin:					;|
	inc edx					;|
	cmp edx,520000000		;| delay
	jne ininin				;|
	ret						;|
;=========================end of ready===============================




















;=========================go=======================================
GO:

mov ebx,0xB8000
	add ebx,1980
	call del

mov byte[ebx+160],0xDB;			|
	mov byte[ebx+320],0xDB;		|
	mov byte[ebx+480],0xDB;		|
	call del
	mov byte[ebx+2],0xDC;		|
	mov byte[ebx+4],0xDC;		|       G
	mov byte[ebx+6],0xDC;		|
	call del
	mov byte[ebx+642],0xDF;		|
	mov byte[ebx+644],0xDF;		|
	mov byte[ebx+646],0xDF;		|
	mov byte[ebx+486],0xDB;		|
	call del
	;----------------------------------------
	add ebx,12
	mov byte[ebx+160],0xDB;
	mov byte[ebx+320],0xDB;
	mov byte[ebx+480],0xDB;
	call del
	mov byte[ebx+2],0xDC;
	mov byte[ebx+642],0xDF;					O
	mov byte[ebx+4],0xDC;				
	mov byte[ebx+644],0xDF;
	mov byte[ebx+166],0xDB;
	mov byte[ebx+326],0xDB;
	mov byte[ebx+486],0xDB;

	;------------------------------------
	add ebx,12
	mov byte[ebx],0xDC;
	mov byte[ebx+160],0xDB;
	mov byte[ebx+320],0xDB;
	mov byte[ebx+480],0xDB;
	mov byte[ebx+640],0xDC;
	call del
	call del
	call del
	call del
	call del
	call del
	call del
	call del
	
	mov ebx,0xB8000
	add ebx,1980
	call del

	mov byte[ebx+160],0x20;		|
	mov byte[ebx+320],0x20;		|
	mov byte[ebx+480],0x20;		|
	call del            
	mov byte[ebx+2], 0x20;		|
	mov byte[ebx+4], 0x20;		|       G
	mov byte[ebx+6], 0x20;		|
	call del            
	mov byte[ebx+642],0x20;		|
	mov byte[ebx+644],0x20;		|
	mov byte[ebx+646],0x20;		|
	mov byte[ebx+486],0x20;		|
	call del
	;----------------------------------------
	add ebx,12
	mov byte[ebx+160],0x20;
	mov byte[ebx+320],0x20;
	mov byte[ebx+480],0x20;
	call del            
	mov byte[ebx+2],  0x20;
	mov byte[ebx+642],0x20;					O
	mov byte[ebx+4], 0x20;				
	mov byte[ebx+644],0x20;
	mov byte[ebx+166],0x20;
	mov byte[ebx+326],0x20;
	mov byte[ebx+486],0x20;
	call del
	;---------------------------
	add ebx,12
	mov byte[ebx], 0x20;
	mov byte[ebx+160],0x20;
	mov byte[ebx+320],0x20;
	mov byte[ebx+480],0x20;
	mov byte[ebx+640],0x20;
	
	jmp board
	
	
	del:
	mov edx,0				;|
	inlop:					;|
	inc edx					;|
	cmp edx,22500000		;| delay
	jne inlop				;|
	ret						
;;;;;;;;;;;;end of go;;;;;;;;;;;;;;;



;;;;;;;;;;;;;start of border;;;;;;;;;;;;;
board:
	mov ebx,0xB84A4
	xor ecx,ecx
	_leftside:
	cmp ecx,360
	je leftdone
	mov byte[ebx+ecx*8],0xDB
	inc ebx
	mov byte[ebx+ecx*8],0x03
	dec ebx
	add ecx,20
	jmp _leftside
	
	leftdone:
	mov ebx,0xB84BA
	xor ecx,ecx
	_rightside:
	cmp ecx,360
	je rightdone
	mov byte[ebx+ecx*8],0xDB
	inc ebx
	mov byte[ebx+ecx*8],0x03
	dec ebx
	add ecx,20
	jmp _rightside
	
	rightdone:
	mov ebx,0xB8404
	xor ecx,ecx
	roof:
	cmp ecx,24
	je endbord
	mov byte[ebx+ecx],0xDB
	inc ecx
	mov byte[ebx+ecx],0x03
	inc ecx
	jmp roof
	endbord:
	;;;;;;;;;;;;;;end of border;;;;;;;;;;;;;;;;;

	
	
	
	
	

	
	
	;===================="next shape"======================
mov ebx,0xB86A4
	add ebx,320

	mov byte[ebx],0x4E;			|
	mov byte[ebx+1],0x0D;
	mov byte[ebx+2],0x45;		|	next
	mov byte[ebx+3],0x0D;
	mov byte[ebx+4],0x58;		|
	mov byte[ebx+5],0x0D;
	mov byte[ebx+6],0x54;
	mov byte[ebx+7],0x0D;

	mov byte[ebx+10],0x53;		|
	mov byte[ebx+11],0x0D;
	mov byte[ebx+12],0x48;		|	shape
	mov byte[ebx+13],0x0D;
	mov byte[ebx+14],0x41;		|
	mov byte[ebx+15],0x0D;
	mov byte[ebx+16],0x50;		|
	mov byte[ebx+17],0x0D;
	mov byte[ebx+18],0x45;		|
	mov byte[ebx+19],0x0D;
	;===============================
	sub ebx,296
	mov byte[ebx],0xDC;
	mov byte[ebx+2],0xDC
	mov byte[ebx+4],0xDC;
	mov byte[ebx+6],0xDC;
	mov byte[ebx+8],0xDC;
	mov byte[ebx+160],0xDD
	mov byte[ebx+320],0xDD;
	mov byte[ebx+480],0xDD;					"borde of the next shape"
	mov byte[ebx+640],0xDD;
	mov byte[ebx+800],0xDF;
	mov byte[ebx+168],0xDE
	mov byte[ebx+328],0xDE;
	mov byte[ebx+488],0xDE
	mov byte[ebx+648],0xDE;
	mov byte[ebx+808],0xDF
	mov byte[ebx+802],0xDF;
	mov byte[ebx+804],0xDF
	mov byte[ebx+806],0xDF;
	
	
	add ebx,1
	mov byte[ebx],    0x0A;
	mov byte[ebx+2],  0x0A
	mov byte[ebx+4],  0x0A;
	mov byte[ebx+6],  0x0A;
	mov byte[ebx+8],  0x0A;
	mov byte[ebx+160],0x0A
	mov byte[ebx+320],0x0A;
	mov byte[ebx+480],0x0A;					"color of the border of the next shape"
	mov byte[ebx+640],0x0A;
	mov byte[ebx+800],0x0A;
	mov byte[ebx+168],0x0A
	mov byte[ebx+328],0x0A;
	mov byte[ebx+488],0x0A
	mov byte[ebx+648],0x0A;
	mov byte[ebx+808],0x0A
	mov byte[ebx+802],0x0A;
	mov byte[ebx+804],0x0A
	mov byte[ebx+806],0x0A;
	
	
;==========================
;;;;;;;;;;;; end of next shape;;;;;;
	
	


	mov ebx,0xB8962
	
	mov byte[ebx],0x43;         |
	mov byte[ebx+2],0x4F;       |
	mov byte[ebx+4],0x4E;       |         "controls:"
	mov byte[ebx+6],0x54;       |
	mov byte[ebx+8],0x52;    	|
	mov byte[ebx+10],0x4F;      |
	mov byte[ebx+12],0x4C;      |
	mov byte[ebx+14],0x53;      |
	mov byte[ebx+16],0x3A;      |
	
	
	;----------------------------------
	add ebx,160
	mov byte[ebx],0x55; 	        |
	mov byte[ebx+2],0x50;      |
	mov byte[ebx+6],0x41;      |
	mov byte[ebx+8],0x52;      |
	mov byte[ebx+10],0x52;      |
	mov byte[ebx+12],0x4F;    	|
	mov byte[ebx+14],0x57
	mov byte[ebx+16],0x3A;       |			"up arrow: rotate"
	mov byte[ebx+20],0x52;       |
	mov byte[ebx+22],0x4F;       |
	mov byte[ebx+24],0x54;    	|
	mov byte[ebx+26],0x41;      |
	mov byte[ebx+28],0x54;      |
	mov byte[ebx+30],0x45;      |
	;------------------------------------
	;----------------------------------
	add ebx,160
	mov byte[ebx],0x52; 	        |
	mov byte[ebx+2],0x49;       |
	mov byte[ebx+4],0x47;       |
	mov byte[ebx+6],0x48;       |
	mov byte[ebx+8],0x54;      |
	mov byte[ebx+12],0x41;      |
	mov byte[ebx+14],0x52;      |
	mov byte[ebx+16],0x52;      |
	mov byte[ebx+18],0x4F;      |
	mov byte[ebx+20],0x57;      |
	mov byte[ebx+22],0x3A;      |			"right arrow: move right"
	mov byte[ebx+26],0x4D;      |
	mov byte[ebx+28],0x4F;      |
	mov byte[ebx+30],0x56;    	|
	mov byte[ebx+32],0x45;      |
	mov byte[ebx+36],0x52;      |
	mov byte[ebx+38],0x49;      |
	mov byte[ebx+40],0x47;      |
	mov byte[ebx+42],0x48;      |
	mov byte[ebx+44],0x54;      |
	;------------------------------------
	;----------------------------------
	add ebx,160
	mov byte[ebx],0x4C; 	    |
	mov byte[ebx+2],0x45; 	    |
	mov byte[ebx+4],0x46; 	    |
	mov byte[ebx+6],0x54; 	    |
	mov byte[ebx+10],0x41; 	    |
	mov byte[ebx+12],0x52; 	    |
	mov byte[ebx+14],0x52; 	    |
	mov byte[ebx+16],0x4F; 	    |
	mov byte[ebx+18],0x57; 	    |
	mov byte[ebx+20],0x3A;      |			"left arrow: move left"
	mov byte[ebx+24],0x4D;      |
	mov byte[ebx+26],0x4F;      |
	mov byte[ebx+28],0x56;    	|
	mov byte[ebx+30],0x45;      |
	mov byte[ebx+34],0x4C;      |
	mov byte[ebx+36],0x45;      |
	mov byte[ebx+38],0x46;      |
	mov byte[ebx+40],0x54;      |
	;------------------------------------
	;----------------------------------
	add ebx,160
	mov byte[ebx],0x44; 	    |
	mov byte[ebx+2],0x4F; 	    |
	mov byte[ebx+4],0x57; 	    |
	mov byte[ebx+6],0x4E; 	    |
	mov byte[ebx+10],0x41;      |			"down arrow: soft drop"
	mov byte[ebx+12],0x52;      |
	mov byte[ebx+14],0x52;      |
	mov byte[ebx+16],0x4F;    	|
	mov byte[ebx+18],0x57;      |
	mov byte[ebx+20],0x3A;      |
	mov byte[ebx+24],0x53;      |
	mov byte[ebx+26],0x4F;      |
	mov byte[ebx+28],0x46;      |
	mov byte[ebx+30],0x54;      |
	mov byte[ebx+34],0x44;      |
	mov byte[ebx+36],0x52;      |
	mov byte[ebx+38],0x4F;      |
	mov byte[ebx+40],0x50;      |
	;------------------------------------
	;----------------------------------
	add ebx,160
	mov byte[ebx],0x50; 	    |
	mov byte[ebx+2],0x3A;       |			"p: pause game/continue"
	mov byte[ebx+6],0x50;       |
	mov byte[ebx+8],0x41;       |
	mov byte[ebx+10],0x55;    	|
	mov byte[ebx+12],0x53;      |
	mov byte[ebx+14],0x45;      |
	mov byte[ebx+18],0x47;      |
	mov byte[ebx+20],0x41;      |
	mov byte[ebx+22],0x4D;      |
	mov byte[ebx+24],0x45;      |
	mov byte[ebx+26],0x2F;      |
	mov byte[ebx+28],0x43;      |
	mov byte[ebx+30],0x4F;      |
	mov byte[ebx+32],0x4E;      |
	mov byte[ebx+34],0x54;      |
	mov byte[ebx+36],0x49;      |
	mov byte[ebx+38],0x4E;      |
	mov byte[ebx+40],0x55;      |
	mov byte[ebx+42],0x45;      |
	;------------------------------------
	;------------------------------------
	add ebx,160
	mov byte[ebx],0x52;         |
	mov byte[ebx+2],0x3A;	    |
	
	mov byte[ebx+6],0x52;       |
	mov byte[ebx+8],0x45;       |
	mov byte[ebx+10],0x53;    	|	
	mov byte[ebx+12],0x54;      |		"r: restart"
	mov byte[ebx+14],0x41;      |
	mov byte[ebx+16],0x52; 		|
	mov byte[ebx+18],0x54;      |
	;-----------------------------------------
	;-----------------------------------------
	add ebx,160
    mov byte[ebx],0x51;         |
	mov byte[ebx+2],0x3A;       |
	mov byte[ebx+6],0x51;       |
	mov byte[ebx+8],0x55;       |       "q: quit"
	mov byte[ebx+10],0x49;      |
	mov byte[ebx+12],0x54;      |
	;------------------------------------------
