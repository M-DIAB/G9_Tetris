bits 16
org 0x7C00

	cli   
	   jump:
	   mov ah,0x02 
	   mov al,35  ;increasing this number increases the memory for the code by (512B * number in al)
	   mov dl,0x80 
	   mov ch,0 
	   mov dh ,0
	   mov cl,2 
	   mov bx,stage
	   int 13h 
	   jmp stage
	
times (510 - ($ - $$)) db 0
db 0x55, 0xAA



stage:




;=================profile======================
mov ebx,0xB84C4		;	 		|
	mov esi,ebx
%include "borders.asm"


	
	
	
	
	
	
	
	
	
	
	xor ecx,ecx
	
	
	
%include "time and score.asm"	

	
	
	
	;;;;;;;;;;;;;printing and moving shapes;;;;;;;;;
	xor edx,edx
	delaylp1:
	inc edx
	cmp edx,220500000
	jne delaylp1
		;;;;;;end of delay;;;;;

		
%include "random.asm"
	
	;===================block next shape==================
	BS:
	
	mov byte[ebx],0x20;
	mov byte[ebx+2],0x20;
	mov byte[ebx+160],0x20;
	mov byte[ebx+162],0x20;
	mov byte[ebx+164],0x20;
	mov byte[ebx+320],0x20;
	
	mov byte[ebx],0xDB;		
	mov byte[ebx+2],0xDB;
	jmp cont

	;===============L next shape==========
	LS:
	
	mov byte[ebx],0x20;
	mov byte[ebx+2],0x20;
	mov byte[ebx+160],0x20;
	mov byte[ebx+162],0x20;
	mov byte[ebx+164],0x20;
	mov byte[ebx+320],0x20;
	
	mov byte[ebx],0xDB;
	mov byte[ebx+160],0xDB;
	mov byte[ebx+162],0xDB;
	jmp cont
	;=============z next shape============
	ZS:
	
	mov byte[ebx],0x20;
	mov byte[ebx+2],0x20;
	mov byte[ebx+160],0x20;
	mov byte[ebx+162],0x20;
	mov byte[ebx+164],0x20;
	mov byte[ebx+320],0x20;
	
	mov byte[ebx],0xDB;			
	mov byte[ebx+2],0xDB;		
	mov byte[ebx+162],0xDB;		
	mov byte[ebx+164],0xDB;
	jmp cont
	;================I shape===============
	IS:
	
	mov byte[ebx],0x20;
	mov byte[ebx+2],0x20;
	mov byte[ebx+160],0x20;
	mov byte[ebx+162],0x20;
	mov byte[ebx+164],0x20;
	mov byte[ebx+320],0x20;
	
	mov byte[ebx],0xDB;
	mov byte[ebx+160],0xDB;
	mov byte[ebx+320],0xDB;
	
	jmp cont
	
	;=========================end of random shape=============
		
		
	;;;;;;;SQUARE;;;;;;;;;
	lps:
	mov cl,[ebx]
	cmp cl,0xDB    ;   check area for blocks before putting blocks
	je endy	   ;
	mov cl,[ebx+2] ;
	cmp cl,0xDB    ;
	je endy        ;
	mov byte [ebx],0xDB
	mov byte [ebx+2],0xDB
	xor edx,edx
	delaylp2:
	xor eax,eax   ;
	in al, 0x64;
	and al, 1;
	jnz keypressedsquare
	continue_square:
	
	inc edx
	cmp edx,10500000
	jne delaylp2
		;;;;;;end of delay;;;;;
	







   ;;;;;;;;;;;;;;timer loop;;;;;;;;;;;;;;;;	
	timer_loops:
	mov ecx,dword[counter]
	cmp ecx,9
	je next2s
	mov al,byte[a]
	add al,0x01
	mov byte[esi+22],al
	inc ecx
	mov dword[counter],ecx
	mov byte[a],al
	jmp checks
	next2s:
	mov eax,dword[count1]
	inc eax
	mov dword[count1],eax
	cmp eax,6
	je next3s
	xor ecx,ecx
	mov dword[counter],ecx
	mov byte[a],0x30
	mov al,byte[a]
	mov byte[esi+22],al
	mov al,byte[b]
	add al,0x01
	mov byte[esi+20],al
	mov byte[b],al
	jmp checks
	
	next3s:
	mov byte[esi+22],0x30
	mov byte[esi+20],0x30
	mov eax,dword[count2]
	cmp eax,9
	je next4s
	inc eax
	mov dword[count2],eax
	xor ecx,ecx
	mov dword[counter],ecx
	mov dword[count1],ecx
	mov byte[a],0x30
	mov byte[b],0x30
	mov al,byte[c]
	add al,0x01
	mov byte[esi+16],al
	mov byte[c],al
	jmp checks
	
	next4s:
	mov byte[esi+22],0x30
	mov byte[esi+20],0x30
	mov byte[esi+16],0x30
	mov eax,dword[count3]
	cmp eax,9
	je end_timers
	inc eax
	mov dword[count3],eax
	xor ecx,ecx
	mov dword[counter],ecx
	mov dword[count1],ecx
	mov dword[count2],ecx
	mov byte[a],0x30
	mov byte[b],0x30
	mov byte[c],0x30
	mov al,byte[d]
	add al,0x01
	mov byte[esi+14],al
	mov byte[d],al
	jmp checks
	end_timers:
	mov byte[a],0x30
	mov byte[b],0x30
	mov byte[c],0x30
	mov byte[d],0x30
	mov dword[counter],0x00
	mov dword[count1],0x00
	mov dword[count2],0x00
	mov dword[count3],0x00
	jmp checks
  ;;;;;;;;;;;;;;end of timer loop;;;;;;;;;;;	
	
	
		
	checks:
	mov edx,ebx
	add edx,160
	cmp edx,0xB8F58       ;    ckeck below area if it is the bottom
	jg scan_rows
	mov cl,[edx]
	cmp cl,0xDB    ;   check below area for blocks before moving shape
	je scan_rows		   ;
	mov cl,[edx+2] ;
	cmp cl,0xDB    ;
	je scan_rows        ;
	mov byte [ebx],0xFF		   ;   deleting shape before putting it below (moving)
	mov byte [ebx+2],0xFF      ;
	add ebx,160                ;   add to put it below
	jmp lps
;;;;;;;;end of SQUARE;;;;;;;;;;
;;;;;;;;Z shape;;;;;
	lpz:
	mov cl,[ebx]
	cmp cl,0xDB    ;   check area for blocks before putting blocks
	je endy	   ;
	mov cl,[ebx+2] ;
	cmp cl,0xDB    ;
	je endy        ;
	mov cl,[ebx+162] ;
	cmp cl,0xDB    ;
	je endy        ;
	mov cl,[ebx+164] ;
	cmp cl,0xDB    ;
	je endy        ;
	mov byte [ebx],0xDB
	mov byte [ebx+2],0xDB
	mov byte [ebx+162],0xDB
	mov byte [ebx+164],0xDB
	;		;;;;;;delay;;;;
	xor edx,edx
	delaylp3:
	xor eax,eax   ; 
	in al, 0x64;
	and al, 1;
	jnz keypressedz
	continue_z:
	inc edx
	cmp edx,10500000
	jne delaylp3
		;;;;;;end of delay;;;;;
	;;;;;;;;;;;;;;timer loop;;;;;;;;;;;;;;;;	
	timer_loopz:
	mov ecx,dword[counter]
	cmp ecx,9
	je next2z
	mov al,byte[a]
	add al,0x01
	mov byte[esi+22],al
	inc ecx
	mov dword[counter],ecx
	mov byte[a],al
	jmp checkz
	next2z:
	mov eax,dword[count1]
	inc eax
	mov dword[count1],eax
	cmp eax,6
	je next3z
	xor ecx,ecx
	mov dword[counter],ecx
	mov byte[a],0x30
	mov al,byte[a]
	mov byte[esi+22],al
	mov al,byte[b]
	add al,0x01
	mov byte[esi+20],al
	mov byte[b],al
	jmp checkz
	
	next3z:
	mov byte[esi+22],0x30
	mov byte[esi+20],0x30
	mov eax,dword[count2]
	cmp eax,9
	je next4z
	inc eax
	mov dword[count2],eax
	xor ecx,ecx
	mov dword[counter],ecx
	mov dword[count1],ecx
	mov byte[a],0x30
	mov byte[b],0x30
	mov al,byte[c]
	add al,0x01
	mov byte[esi+16],al
	mov byte[c],al
	jmp checkz
	
	next4z:
	mov byte[esi+22],0x30
	mov byte[esi+20],0x30
	mov byte[esi+16],0x30
	mov eax,dword[count3]
	cmp eax,9
	je end_timerz
	inc eax
	mov dword[count3],eax
	xor ecx,ecx
	mov dword[counter],ecx
	mov dword[count1],ecx
	mov dword[count2],ecx
	mov byte[a],0x30
	mov byte[b],0x30
	mov byte[c],0x30
	mov al,byte[d]
	add al,0x01
	mov byte[esi+14],al
	mov byte[d],al
	jmp checkz
	end_timerz:
	mov byte[a],0x30
	mov byte[b],0x30
	mov byte[c],0x30
	mov byte[d],0x30
	mov dword[counter],0x00
	mov dword[count1],0x00
	mov dword[count2],0x00
	mov dword[count3],0x00
	jmp checkz
  ;;;;;;;;;;;;;;end of timer loop;;;;;;;;;;;
	checkz:
	mov edx,ebx
	add edx,320
	cmp edx,0xB8F58       ;    check below area if it is the bottom
	jg scan_rows
	mov cl,[edx-160]
	cmp cl,0xDB    ;   check below area for blocks before moving shape
	je scan_rows	;
	mov cl,[edx+2] ;
	cmp cl,0xDB    ;
	je scan_rows		   ;
	mov cl,[edx+4] ;
	cmp cl,0xDB    ;
	je scan_rows        ;
	mov byte [ebx],0xFF		   ;   deleting shape before putting it below (moving)
	mov byte [ebx+2],0xFF      ;
	mov byte [ebx+162],0xFF      ;
	mov byte [ebx+164],0xFF      ;
	add ebx,160                ;   add to put it below
	jmp lpz
;;;;;;;;end of Z shape;;;;;
;;;;;;;; rotated Z shape;;;;;
	lprz:
	mov cl,[ebx]
	cmp cl,0xDB    ;   check area for blocks before putting blocks
	je endy	   ;
	mov cl,[ebx+158] ;
	cmp cl,0xDB    ;
	je endy        ;
	mov cl,[ebx+160] ;
	cmp cl,0xDB    ;
	je endy        ;
	mov cl,[ebx+318] ;
	cmp cl,0xDB    ;
	je endy        ;
	mov byte [ebx],0xDB
	mov byte [ebx+158],0xDB
	mov byte [ebx+160],0xDB
	mov byte [ebx+318],0xDB
	xor edx,edx
	delaylprz3:
	xor eax,eax   
	in al, 0x64;
	and al, 1;
	jnz keypressedrz
	continue_rz:
	inc edx
	cmp edx,10500000
	jne delaylprz3
		;;;;;;end of delay;;;;;
	;;;;;;;;;;;;;;timer loop;;;;;;;;;;;;;;;;	
	timer_looprz:
	mov ecx,dword[counter]
	cmp ecx,9
	je next2rz
	mov al,byte[a]
	add al,0x01
	mov byte[esi+22],al
	inc ecx
	mov dword[counter],ecx
	mov byte[a],al
	jmp checkrz
	next2rz:
	mov eax,dword[count1]
	inc eax
	mov dword[count1],eax
	cmp eax,6
	je next3rz
	xor ecx,ecx
	mov dword[counter],ecx
	mov byte[a],0x30
	mov al,byte[a]
	mov byte[esi+22],al
	mov al,byte[b]
	add al,0x01
	mov byte[esi+20],al
	mov byte[b],al
	jmp checkrz
	
	next3rz:
	mov byte[esi+22],0x30
	mov byte[esi+20],0x30
	mov eax,dword[count2]
	cmp eax,9
	je next4rz
	inc eax
	mov dword[count2],eax
	xor ecx,ecx
	mov dword[counter],ecx
	mov dword[count1],ecx
	mov byte[a],0x30
	mov byte[b],0x30
	mov al,byte[c]
	add al,0x01
	mov byte[esi+16],al
	mov byte[c],al
	jmp checkrz
	
	next4rz:
	mov byte[esi+22],0x30
	mov byte[esi+20],0x30
	mov byte[esi+16],0x30
	mov eax,dword[count3]
	cmp eax,9
	je end_timerrz
	inc eax
	mov dword[count3],eax
	xor ecx,ecx
	mov dword[counter],ecx
	mov dword[count1],ecx
	mov dword[count2],ecx
	mov byte[a],0x30
	mov byte[b],0x30
	mov byte[c],0x30
	mov al,byte[d]
	add al,0x01
	mov byte[esi+14],al
	mov byte[d],al
	jmp checkrz
	end_timerrz:
	mov byte[a],0x30
	mov byte[b],0x30
	mov byte[c],0x30
	mov byte[d],0x30
	mov dword[counter],0x00
	mov dword[count1],0x00
	mov dword[count2],0x00
	mov dword[count3],0x00
	jmp checkrz
  ;;;;;;;;;;;;;;end of timer loop;;;;;;;;;;;
	checkrz:
	mov edx,ebx
	add edx,480
	cmp edx,0xB8F58       ;    check below area if it is the bottom
	jg scan_rows
	mov cl,[edx-160]
	cmp cl,0xDB    ;   check below area for blocks before moving shape
	je scan_rows	;
	mov cl,[edx-2] ;
	cmp cl,0xDB    ;
	je scan_rows		   ;
	mov byte [ebx],0xFF		   ;   deleting shape before putting it below (moving)
	mov byte [ebx+158],0xFF      ;
	mov byte [ebx+160],0xFF      ;
	mov byte [ebx+318],0xFF      ;
	add ebx,160                ;   add to put it below
	jmp lprz
;;;;;;;;end of rotated Z shape;;;;;
	;;;;;;;l shape;;;;;;;;;
	lpl:
	mov cl,[ebx]
	cmp cl,0xDB    ;   check area for blocks before putting blocks
	je endy	   ;
	mov cl,[ebx+160] ;
	cmp cl,0xDB    ;
	je endy        ;
	mov cl,[ebx+320] ;
	cmp cl,0xDB    ;
	je endy        ;
	mov byte [ebx],0xDB
	mov byte [ebx+160],0xDB
	mov byte [ebx+320],0xDB
		;;;;;;delay;;;;
	xor edx,edx
	delaylp4:
	xor eax,eax   ;
	in al, 0x64;
	and al, 1;
	jnz keypressedl
	continue_l:
	inc edx
	cmp edx,10500000
	jne delaylp4
		;;;;;;end of delay;;;;;
	;;;;;;;;;;;;;;timer loop;;;;;;;;;;;;;;;;	
	timer_loopl:
	mov ecx,dword[counter]
	cmp ecx,9
	je next2l
	mov al,byte[a]
	add al,0x01
	mov byte[esi+22],al
	inc ecx
	mov dword[counter],ecx
	mov byte[a],al
	jmp checkl
	next2l:
	mov eax,dword[count1]
	inc eax
	mov dword[count1],eax
	cmp eax,6
	je next3l
	xor ecx,ecx
	mov dword[counter],ecx
	mov byte[a],0x30
	mov al,byte[a]
	mov byte[esi+22],al
	mov al,byte[b]
	add al,0x01
	mov byte[esi+20],al
	mov byte[b],al
	jmp checkl
	
	next3l:
	mov byte[esi+22],0x30
	mov byte[esi+20],0x30
	mov eax,dword[count2]
	cmp eax,9
	je next4l
	inc eax
	mov dword[count2],eax
	xor ecx,ecx
	mov dword[counter],ecx
	mov dword[count1],ecx
	mov byte[a],0x30
	mov byte[b],0x30
	mov al,byte[c]
	add al,0x01
	mov byte[esi+16],al
	mov byte[c],al
	jmp checkl
	
	next4l:
	mov byte[esi+22],0x30
	mov byte[esi+20],0x30
	mov byte[esi+16],0x30
	mov eax,dword[count3]
	cmp eax,9
	je end_timerl
	inc eax
	mov dword[count3],eax
	xor ecx,ecx
	mov dword[counter],ecx
	mov dword[count1],ecx
	mov dword[count2],ecx
	mov byte[a],0x30
	mov byte[b],0x30
	mov byte[c],0x30
	mov al,byte[d]
	add al,0x01
	mov byte[esi+14],al
	mov byte[d],al
	jmp checkl
	end_timerl:
	mov byte[a],0x30
	mov byte[b],0x30
	mov byte[c],0x30
	mov byte[d],0x30
	mov dword[counter],0x00
	mov dword[count1],0x00
	mov dword[count2],0x00
	mov dword[count3],0x00
	jmp checkl
  ;;;;;;;;;;;;;;end of timer loop;;;;;;;;;;;
	checkl:
	mov edx,ebx
	add edx,480
	cmp edx,0xB8F58       ;    ckeck below area if it is the bottom
	jg scan_rows
	mov cl,[edx]
	cmp cl,0xDB    ;   check below area for blocks before moving shape
	je scan_rows		   ;
	mov byte [ebx],0xFF		   ;   deleting shape before putting it below (moving)
	mov byte [ebx+160],0xFF      ;
	mov byte [ebx+320],0xFF      ;
	add ebx,160                ;   add to put it below
	jmp lpl
;;;;;;;;end of l shape;;;;;;;;;;
	;;;;;;;rotated l shape;;;;;;;;;
	lprl:
	mov cl,[ebx]
	cmp cl,0xDB    ;   check area for blocks before putting blocks
	je endy	   ;
	mov cl,[ebx+2] ;
	cmp cl,0xDB    ;
	je endy        ;
	mov cl,[ebx+4] ;
	cmp cl,0xDB    ;
	je endy        ;
	mov byte [ebx],0xDB
	mov byte [ebx+2],0xDB
	mov byte [ebx+4],0xDB
		;;;;;;delay;;;;
	xor edx,edx
	delaylprl4:
	xor eax,eax   ;
	in al, 0x64;
	and al, 1;
	jnz keypressedrl
	continue_rl:
	inc edx
	cmp edx,10500000
	jne delaylprl4
		;;;;;;end of delay;;;;;
	;;;;;;;;;;;;;;timer loop;;;;;;;;;;;;;;;;	
	timer_looprl:
	mov ecx,dword[counter]
	cmp ecx,9
	je next2rl
	mov al,byte[a]
	add al,0x01
	mov byte[esi+22],al
	inc ecx
	mov dword[counter],ecx
	mov byte[a],al
	jmp checkrl
	next2rl:
	mov eax,dword[count1]
	inc eax
	mov dword[count1],eax
	cmp eax,6
	je next3rl
	xor ecx,ecx
	mov dword[counter],ecx
	mov byte[a],0x30
	mov al,byte[a]
	mov byte[esi+22],al
	mov al,byte[b]
	add al,0x01
	mov byte[esi+20],al
	mov byte[b],al
	jmp checkrl
	
	next3rl:
	mov byte[esi+22],0x30
	mov byte[esi+20],0x30
	mov eax,dword[count2]
	cmp eax,9
	je next4rl
	inc eax
	mov dword[count2],eax
	xor ecx,ecx
	mov dword[counter],ecx
	mov dword[count1],ecx
	mov byte[a],0x30
	mov byte[b],0x30
	mov al,byte[c]
	add al,0x01
	mov byte[esi+16],al
	mov byte[c],al
	jmp checkrl
	
	next4rl:
	mov byte[esi+22],0x30
	mov byte[esi+20],0x30
	mov byte[esi+16],0x30
	mov eax,dword[count3]
	cmp eax,9
	je end_timerrl
	inc eax
	mov dword[count3],eax
	xor ecx,ecx
	mov dword[counter],ecx
	mov dword[count1],ecx
	mov dword[count2],ecx
	mov byte[a],0x30
	mov byte[b],0x30
	mov byte[c],0x30
	mov al,byte[d]
	add al,0x01
	mov byte[esi+14],al
	mov byte[d],al
	jmp checkrl
	end_timerrl:
	mov byte[a],0x30
	mov byte[b],0x30
	mov byte[c],0x30
	mov byte[d],0x30
	mov dword[counter],0x00
	mov dword[count1],0x00
	mov dword[count2],0x00
	mov dword[count3],0x00
	jmp checkrl
  ;;;;;;;;;;;;;;end of timer loop;;;;;;;;;;;
	checkrl:
	mov edx,ebx
	add edx,160
	cmp edx,0xB8F58       ;    ckeck below area if it is the bottom
	jg scan_rows
	mov cl,[edx]
	cmp cl,0xDB    ;   check below area for blocks before moving shape
	je scan_rows   ;
	mov cl,[edx+2]   ;
	cmp cl,0xDB    ;
	je scan_rows   ;
    mov cl,[edx+4]   ;
	cmp cl,0xDB    ;
	je scan_rows   ;
	mov byte [ebx],0xFF		   ;   deleting shape before putting it below (moving)
	mov byte [ebx+2],0xFF      ;
	mov byte [ebx+4],0xFF      ;
	add ebx,160                ;   add to put it below
	jmp lprl
;;;;;;;;end of rotated l shape;;;;;;;;;;
	;;;;;;;x (will print L shape);;;;;;;;;
	lpx:
	mov cl,[ebx]
	cmp cl,0xDB    ;   check area for blocks before putting blocks
	je endy	   ;
	mov cl,[ebx+160] ;
	cmp cl,0xDB    ;
	je endy        ;
	mov cl,[ebx+162] ;
	cmp cl,0xDB    ;
	je endy        ;
	mov byte [ebx],0xDB
	mov byte [ebx+160],0xDB
	mov byte [ebx+162],0xDB
		;;;;;;delay;;;;
	xor edx,edx
	delaylp5:
	xor eax,eax   ;
	in al, 0x64;
	and al, 1;
	jnz keypressedx
	continue_x:
	inc edx
	cmp edx,10500000
	jne delaylp5
		;;;;;;end of delay;;;;;
	;;;;;;;;;;;;;;timer loop;;;;;;;;;;;;;;;;	
	timer_loopx:
	mov ecx,dword[counter]
	cmp ecx,9
	je next2x
	mov al,byte[a]
	add al,0x01
	mov byte[esi+22],al
	inc ecx
	mov dword[counter],ecx
	mov byte[a],al
	jmp checkx
	next2x:
	mov eax,dword[count1]
	inc eax
	mov dword[count1],eax
	cmp eax,6
	je next3x
	xor ecx,ecx
	mov dword[counter],ecx
	mov byte[a],0x30
	mov al,byte[a]
	mov byte[esi+22],al
	mov al,byte[b]
	add al,0x01
	mov byte[esi+20],al
	mov byte[b],al
	jmp checkx
	
	next3x:
	mov byte[esi+22],0x30
	mov byte[esi+20],0x30
	mov eax,dword[count2]
	cmp eax,9
	je next4x
	inc eax
	mov dword[count2],eax
	xor ecx,ecx
	mov dword[counter],ecx
	mov dword[count1],ecx
	mov byte[a],0x30
	mov byte[b],0x30
	mov al,byte[c]
	add al,0x01
	mov byte[esi+16],al
	mov byte[c],al
	jmp checkx
	
	next4x:
	mov byte[esi+22],0x30
	mov byte[esi+20],0x30
	mov byte[esi+16],0x30
	mov eax,dword[count3]
	cmp eax,9
	je end_timerx
	inc eax
	mov dword[count3],eax
	xor ecx,ecx
	mov dword[counter],ecx
	mov dword[count1],ecx
	mov dword[count2],ecx
	mov byte[a],0x30
	mov byte[b],0x30
	mov byte[c],0x30
	mov al,byte[d]
	add al,0x01
	mov byte[esi+14],al
	mov byte[d],al
	jmp checkx
	end_timerx:
	mov byte[a],0x30
	mov byte[b],0x30
	mov byte[c],0x30
	mov byte[d],0x30
	mov dword[counter],0x00
	mov dword[count1],0x00
	mov dword[count2],0x00
	mov dword[count3],0x00
	jmp checkx
  ;;;;;;;;;;;;;;end of timer loop;;;;;;;;;;;
	checkx:
	mov edx,ebx
	add edx,320
	cmp edx,0xB8F58       ;    ckeck below area if it is the bottom
	jg scan_rows
	mov cl,[edx]
	cmp cl,0xDB    ;   check below area for blocks before moving shape
	je scan_rows ;
	mov cl,[edx+2] ;
	cmp cl,0xDB    ;
	je scan_rows ;
	mov byte [ebx],0xFF		   ;   deleting shape before putting it below (moving)
	mov byte [ebx+160],0xFF      ;
	mov byte [ebx+162],0xFF      ;
	add ebx,160                ;   add to put it below
	jmp lpx
;;;;;;;;end of x (will print L shape);;;;;;;;;;
;;;;;;;rotated x;;;;;;;;;
	lpr1x:
	mov cl,[ebx]
	cmp cl,0xDB    ;   check area for blocks before putting blocks
	je endy	   ;
	mov cl,[ebx+2] ;
	cmp cl,0xDB    ;
	je endy        ;
	mov cl,[ebx+160] ;
	cmp cl,0xDB    ;
	je endy        ;
	mov byte [ebx],0xDB
	mov byte [ebx+2],0xDB
	mov byte [ebx+160],0xDB
		;;;;;;delay;;;;
	xor edx,edx
	delaylpr15:
	xor eax,eax
	in al, 0x64;
	and al, 1;
	jnz keypressedr1x
	continue_r1x:
	inc edx
	cmp edx,10500000
	jne delaylpr15
		;;;;;;end of delay;;;;;
	;;;;;;;;;;;;;;timer loop;;;;;;;;;;;;;;;;	
	timer_loopr1x:
	mov ecx,dword[counter]
	cmp ecx,9
	je next2r1x
	mov al,byte[a]
	add al,0x01
	mov byte[esi+22],al
	inc ecx
	mov dword[counter],ecx
	mov byte[a],al
	jmp checkr1x
	next2r1x:
	mov eax,dword[count1]
	inc eax
	mov dword[count1],eax
	cmp eax,6
	je next3r1x
	xor ecx,ecx
	mov dword[counter],ecx
	mov byte[a],0x30
	mov al,byte[a]
	mov byte[esi+22],al
	mov al,byte[b]
	add al,0x01
	mov byte[esi+20],al
	mov byte[b],al
	jmp checkr1x
	
	next3r1x:
	mov byte[esi+22],0x30
	mov byte[esi+20],0x30
	mov eax,dword[count2]
	cmp eax,9
	je next4r1x
	inc eax
	mov dword[count2],eax
	xor ecx,ecx
	mov dword[counter],ecx
	mov dword[count1],ecx
	mov byte[a],0x30
	mov byte[b],0x30
	mov al,byte[c]
	add al,0x01
	mov byte[esi+16],al
	mov byte[c],al
	jmp checkr1x
	
	next4r1x:
	mov byte[esi+22],0x30
	mov byte[esi+20],0x30
	mov byte[esi+16],0x30
	mov eax,dword[count3]
	cmp eax,9
	je end_timerr1x
	inc eax
	mov dword[count3],eax
	xor ecx,ecx
	mov dword[counter],ecx
	mov dword[count1],ecx
	mov dword[count2],ecx
	mov byte[a],0x30
	mov byte[b],0x30
	mov byte[c],0x30
	mov al,byte[d]
	add al,0x01
	mov byte[esi+14],al
	mov byte[d],al
	jmp checkx
	end_timerr1x:
	mov byte[a],0x30
	mov byte[b],0x30
	mov byte[c],0x30
	mov byte[d],0x30
	mov dword[counter],0x00
	mov dword[count1],0x00
	mov dword[count2],0x00
	mov dword[count3],0x00
	jmp checkr1x
  ;;;;;;;;;;;;;;end of timer loop;;;;;;;;;;;
	checkr1x:
	mov edx,ebx
	add edx,320
	cmp edx,0xB8F58       ;    ckeck below area if it is the bottom
	jg scan_rows
	mov cl,[edx]
	cmp cl,0xDB    ;   check below area for blocks before moving shape
	je scan_rows ;
	mov cl,[edx-158] ;
	cmp cl,0xDB    ;
	je scan_rows ;
	mov byte [ebx],0xFF		   ;   deleting shape before putting it below (moving)
	mov byte [ebx+2],0xFF      ;
	mov byte [ebx+160],0xFF      ;
	add ebx,160                ;   add to put it below
	jmp lpr1x
;;;;;;;;end of rotated x;;;;;;;;;;
;;;;;;;double rotated x;;;;;;;;;
	lpr2x:
	mov cl,[ebx]
	cmp cl,0xDB    ;   check area for blocks before putting blocks
	je endy	   ;
	mov cl,[ebx+2] ;
	cmp cl,0xDB    ;
	je endy        ;
	mov cl,[ebx+162] ;
	cmp cl,0xDB    ;
	je endy        ;
	mov byte [ebx],0xDB
	mov byte [ebx+2],0xDB
	mov byte [ebx+162],0xDB
		;;;;;;delay;;;;
	xor edx,edx
	delaylpr25:
	xor eax,eax   ;
	in al, 0x64;
	and al, 1;
	jnz keypressedr2x
	continue_r2x:
	inc edx
	cmp edx,10500000
	jne delaylpr25
		;;;;;;end of delay;;;;;
	;;;;;;;;;;;;;;timer loop;;;;;;;;;;;;;;;;	
	timer_loopr2x:
	mov ecx,dword[counter]
	cmp ecx,9
	je next2r2x
	mov al,byte[a]
	add al,0x01
	mov byte[esi+22],al
	inc ecx
	mov dword[counter],ecx
	mov byte[a],al
	jmp checkr2x
	next2r2x:
	mov eax,dword[count1]
	inc eax
	mov dword[count1],eax
	cmp eax,6
	je next3r2x
	xor ecx,ecx
	mov dword[counter],ecx
	mov byte[a],0x30
	mov al,byte[a]
	mov byte[esi+22],al
	mov al,byte[b]
	add al,0x01
	mov byte[esi+20],al
	mov byte[b],al
	jmp checkr2x
	
	next3r2x:
	mov byte[esi+22],0x30
	mov byte[esi+20],0x30
	mov eax,dword[count2]
	cmp eax,9
	je next4r2x
	inc eax
	mov dword[count2],eax
	xor ecx,ecx
	mov dword[counter],ecx
	mov dword[count1],ecx
	mov byte[a],0x30
	mov byte[b],0x30
	mov al,byte[c]
	add al,0x01
	mov byte[esi+16],al
	mov byte[c],al
	jmp checkr2x
	
	next4r2x:
	mov byte[esi+22],0x30
	mov byte[esi+20],0x30
	mov byte[esi+16],0x30
	mov eax,dword[count3]
	cmp eax,9
	je end_timerr2x
	inc eax
	mov dword[count3],eax
	xor ecx,ecx
	mov dword[counter],ecx
	mov dword[count1],ecx
	mov dword[count2],ecx
	mov byte[a],0x30
	mov byte[b],0x30
	mov byte[c],0x30
	mov al,byte[d]
	add al,0x01
	mov byte[esi+14],al
	mov byte[d],al
	jmp checkx
	end_timerr2x:
	mov byte[a],0x30
	mov byte[b],0x30
	mov byte[c],0x30
	mov byte[d],0x30
	mov dword[counter],0x00
	mov dword[count1],0x00
	mov dword[count2],0x00
	mov dword[count3],0x00
	jmp checkr2x
  ;;;;;;;;;;;;;;end of timer loop;;;;;;;;;;;
	checkr2x:
	mov edx,ebx
	add edx,320
	cmp edx,0xB8F58       ;    ckeck below area if it is the bottom
	jg scan_rows
	mov cl,[edx-160]
	cmp cl,0xDB    ;   check below area for blocks before moving shape
	je scan_rows ;
	mov cl,[edx+2] ;
	cmp cl,0xDB    ;
	je scan_rows ;
	mov byte [ebx],0xFF		   ;   deleting shape before putting it below (moving)
	mov byte [ebx+2],0xFF      ;
	mov byte [ebx+162],0xFF      ;
	add ebx,160                ;   add to put it below
	jmp lpr2x
;;;;;;;;end of double rotated x;;;;;;;;;;
;;;;;;;triple rotated x;;;;;;;;;
	lpr3x:
	mov cl,[ebx]
	cmp cl,0xDB    ;   check area for blocks before putting blocks
	je endy	   ;
	mov cl,[ebx+158] ;
	cmp cl,0xDB    ;
	je endy        ;
	mov cl,[ebx+160] ;
	cmp cl,0xDB    ;
	je endy        ;
	mov byte [ebx],0xDB
	mov byte [ebx+158],0xDB
	mov byte [ebx+160],0xDB
		;;;;;;delay;;;;
	xor edx,edx
	delaylpr35:
	xor eax,eax
	in al, 0x64;
	and al, 1;
	jnz keypressedr3x
	continue_r3x:
	inc edx
	cmp edx,10500000
	jne delaylpr35
		;;;;;;end of delay;;;;;
	;;;;;;;;;;;;;;timer loop;;;;;;;;;;;;;;;;	
	timer_loopr3x:
	mov ecx,dword[counter]
	cmp ecx,9
	je next2r3x
	mov al,byte[a]
	add al,0x01
	mov byte[esi+22],al
	inc ecx
	mov dword[counter],ecx
	mov byte[a],al
	jmp checkr3x
	next2r3x:
	mov eax,dword[count1]
	inc eax
	mov dword[count1],eax
	cmp eax,6
	je next3r3x
	xor ecx,ecx
	mov dword[counter],ecx
	mov byte[a],0x30
	mov al,byte[a]
	mov byte[esi+22],al
	mov al,byte[b]
	add al,0x01
	mov byte[esi+20],al
	mov byte[b],al
	jmp checkr3x
	
	next3r3x:
	mov byte[esi+22],0x30
	mov byte[esi+20],0x30
	mov eax,dword[count2]
	cmp eax,9
	je next4r3x
	inc eax
	mov dword[count2],eax
	xor ecx,ecx
	mov dword[counter],ecx
	mov dword[count1],ecx
	mov byte[a],0x30
	mov byte[b],0x30
	mov al,byte[c]
	add al,0x01
	mov byte[esi+16],al
	mov byte[c],al
	jmp checkr3x
	
	next4r3x:
	mov byte[esi+22],0x30
	mov byte[esi+20],0x30
	mov byte[esi+16],0x30
	mov eax,dword[count3]
	cmp eax,9
	je end_timerr3x
	inc eax
	mov dword[count3],eax
	xor ecx,ecx
	mov dword[counter],ecx
	mov dword[count1],ecx
	mov dword[count2],ecx
	mov byte[a],0x30
	mov byte[b],0x30
	mov byte[c],0x30
	mov al,byte[d]
	add al,0x01
	mov byte[esi+14],al
	mov byte[d],al
	jmp checkx
	end_timerr3x:
	mov byte[a],0x30
	mov byte[b],0x30
	mov byte[c],0x30
	mov byte[d],0x30
	mov dword[counter],0x00
	mov dword[count1],0x00
	mov dword[count2],0x00
	mov dword[count3],0x00
	jmp checkr3x
  ;;;;;;;;;;;;;;end of timer loop;;;;;;;;;;;
	checkr3x:
	mov edx,ebx
	add edx,320
	cmp edx,0xB8F58       ;    ckeck below area if it is the bottom
	jg scan_rows
	mov cl,[edx-2]
	cmp cl,0xDB    ;   check below area for blocks before moving shape
	je scan_rows ;
	mov cl,[edx] ;
	cmp cl,0xDB    ;
	je scan_rows ;
	mov byte [ebx],0xFF		   ;   deleting shape before putting it below (moving)
	mov byte [ebx+158],0xFF      ;
	mov byte [ebx+160],0xFF      ;
	add ebx,160                ;   add to put it below
	jmp lpr3x
;;;;;;;;end of triple rotated x;;;;;;;;;;







	endy:
	mov ebx,0xB8000
	add ebx,176
	call del1
	
	mov byte[ebx+160],0xDB;		|
	mov byte[ebx+320],0xDB;		|
	mov byte[ebx+480],0xDB;		|
	call del1
	mov byte[ebx+2],0xDC;		|
	mov byte[ebx+4],0xDC;		|       G
	mov byte[ebx+6],0xDC;		|
	call del1
	mov byte[ebx+642],0xDF;		|
	mov byte[ebx+644],0xDF;		|
	mov byte[ebx+646],0xDF;		|
	mov byte[ebx+486],0xDB;		|
	call del1
	;---------------------------
	add ebx,10
	mov byte[ebx+640],0xDF;
	mov byte[ebx+482],0xDB;
	mov byte[ebx+324],0xDB;
	mov byte[ebx+166],0xDB;
	call del1
	mov byte[ebx+8],0xDC;                A
	mov byte[ebx+170],0xDB;
	mov byte[ebx+332],0xDB;
	mov byte[ebx+494],0xDB;
	mov byte[ebx+656],0xDF;
	mov byte[ebx+326],0xDC;
	mov byte[ebx+328],0xDC;
	mov byte[ebx+330],0xDC;
	call del1
	;------------------------------
	add ebx,20
	mov byte[ebx],0xDC;
	mov byte[ebx+160],0xDB;
	mov byte[ebx+320],0xDB;
	mov byte[ebx+480],0xDB;
	mov byte[ebx+640],0xDF;
	call del1
	mov byte[ebx+2],0xDC;
	mov byte[ebx+164],0xDB;
	mov byte[ebx+326],0xDB;
	mov byte[ebx+488],0xDB;
	mov byte[ebx+650],0xDF;				M
	mov byte[ebx+492],0xDB;
	mov byte[ebx+334],0xDB;
	mov byte[ebx+176],0xDB;
	call del1
	mov byte[ebx+18],0xDC;
	mov byte[ebx+20],0xDC;
	mov byte[ebx+180],0xDB;
	mov byte[ebx+340],0xDB;
	mov byte[ebx+500],0xDB;
	mov byte[ebx+660],0xDF;
	call del1
	;-----------------------------------
	add ebx,24
	mov byte[ebx],0xDC;
	mov byte[ebx+160],0xDB;
	mov byte[ebx+320],0xDB;
	mov byte[ebx+480],0xDB;
	mov byte[ebx+640],0xDF;
	call del1
	mov byte[ebx+2],0xDC;				E
	mov byte[ebx+4],0xDC;
	mov byte[ebx+642],0xDF;
	mov byte[ebx+644],0xDF;
	mov byte[ebx+322],0xDB;
	mov byte[ebx+324],0xDB;
	call del1
	;--------------------------------
	
	add ebx,18
	
	mov byte[ebx+160],0xDB;
	mov byte[ebx+320],0xDB;
	mov byte[ebx+480],0xDB;
	call del1
	mov byte[ebx+2],0xDC;
	mov byte[ebx+642],0xDF;					O
	mov byte[ebx+4],0xDC;				
	mov byte[ebx+644],0xDF;
	call del1
	mov byte[ebx+166],0xDB;
	mov byte[ebx+326],0xDB;
	mov byte[ebx+486],0xDB;
	call del1
	;--------------------------------
	add ebx,10
	
    mov byte[ebx],0xDC;
	mov byte[ebx+162],0xDB;
	mov byte[ebx+324],0xDB;
	mov byte[ebx+486],0xDB;
	mov byte[ebx+648],0xDF;					V
	call del1
	mov byte[ebx+490],0xDB;				
	mov byte[ebx+332],0xDB;
	mov byte[ebx+174],0xDB;				
	mov byte[ebx+16],0xDC;
	call del1
	;-------------------------------
	add ebx,20
	mov byte[ebx],0xDC;
	mov byte[ebx+160],0xDB;
	mov byte[ebx+320],0xDB;
	mov byte[ebx+480],0xDB;
	mov byte[ebx+640],0xDF;
	call del1
	mov byte[ebx+2],0xDC;				E
	mov byte[ebx+4],0xDC;
	mov byte[ebx+642],0xDF;
	mov byte[ebx+644],0xDF;
	mov byte[ebx+322],0xDB;
	mov byte[ebx+324],0xDB;
	call del1
	;-------------------------------
	add ebx,8
	mov byte[ebx],0xDC;
	mov byte[ebx+160],0xDB;
	mov byte[ebx+320],0xDB;
	mov byte[ebx+480],0xDB;				R
	mov byte[ebx+640],0xDF;
	call del1
	mov byte[ebx+2],0xDC;
	mov byte[ebx+4],0xDC;
	mov byte[ebx+166],0xDB;
	mov byte[ebx+322],0xDB;
	mov byte[ebx+324],0xDB;
	mov byte[ebx+486],0xDB;
	mov byte[ebx+648],0xDF;
	call del1
	;--------------------------
	;----------------------------
	mov ebx,0xB84C4		;		|
	mov byte[ebx],0x50;         |
	mov byte[ebx+2],0x52;       |
	mov byte[ebx+4],0x45;       |
	mov byte[ebx+6],0x53;       |
	mov byte[ebx+8],0x53;       |
	  ;                         |

;	mov byte[ebx+22],0x45;      |  "press r to play again"
;	mov byte[ebx+24],0x59;      |
	  ;                         |
	mov byte[ebx+12],0x52;
	
	mov byte[ebx+16],0x54;      |
	mov byte[ebx+18],0x4F;      |
	   ;                      |
	mov byte[ebx+22],0x50;      |
	mov byte[ebx+24],0x4C;      |
	mov byte[ebx+26],0x41;      |
	mov byte[ebx+28],0x59;      |
	;						|
	mov byte[ebx+32],0x41;      |
	mov byte[ebx+34],0x47;      |
	mov byte[ebx+36],0x41;      |
	mov byte[ebx+38],0x49;      |
	mov byte[ebx+40],0x4E;      |
	;-----------------------------
	add ebx,160
	mov byte[ebx],0x50;         |
	mov byte[ebx+2],0x52;       |
	mov byte[ebx+4],0x45;       |
	mov byte[ebx+6],0x53;       |
	mov byte[ebx+8],0x53;       |		"press q to quit"
	
	mov byte[ebx+12],0x51;      |
	
	mov byte[ebx+16],0x54;      |
	mov byte[ebx+18],0x4F;      |
	
	mov byte[ebx+22],0x51;      |
	mov byte[ebx+24],0x55;      |
	mov byte[ebx+26],0x49;      |
	mov byte[ebx+28],0x54;      |
	;-----------------------------
	ck_restart:
	in al, 0x60;
	cmp al,0x13
	je restart
	cmp al,0x10
	je quit
	jmp ck_restart
	
	restart:
	xor ecx,ecx
	mov ebx,0xB8000
	r_s:
	cmp ecx,4000
	je lll 
	mov byte[ebx+ecx],0xFF
	add ecx,1
	mov byte[ebx+ecx],0x07
	add ecx,1
	jmp r_s
	
	;------------------------
	lll:
	call del
	call del 
	jmp stage2
	
	ret
	
	
	
	
	del1:
	mov edx,0				;|
	inlop1:					;|
	inc edx					;|
	cmp edx,22000000		;| delay
	jne inlop1				;|
	ret						;|
	;;;;;;;;;;;;;end of printing and moving shapes;;;;;;
	
	;;;;;;;;;;;;;keys;;;;;;;;;;;;
	up_arrow_square:
	;mov bl , 0X55
	;jmp pressed;
    down_arrow_square:
	mov ecx,ebx
	add ecx,160
	cmp ecx,0xB8F58
	jg continue_square
	mov cl,[ebx+160]
	cmp cl,0xDB
	je continue_square
	mov cl,[ebx+162]
	cmp cl,0xDB
	je continue_square
	mov byte [ebx],0xFF
	mov byte [ebx+2],0xFF
	add ebx,160
	mov byte [ebx],0xDB
	mov byte [ebx+2],0xDB
	jmp continue_square

	right_arrow_square:
	mov ecx,ebx
	add ecx,4
	cmp ecx,0xB84BA
	je continue_square
	cmp ecx,0xB855A
	je continue_square
	cmp ecx,0xB85FA
	je continue_square
	cmp ecx,0xB869A
	je continue_square
	cmp ecx,0xB873A
	je continue_square
	cmp ecx,0xB87DA
	je continue_square
	cmp ecx,0xB887A
	je continue_square
	cmp ecx,0xB891A
	je continue_square
	cmp ecx,0xB89BA
	je continue_square
	cmp ecx,0xB8A5A
	je continue_square
	cmp ecx,0xB8AFA
	je continue_square
	cmp ecx,0xB8B9A
	je continue_square
	cmp ecx,0xB8C3A
	je continue_square
	cmp ecx,0xB8CDA
	je continue_square
	cmp ecx,0xB84BA
	je continue_square
	cmp ecx,0xB8D7A
	je continue_square
	cmp ecx,0xB8E1A
	je continue_square
	cmp ecx,0xB8EBA
	je continue_square
	mov cl,[ebx+4]
	cmp cl,0xDB
	je continue_square
	mov byte [ebx],0xFF
	mov byte [ebx+2],0xFF
	add ebx,2
	mov byte [ebx],0xDB
	mov byte [ebx+2],0xDB
	jmp continue_square
	
	
	left_arrow_square:
	mov ecx,ebx
	sub ecx,2
	cmp ecx,0xB84A4
	je continue_square
	cmp ecx,0xB8544
	je continue_square
	cmp ecx,0xB85E4
	je continue_square
	cmp ecx,0xB8684
	je continue_square
	cmp ecx,0xB8724
	je continue_square
	cmp ecx,0xB87C4
	je continue_square
	cmp ecx,0xB8864
	je continue_square
	cmp ecx,0xB8904
	je continue_square
	cmp ecx,0xB89A4
	je continue_square
	cmp ecx,0xB8A44
	je continue_square
	cmp ecx,0xB8AE4
	je continue_square
	cmp ecx,0xB8B84
	je continue_square
	cmp ecx,0xB8C24
	je continue_square
	cmp ecx,0xB8CC4
	je continue_square
	cmp ecx,0xB8D64
	je continue_square
	cmp ecx,0xB8E04
	je continue_square
	cmp ecx,0xB8EA4
	je continue_square
	cmp ecx,0xB8F44
	je continue_square
	mov cl,[ebx-2]
	cmp cl,0xDB
	je continue_square
	mov byte [ebx],0xFF
	mov byte [ebx+2],0xFF
	sub ebx,2
	mov byte [ebx],0xDB
	mov byte [ebx+2],0xDB
	jmp continue_square

	up_arrow_z:
	mov cl,[ebx-160]
	cmp cl,0xDB
	je continue_z
	mov cl,[ebx-158]
	cmp cl,0xDB
	je continue_z
	mov cl,[ebx-156]
	cmp cl,0xDB
	je continue_z
	mov cl,[ebx+4]
	cmp cl,0xDB
	je continue_z
	mov cl,[ebx+160]
	cmp cl,0xDB
	je continue_z
	mov cl,[ebx+322]
	cmp cl,0xDB
	je continue_z
	mov cl,[ebx+324]
	cmp cl,0xDB
	je continue_z
	mov byte [ebx],0xFF
	mov byte [ebx+2],0xFF
	mov byte [ebx+162],0xFF
	mov byte [ebx+164],0xFF
	sub ebx,156
	mov byte [ebx],0xDB
	mov byte [ebx+158],0xDB
	mov byte [ebx+160],0xDB
	mov byte [ebx+318],0xDB
	jmp continue_rz
	
	down_arrow_z:
	mov ecx,ebx
	add ecx,320
	cmp ecx,0xB8F58
	jg continue_z
	mov cl,[ebx+160]
	cmp cl,0xDB
	je continue_z
	mov cl,[ebx+322]
	cmp cl,0xDB
	je continue_z
	mov cl,[ebx+324]
	cmp cl,0xDB
	je continue_z
	mov byte [ebx],0xFF
	mov byte [ebx+2],0xFF
	mov byte [ebx+162],0xFF
	mov byte [ebx+164],0xFF
	add ebx,160
	mov byte [ebx],0xDB
	mov byte [ebx+2],0xDB
	mov byte [ebx+162],0xDB
	mov byte [ebx+164],0xDB
	jmp continue_z
	
	
	right_arrow_z:
	mov ecx,ebx
	add ecx,6
	cmp ecx,0xB84BA
	je continue_z
	cmp ecx,0xB855A
	je continue_z
	cmp ecx,0xB85FA
	je continue_z
	cmp ecx,0xB869A
	je continue_z
	cmp ecx,0xB873A
	je continue_z
	cmp ecx,0xB87DA
	je continue_z
	cmp ecx,0xB887A
	je continue_z
	cmp ecx,0xB891A
	je continue_z
	cmp ecx,0xB89BA
	je continue_z
	cmp ecx,0xB8A5A
	je continue_z
	cmp ecx,0xB8AFA
	je continue_z
	cmp ecx,0xB8B9A
	je continue_z
	cmp ecx,0xB8C3A
	je continue_z
	cmp ecx,0xB8CDA
	je continue_z
	cmp ecx,0xB84BA
	je continue_z
	cmp ecx,0xB8D7A
	je continue_z
	cmp ecx,0xB8E1A
	je continue_z
	cmp ecx,0xB8EBA
	je continue_z
	mov cl,[ebx+4]
	cmp cl,0xDB
	je continue_z
	mov cl,[ebx+166]
	cmp cl,0xDB
	je continue_z
	mov byte [ebx],0xFF
	mov byte [ebx+2],0xFF
	mov byte [ebx+162],0xFF
	mov byte [ebx+164],0xFF
	add ebx,2
	mov byte [ebx],0xDB
	mov byte [ebx+2],0xDB
	mov byte [ebx+162],0xDB
	mov byte [ebx+164],0xDB
	jmp continue_z
	
	
	left_arrow_z:
	mov ecx,ebx
	sub ecx,2
	cmp ecx,0xB84A4
	je continue_z
	cmp ecx,0xB8544
	je continue_z
	cmp ecx,0xB85E4
	je continue_z
	cmp ecx,0xB8684
	je continue_z
	cmp ecx,0xB8724
	je continue_z
	cmp ecx,0xB87C4
	je continue_z
	cmp ecx,0xB8864
	je continue_z
	cmp ecx,0xB8904
	je continue_z
	cmp ecx,0xB89A4
	je continue_z
	cmp ecx,0xB8A44
	je continue_z
	cmp ecx,0xB8AE4
	je continue_z
	cmp ecx,0xB8B84
	je continue_z
	cmp ecx,0xB8C24
	je continue_z
	cmp ecx,0xB8CC4
	je continue_z
	cmp ecx,0xB8D64
	je continue_z
	cmp ecx,0xB8E04
	je continue_z
	cmp ecx,0xB8EA4
	je continue_z
	cmp ecx,0xB8F44
	je continue_z
	mov cl,[ebx-2]
	cmp cl,0xDB
	je continue_z
	mov cl,[ebx+160]
	cmp cl,0xDB
	je continue_z
	mov byte [ebx],0xFF
	mov byte [ebx+2],0xFF
	mov byte [ebx+162],0xFF
	mov byte [ebx+164],0xFF
	sub ebx,2
	mov byte [ebx],0xDB
	mov byte [ebx+2],0xDB
	mov byte [ebx+162],0xDB
	mov byte [ebx+164],0xDB
	jmp continue_z
	
	

	
	
	up_arrow_rz:
	mov cl,[ebx-2]
	cmp cl,0xDB
	je continue_rz
	mov cl,[ebx+2]
	cmp cl,0xDB
	je continue_rz
	mov cl,[ebx+156]
	cmp cl,0xDB
	je continue_rz
	mov cl,[ebx+162]
	cmp cl,0xDB
	je continue_rz
	mov cl,[ebx+316]
	cmp cl,0xDB
	je continue_rz
	mov cl,[ebx+320]
	cmp cl,0xDB
	je continue_rz
	mov byte [ebx],0xFF
	mov byte [ebx+158],0xFF
	mov byte [ebx+160],0xFF
	mov byte [ebx+318],0xFF
	add ebx,156
	mov byte [ebx],0xDB
	mov byte [ebx+2],0xDB
	mov byte [ebx+162],0xDB
	mov byte [ebx+164],0xDB
	jmp continue_z
	
	down_arrow_rz:
	mov ecx,ebx
	add ecx,480
	cmp ecx,0xB8F58
	jg continue_rz
	mov cl,[ebx+320]
	cmp cl,0xDB
	je continue_rz
	mov cl,[ebx+478]
	cmp cl,0xDB
	je continue_rz
	mov byte [ebx],0xFF
	mov byte [ebx+158],0xFF
	mov byte [ebx+160],0xFF
	mov byte [ebx+318],0xFF
	add ebx,160
	mov byte [ebx],0xDB
	mov byte [ebx+158],0xDB
	mov byte [ebx+160],0xDB
	mov byte [ebx+318],0xDB
	jmp continue_rz
	
	
	right_arrow_rz:
	mov ecx,ebx
	add ecx,2
	cmp ecx,0xB84BA
	je continue_rz
	cmp ecx,0xB855A
	je continue_rz
	cmp ecx,0xB85FA
	je continue_rz
	cmp ecx,0xB869A
	je continue_rz
	cmp ecx,0xB873A
	je continue_rz
	cmp ecx,0xB87DA
	je continue_rz
	cmp ecx,0xB887A
	je continue_rz
	cmp ecx,0xB891A
	je continue_rz
	cmp ecx,0xB89BA
	je continue_rz
	cmp ecx,0xB8A5A
	je continue_rz
	cmp ecx,0xB8AFA
	je continue_rz
	cmp ecx,0xB8B9A
	je continue_rz
	cmp ecx,0xB8C3A
	je continue_rz
	cmp ecx,0xB8CDA
	je continue_rz
	cmp ecx,0xB84BA
	je continue_rz
	cmp ecx,0xB8D7A
	je continue_rz
	cmp ecx,0xB8E1A
	je continue_rz
	cmp ecx,0xB8EBA
	je continue_rz
	mov cl,[ebx+2]
	cmp cl,0xDB
	je continue_rz
	mov cl,[ebx+162]
	cmp cl,0xDB
	je continue_rz
	mov cl,[ebx+320]
	cmp cl,0xDB
	je continue_rz
	mov byte [ebx],0xFF
	mov byte [ebx+158],0xFF
	mov byte [ebx+160],0xFF
	mov byte [ebx+318],0xFF
	add ebx,2
	mov byte [ebx],0xDB
	mov byte [ebx+158],0xDB
	mov byte [ebx+160],0xDB
	mov byte [ebx+318],0xDB
	jmp continue_rz
	
	
	left_arrow_rz:
	mov ecx,ebx
	sub ecx,4
	cmp ecx,0xB84A4
	je continue_rz
	cmp ecx,0xB8544
	je continue_rz
	cmp ecx,0xB85E4
	je continue_rz
	cmp ecx,0xB8684
	je continue_rz
	cmp ecx,0xB8724
	je continue_rz
	cmp ecx,0xB87C4
	je continue_rz
	cmp ecx,0xB8864
	je continue_rz
	cmp ecx,0xB8904
	je continue_rz
	cmp ecx,0xB89A4
	je continue_rz
	cmp ecx,0xB8A44
	je continue_rz
	cmp ecx,0xB8AE4
	je continue_rz
	cmp ecx,0xB8B84
	je continue_rz
	cmp ecx,0xB8C24
	je continue_rz
	cmp ecx,0xB8CC4
	je continue_rz
	cmp ecx,0xB8D64
	je continue_rz
	cmp ecx,0xB8E04
	je continue_rz
	cmp ecx,0xB8EA4
	je continue_rz
	cmp ecx,0xB8F44
	je continue_rz
	mov cl,[ebx-2]
	cmp cl,0xDB
	je continue_rz
	mov cl,[ebx+156]
	cmp cl,0xDB
	je continue_rz
	mov cl,[ebx+316]
	cmp cl,0xDB
	je continue_rz
	mov byte [ebx],0xFF
	mov byte [ebx+158],0xFF
	mov byte [ebx+160],0xFF
	mov byte [ebx+318],0xFF
	sub ebx,2
	mov byte [ebx],0xDB
	mov byte [ebx+158],0xDB
	mov byte [ebx+160],0xDB
	mov byte [ebx+318],0xDB
	jmp continue_rz
	
	
	

	
	
	
	
	
	
	
	
	
	
	up_arrow_l:
	mov cl,[ebx-2]
	cmp cl,0xDB
	je continue_l
	mov cl,[ebx+158]
	cmp cl,0xDB
	je continue_l
	mov cl,[ebx+162]
	cmp cl,0xDB
	je continue_l
	mov cl,[ebx+322]
	cmp cl,0xDB
	je continue_l
	mov byte [ebx],0xFF
	mov byte [ebx+160],0xFF
	mov byte [ebx+320],0xFF
	add ebx,158
	mov byte [ebx],0xDB
	mov byte [ebx+2],0xDB
	mov byte [ebx+4],0xDB
	jmp continue_rl
	
	
	
	
	
	
	
	
	
	
    down_arrow_l:
	mov ecx,ebx
	add ecx,480
	cmp ecx,0xB8F58
	jg continue_l
	mov cl,[ebx+480]
	cmp cl,0xDB
	je continue_l
	mov byte [ebx],0xFF
	mov byte [ebx+160],0xFF
	mov byte [ebx+320],0xFF
	add ebx,160
	mov byte [ebx],0xDB
	mov byte [ebx+160],0xDB
	mov byte [ebx+320],0xDB
	jmp continue_l

	right_arrow_l:
	mov ecx,ebx
	add ecx,2
	cmp ecx,0xB84BA
	je continue_l
	cmp ecx,0xB855A
	je continue_l
	cmp ecx,0xB85FA
	je continue_l
	cmp ecx,0xB869A
	je continue_l
	cmp ecx,0xB873A
	je continue_l
	cmp ecx,0xB87DA
	je continue_l
	cmp ecx,0xB887A
	je continue_l
	cmp ecx,0xB891A
	je continue_l
	cmp ecx,0xB89BA
	je continue_l
	cmp ecx,0xB8A5A
	je continue_l
	cmp ecx,0xB8AFA
	je continue_l
	cmp ecx,0xB8B9A
	je continue_l
	cmp ecx,0xB8C3A
	je continue_l
	cmp ecx,0xB8CDA
	je continue_l
	cmp ecx,0xB84BA
	je continue_l
	cmp ecx,0xB8D7A
	je continue_l
	cmp ecx,0xB8E1A
	je continue_l
	cmp ecx,0xB8EBA
	je continue_l
	mov cl,[ebx+2]
	cmp cl,0xDB
	je continue_l
	mov cl,[ebx+162]
	cmp cl,0xDB
	je continue_l
	mov cl,[ebx+322]
	cmp cl,0xDB
	je continue_l
	mov byte [ebx],0xFF
	mov byte [ebx+160],0xFF
	mov byte [ebx+320],0xFF
	add ebx,2
	mov byte [ebx],0xDB
	mov byte [ebx+160],0xDB
	mov byte [ebx+320],0xDB
	jmp continue_l
	
	
	left_arrow_l:
	mov ecx,ebx
	sub ecx,2
	cmp ecx,0xB84A4
	je continue_l
	cmp ecx,0xB8544
	je continue_l
	cmp ecx,0xB85E4
	je continue_l
	cmp ecx,0xB8684
	je continue_l
	cmp ecx,0xB8724
	je continue_l
	cmp ecx,0xB87C4
	je continue_l
	cmp ecx,0xB8864
	je continue_l
	cmp ecx,0xB8904
	je continue_l
	cmp ecx,0xB89A4
	je continue_l
	cmp ecx,0xB8A44
	je continue_l
	cmp ecx,0xB8AE4
	je continue_l
	cmp ecx,0xB8B84
	je continue_l
	cmp ecx,0xB8C24
	je continue_l
	cmp ecx,0xB8CC4
	je continue_l
	cmp ecx,0xB8D64
	je continue_l
	cmp ecx,0xB8E04
	je continue_l
	cmp ecx,0xB8EA4
	je continue_l
	cmp ecx,0xB8F44
	je continue_l
	mov cl,[ebx-2]
	cmp cl,0xDB
	je continue_l
	mov cl,[ebx+158]
	cmp cl,0xDB
	je continue_l
	mov cl,[ebx+318]
	cmp cl,0xDB
	je continue_l
	mov byte [ebx],0xFF
	mov byte [ebx+160],0xFF
	mov byte [ebx+320],0xFF
	sub ebx,2
	mov byte [ebx],0xDB
	mov byte [ebx+160],0xDB
	mov byte [ebx+320],0xDB
	jmp continue_l
	

	
	
	
	up_arrow_rl:
	mov cl,[ebx-158]
	cmp cl,0xDB
	je continue_rl
	mov cl,[ebx-156]
	cmp cl,0xDB
	je continue_rl
	mov cl,[ebx+160]
	cmp cl,0xDB
	je continue_rl
	mov cl,[ebx+162]
	cmp cl,0xDB
	je continue_rl
	mov byte [ebx],0xFF
	mov byte [ebx+2],0xFF
	mov byte [ebx+4],0xFF
	sub ebx,158
	mov byte [ebx],0xDB
	mov byte [ebx+160],0xDB
	mov byte [ebx+320],0xDB
	jmp continue_l
	
	
	
	
	
	
	
	
	
	
    down_arrow_rl:
	mov ecx,ebx
	add ecx,160
	cmp ecx,0xB8F58
	jg continue_rl
	mov cl,[ebx+160]
	cmp cl,0xDB
	je continue_rl
	mov cl,[ebx+162]
	cmp cl,0xDB
	je continue_rl
	mov cl,[ebx+164]
	cmp cl,0xDB
	je continue_rl
	mov byte [ebx],0xFF
	mov byte [ebx+2],0xFF
	mov byte [ebx+4],0xFF
	add ebx,160
	mov byte [ebx],0xDB
	mov byte [ebx+2],0xDB
	mov byte [ebx+4],0xDB
	jmp continue_rl

	right_arrow_rl:
	mov ecx,ebx
	add ecx,6
	cmp ecx,0xB84BA
	je continue_rl
	cmp ecx,0xB855A
	je continue_rl
	cmp ecx,0xB85FA
	je continue_rl
	cmp ecx,0xB869A
	je continue_rl
	cmp ecx,0xB873A
	je continue_rl
	cmp ecx,0xB87DA
	je continue_rl
	cmp ecx,0xB887A
	je continue_rl
	cmp ecx,0xB891A
	je continue_rl
	cmp ecx,0xB89BA
	je continue_rl
	cmp ecx,0xB8A5A
	je continue_rl
	cmp ecx,0xB8AFA
	je continue_rl
	cmp ecx,0xB8B9A
	je continue_rl
	cmp ecx,0xB8C3A
	je continue_rl
	cmp ecx,0xB8CDA
	je continue_rl
	cmp ecx,0xB84BA
	je continue_rl
	cmp ecx,0xB8D7A
	je continue_rl
	cmp ecx,0xB8E1A
	je continue_rl
	cmp ecx,0xB8EBA
	je continue_rl
	mov cl,[ebx+6]
	cmp cl,0xDB
	je continue_rl
	mov byte [ebx],0xFF
	mov byte [ebx+2],0xFF
	mov byte [ebx+4],0xFF
	add ebx,2
	mov byte [ebx],0xDB
	mov byte [ebx+2],0xDB
	mov byte [ebx+4],0xDB
	jmp continue_rl
	
	
	left_arrow_rl:
	mov ecx,ebx
	sub ecx,2
	cmp ecx,0xB84A4
	je continue_rl
	cmp ecx,0xB8544
	je continue_rl
	cmp ecx,0xB85E4
	je continue_rl
	cmp ecx,0xB8684
	je continue_rl
	cmp ecx,0xB8724
	je continue_rl
	cmp ecx,0xB87C4
	je continue_rl
	cmp ecx,0xB8864
	je continue_rl
	cmp ecx,0xB8904
	je continue_rl
	cmp ecx,0xB89A4
	je continue_rl
	cmp ecx,0xB8A44
	je continue_rl
	cmp ecx,0xB8AE4
	je continue_rl
	cmp ecx,0xB8B84
	je continue_rl
	cmp ecx,0xB8C24
	je continue_rl
	cmp ecx,0xB8CC4
	je continue_rl
	cmp ecx,0xB8D64
	je continue_rl
	cmp ecx,0xB8E04
	je continue_rl
	cmp ecx,0xB8EA4
	je continue_rl
	cmp ecx,0xB8F44
	je continue_rl
	mov cl,[ebx-2]
	cmp cl,0xDB
	je continue_rl
	mov byte [ebx],0xFF
	mov byte [ebx+2],0xFF
	mov byte [ebx+4],0xFF
	sub ebx,2
	mov byte [ebx],0xDB
	mov byte [ebx+2],0xDB
	mov byte [ebx+4],0xDB
	jmp continue_rl
	

	
	
	
	
	
	
	up_arrow_x:
	mov cl,[ebx+2]
	cmp cl,0xDB
	je continue_x
	mov byte [ebx],0xFF
	mov byte [ebx+160],0xFF
	mov byte [ebx+162],0xFF
	mov byte [ebx],0xDB
	mov byte [ebx+2],0xDB
	mov byte [ebx+160],0xDB
	jmp continue_r1x
	
	
    down_arrow_x:
	mov ecx,ebx
	add ecx,320
	cmp ecx,0xB8F58
	jg continue_x
	mov cl,[ebx+320]
	cmp cl,0xDB
	je continue_x
	mov cl,[ebx+322]
	cmp cl,0xDB
	je continue_x
	mov byte [ebx],0xFF
	mov byte [ebx+160],0xFF
	mov byte [ebx+162],0xFF
	add ebx,160
	mov byte [ebx],0xDB
	mov byte [ebx+160],0xDB
	mov byte [ebx+162],0xDB
	jmp continue_x

	right_arrow_x:
	mov ecx,ebx
	add ecx,4
	cmp ecx,0xB84BA
	je continue_x
	cmp ecx,0xB855A
	je continue_x
	cmp ecx,0xB85FA
	je continue_x
	cmp ecx,0xB869A
	je continue_x
	cmp ecx,0xB873A
	je continue_x
	cmp ecx,0xB87DA
	je continue_x
	cmp ecx,0xB887A
	je continue_x
	cmp ecx,0xB891A
	je continue_x
	cmp ecx,0xB89BA
	je continue_x
	cmp ecx,0xB8A5A
	je continue_x
	cmp ecx,0xB8AFA
	je continue_x
	cmp ecx,0xB8B9A
	je continue_x
	cmp ecx,0xB8C3A
	je continue_x
	cmp ecx,0xB8CDA
	je continue_x
	cmp ecx,0xB84BA
	je continue_x
	cmp ecx,0xB8D7A
	je continue_x
	cmp ecx,0xB8E1A
	je continue_x
	cmp ecx,0xB8EBA
	je continue_x
	mov cl,[ebx+2]
	cmp cl,0xDB
	je continue_x
	mov cl,[ebx+164]
	cmp cl,0xDB
	je continue_x
	mov byte [ebx],0xFF
	mov byte [ebx+160],0xFF
	mov byte [ebx+162],0xFF
	add ebx,2
	mov byte [ebx],0xDB
	mov byte [ebx+160],0xDB
	mov byte [ebx+162],0xDB
	jmp continue_x
	
	
	left_arrow_x:
	mov ecx,ebx
	sub ecx,2
	cmp ecx,0xB84A4
	je continue_x
	cmp ecx,0xB8544
	je continue_x
	cmp ecx,0xB85E4
	je continue_x
	cmp ecx,0xB8684
	je continue_x
	cmp ecx,0xB8724
	je continue_x
	cmp ecx,0xB87C4
	je continue_x
	cmp ecx,0xB8864
	je continue_x
	cmp ecx,0xB8904
	je continue_x
	cmp ecx,0xB89A4
	je continue_x
	cmp ecx,0xB8A44
	je continue_x
	cmp ecx,0xB8AE4
	je continue_x
	cmp ecx,0xB8B84
	je continue_x
	cmp ecx,0xB8C24
	je continue_x
	cmp ecx,0xB8CC4
	je continue_x
	cmp ecx,0xB8D64
	je continue_x
	cmp ecx,0xB8E04
	je continue_x
	cmp ecx,0xB8EA4
	je continue_x
	cmp ecx,0xB8F44
	je continue_x
	mov cl,[ebx-2]
	cmp cl,0xDB
	je continue_x
	mov cl,[ebx+158]
	cmp cl,0xDB
	je continue_x
	mov byte [ebx],0xFF
	mov byte [ebx+160],0xFF
	mov byte [ebx+162],0xFF
	sub ebx,2
	mov byte [ebx],0xDB
	mov byte [ebx+160],0xDB
	mov byte [ebx+162],0xDB
	jmp continue_x
	

	
	up_arrow_r1x:
	mov cl,[ebx+162]
	cmp cl,0xDB
	je continue_r1x
	mov byte [ebx],0xFF
	mov byte [ebx+2],0xFF
	mov byte [ebx+160],0xFF
	mov byte [ebx],0xDB
	mov byte [ebx+2],0xDB
	mov byte [ebx+162],0xDB
	jmp continue_r2x
	
	
    down_arrow_r1x:
	mov ecx,ebx
	add ecx,320
	cmp ecx,0xB8F58
	jg continue_r1x
	mov cl,[ebx+320]
	cmp cl,0xDB
	je continue_r1x
	mov cl,[ebx+162]
	cmp cl,0xDB
	je continue_r1x
	mov byte [ebx],0xFF
	mov byte [ebx+2],0xFF
	mov byte [ebx+160],0xFF
	add ebx,160
	mov byte [ebx],0xDB
	mov byte [ebx+2],0xDB
	mov byte [ebx+160],0xDB
	jmp continue_r1x

	right_arrow_r1x:
	mov ecx,ebx
	add ecx,4
	cmp ecx,0xB84BA
	je continue_r1x
	cmp ecx,0xB855A
	je continue_r1x
	cmp ecx,0xB85FA
	je continue_r1x
	cmp ecx,0xB869A
	je continue_r1x
	cmp ecx,0xB873A
	je continue_r1x
	cmp ecx,0xB87DA
	je continue_r1x
	cmp ecx,0xB887A
	je continue_r1x
	cmp ecx,0xB891A
	je continue_r1x
	cmp ecx,0xB89BA
	je continue_r1x
	cmp ecx,0xB8A5A
	je continue_r1x
	cmp ecx,0xB8AFA
	je continue_r1x
	cmp ecx,0xB8B9A
	je continue_r1x
	cmp ecx,0xB8C3A
	je continue_r1x
	cmp ecx,0xB8CDA
	je continue_r1x
	cmp ecx,0xB84BA
	je continue_r1x
	cmp ecx,0xB8D7A
	je continue_r1x
	cmp ecx,0xB8E1A
	je continue_r1x
	cmp ecx,0xB8EBA
	je continue_r1x
	mov cl,[ebx+4]
	cmp cl,0xDB
	je continue_r1x
	mov cl,[ebx+162]
	cmp cl,0xDB
	je continue_r1x
	mov byte [ebx],0xFF
	mov byte [ebx+2],0xFF
	mov byte [ebx+160],0xFF
	add ebx,2
	mov byte [ebx],0xDB
	mov byte [ebx+2],0xDB
	mov byte [ebx+160],0xDB
	jmp continue_r1x
	
	
	left_arrow_r1x:
	mov ecx,ebx
	sub ecx,2
	cmp ecx,0xB84A4
	je continue_r1x
	cmp ecx,0xB8544
	je continue_r1x
	cmp ecx,0xB85E4
	je continue_r1x
	cmp ecx,0xB8684
	je continue_r1x
	cmp ecx,0xB8724
	je continue_r1x
	cmp ecx,0xB87C4
	je continue_r1x
	cmp ecx,0xB8864
	je continue_r1x
	cmp ecx,0xB8904
	je continue_r1x
	cmp ecx,0xB89A4
	je continue_r1x
	cmp ecx,0xB8A44
	je continue_r1x
	cmp ecx,0xB8AE4
	je continue_r1x
	cmp ecx,0xB8B84
	je continue_r1x
	cmp ecx,0xB8C24
	je continue_r1x
	cmp ecx,0xB8CC4
	je continue_r1x
	cmp ecx,0xB8D64
	je continue_r1x
	cmp ecx,0xB8E04
	je continue_r1x
	cmp ecx,0xB8EA4
	je continue_r1x
	cmp ecx,0xB8F44
	je continue_r1x
	mov cl,[ebx-2]
	cmp cl,0xDB
	je continue_r1x
	mov cl,[ebx+158]
	cmp cl,0xDB
	je continue_r1x
	mov byte [ebx],0xFF
	mov byte [ebx+2],0xFF
	mov byte [ebx+160],0xFF
	sub ebx,2
	mov byte [ebx],0xDB
	mov byte [ebx+2],0xDB
	mov byte [ebx+160],0xDB
	jmp continue_r1x
	

	up_arrow_r2x:
	mov cl,[ebx+160]
	cmp cl,0xDB
	je continue_r2x
	mov byte [ebx],0xFF
	mov byte [ebx+2],0xFF
	mov byte [ebx+162],0xFF
	add ebx,2
	mov byte [ebx],0xDB
	mov byte [ebx+158],0xDB
	mov byte [ebx+160],0xDB
	jmp continue_r3x
	
	
    down_arrow_r2x:
	mov ecx,ebx
	add ecx,320
	cmp ecx,0xB8F58
	jg continue_r2x
	mov cl,[ebx+160]
	cmp cl,0xDB
	je continue_r2x
	mov cl,[ebx+322]
	cmp cl,0xDB
	je continue_r2x
	mov byte [ebx],0xFF
	mov byte [ebx+2],0xFF
	mov byte [ebx+162],0xFF
	add ebx,160
	mov byte [ebx],0xDB
	mov byte [ebx+2],0xDB
	mov byte [ebx+162],0xDB
	jmp continue_r2x

	right_arrow_r2x:
	mov ecx,ebx
	add ecx,4
	cmp ecx,0xB84BA
	je continue_r2x
	cmp ecx,0xB855A
	je continue_r2x
	cmp ecx,0xB85FA
	je continue_r2x
	cmp ecx,0xB869A
	je continue_r2x
	cmp ecx,0xB873A
	je continue_r2x
	cmp ecx,0xB87DA
	je continue_r2x
	cmp ecx,0xB887A
	je continue_r2x
	cmp ecx,0xB891A
	je continue_r2x
	cmp ecx,0xB89BA
	je continue_r2x
	cmp ecx,0xB8A5A
	je continue_r2x
	cmp ecx,0xB8AFA
	je continue_r2x
	cmp ecx,0xB8B9A
	je continue_r2x
	cmp ecx,0xB8C3A
	je continue_r2x
	cmp ecx,0xB8CDA
	je continue_r2x
	cmp ecx,0xB84BA
	je continue_r2x
	cmp ecx,0xB8D7A
	je continue_r2x
	cmp ecx,0xB8E1A
	je continue_r2x
	cmp ecx,0xB8EBA
	je continue_r2x
	mov cl,[ebx+4]
	cmp cl,0xDB
	je continue_r2x
	mov cl,[ebx+164]
	cmp cl,0xDB
	je continue_r2x
	mov byte [ebx],0xFF
	mov byte [ebx+2],0xFF
	mov byte [ebx+162],0xFF
	add ebx,2
	mov byte [ebx],0xDB
	mov byte [ebx+2],0xDB
	mov byte [ebx+162],0xDB
	jmp continue_r2x
	
	
	left_arrow_r2x:
	mov ecx,ebx
	sub ecx,2
	cmp ecx,0xB84A4
	je continue_r2x
	cmp ecx,0xB8544
	je continue_r2x
	cmp ecx,0xB85E4
	je continue_r2x
	cmp ecx,0xB8684
	je continue_r2x
	cmp ecx,0xB8724
	je continue_r2x
	cmp ecx,0xB87C4
	je continue_r2x
	cmp ecx,0xB8864
	je continue_r2x
	cmp ecx,0xB8904
	je continue_r2x
	cmp ecx,0xB89A4
	je continue_r2x
	cmp ecx,0xB8A44
	je continue_r2x
	cmp ecx,0xB8AE4
	je continue_r2x
	cmp ecx,0xB8B84
	je continue_r2x
	cmp ecx,0xB8C24
	je continue_r2x
	cmp ecx,0xB8CC4
	je continue_r2x
	cmp ecx,0xB8D64
	je continue_r2x
	cmp ecx,0xB8E04
	je continue_r2x
	cmp ecx,0xB8EA4
	je continue_r2x
	cmp ecx,0xB8F44
	je continue_r2x
	mov cl,[ebx-2]
	cmp cl,0xDB
	je continue_r2x
	mov cl,[ebx+160]
	cmp cl,0xDB
	je continue_r2x
	mov byte [ebx],0xFF
	mov byte [ebx+2],0xFF
	mov byte [ebx+162],0xFF
	sub ebx,2
	mov byte [ebx],0xDB
	mov byte [ebx+2],0xDB
	mov byte [ebx+162],0xDB
	jmp continue_r2x
	

	up_arrow_r3x:
	mov cl,[ebx-2]
	cmp cl,0xDB
	je continue_r3x
	mov byte [ebx],0xFF
	mov byte [ebx+158],0xFF
	mov byte [ebx+160],0xFF
	sub ebx,2
	mov byte [ebx],0xDB
	mov byte [ebx+160],0xDB
	mov byte [ebx+162],0xDB
	jmp continue_x
	
	
    down_arrow_r3x:
	mov ecx,ebx
	add ecx,320
	cmp ecx,0xB8F58
	jg continue_r3x
	mov cl,[ebx+318]
	cmp cl,0xDB
	je continue_r3x
	mov cl,[ebx+320]
	cmp cl,0xDB
	je continue_r3x
	mov byte [ebx],0xFF
	mov byte [ebx+158],0xFF
	mov byte [ebx+160],0xFF
	add ebx,160
	mov byte [ebx],0xDB
	mov byte [ebx+158],0xDB
	mov byte [ebx+160],0xDB
	jmp continue_r3x

	right_arrow_r3x:
	mov ecx,ebx
	add ecx,2
	cmp ecx,0xB84BA
	je continue_r3x
	cmp ecx,0xB855A
	je continue_r3x
	cmp ecx,0xB85FA
	je continue_r3x
	cmp ecx,0xB869A
	je continue_r3x
	cmp ecx,0xB873A
	je continue_r3x
	cmp ecx,0xB87DA
	je continue_r3x
	cmp ecx,0xB887A
	je continue_r3x
	cmp ecx,0xB891A
	je continue_r3x
	cmp ecx,0xB89BA
	je continue_r3x
	cmp ecx,0xB8A5A
	je continue_r3x
	cmp ecx,0xB8AFA
	je continue_r3x
	cmp ecx,0xB8B9A
	je continue_r3x
	cmp ecx,0xB8C3A
	je continue_r3x
	cmp ecx,0xB8CDA
	je continue_r3x
	cmp ecx,0xB84BA
	je continue_r3x
	cmp ecx,0xB8D7A
	je continue_r3x
	cmp ecx,0xB8E1A
	je continue_r3x
	cmp ecx,0xB8EBA
	je continue_r3x
	mov cl,[ebx+2]
	cmp cl,0xDB
	je continue_r3x
	mov cl,[ebx+162]
	cmp cl,0xDB
	je continue_r3x
	mov byte [ebx],0xFF
	mov byte [ebx+158],0xFF
	mov byte [ebx+160],0xFF
	add ebx,2
	mov byte [ebx],0xDB
	mov byte [ebx+158],0xDB
	mov byte [ebx+160],0xDB
	jmp continue_r3x
	
	
	left_arrow_r3x:
	mov ecx,ebx
	sub ecx,4
	cmp ecx,0xB84A4
	je continue_r3x
	cmp ecx,0xB8544
	je continue_r3x
	cmp ecx,0xB85E4
	je continue_r3x
	cmp ecx,0xB8684
	je continue_r3x
	cmp ecx,0xB8724
	je continue_r3x
	cmp ecx,0xB87C4
	je continue_r3x
	cmp ecx,0xB8864
	je continue_r3x
	cmp ecx,0xB8904
	je continue_r3x
	cmp ecx,0xB89A4
	je continue_r3x
	cmp ecx,0xB8A44
	je continue_r3x
	cmp ecx,0xB8AE4
	je continue_r3x
	cmp ecx,0xB8B84
	je continue_r3x
	cmp ecx,0xB8C24
	je continue_r3x
	cmp ecx,0xB8CC4
	je continue_r3x
	cmp ecx,0xB8D64
	je continue_r3x
	cmp ecx,0xB8E04
	je continue_r3x
	cmp ecx,0xB8EA4
	je continue_r3x
	cmp ecx,0xB8F44
	je continue_r3x
	mov cl,[ebx-2]
	cmp cl,0xDB
	je continue_r3x
	mov cl,[ebx+156]
	cmp cl,0xDB
	je continue_r3x
	mov byte [ebx],0xFF
	mov byte [ebx+158],0xFF
	mov byte [ebx+160],0xFF
	sub ebx,2
	mov byte [ebx],0xDB
	mov byte [ebx+158],0xDB
	mov byte [ebx+160],0xDB
	jmp continue_r3x
	
	
	
	
	keypressedsquare:
	in al, 0x60;
	cmp al, 0x48;
	je up_arrow_square;
	cmp al, 0x50;
	je down_arrow_square;
	cmp al, 0x4D;
	je right_arrow_square;
	cmp al, 0x4B;
	je left_arrow_square;
	cmp al,0x13 
	je restart
	cmp al,0x19
	je pause_games
	cmp al,0x10
	je quit
	jmp continue_square
	
	keypressedz:
	in al, 0x60;
	cmp al, 0x48;
	je up_arrow_z;
	cmp al, 0x50;
	je down_arrow_z;
	cmp al, 0x4D;
	je right_arrow_z;
	cmp al, 0x4B;
	je left_arrow_z;
	cmp al,0x13 
	je restart
	cmp al,0x19
	je pause_gamez
	cmp al,0x10
	je quit
	jmp continue_z
	
	
	
	keypressedrz:
	in al, 0x60;
	cmp al, 0x48;
	je up_arrow_rz;
	cmp al, 0x50;
	je down_arrow_rz;
	cmp al, 0x4D;
	je right_arrow_rz;
	cmp al, 0x4B;
	je left_arrow_rz;
	cmp al,0x13 
	je restart
	cmp al,0x19
	je pause_gamerz
	cmp al,0x10
	je quit
	jmp continue_rz
	
	
	
	
	
	
	
	
	
	keypressedl:
	in al, 0x60;
	cmp al, 0x48;
	je up_arrow_l;
	cmp al, 0x50;
	je down_arrow_l;
	cmp al, 0x4D;
	je right_arrow_l;
	cmp al, 0x4B;
	je left_arrow_l;
	cmp al,0x13 
	je restart
	cmp al,0x19
	je pause_gamel
	cmp al,0x10
	je quit
	jmp continue_l
	
	
	keypressedrl:
	in al, 0x60;
	cmp al, 0x48;
	je up_arrow_rl;
	cmp al, 0x50;
	je down_arrow_rl;
	cmp al, 0x4D;
	je right_arrow_rl;
	cmp al, 0x4B;
	je left_arrow_rl;
	cmp al,0x13 
	je restart
	cmp al,0x19
	je pause_gamerl
	cmp al,0x10
	je quit
	jmp continue_rl
	
	
	keypressedx:
	in al, 0x60;
	cmp al, 0x48;
	je up_arrow_x;
	cmp al, 0x50;
	je down_arrow_x;
	cmp al, 0x4D;
	je right_arrow_x;
	cmp al, 0x4B;
	je left_arrow_x;
	cmp al,0x13 
	je restart
	cmp al,0x19
	je pause_gamex
	cmp al,0x10
	je quit
	jmp continue_x
	
	
	
	keypressedr1x:
	in al, 0x60;
	cmp al, 0x48;
	je up_arrow_r1x;
	cmp al, 0x50;
	je down_arrow_r1x;
	cmp al, 0x4D;
	je right_arrow_r1x;
	cmp al, 0x4B;
	je left_arrow_r1x;
	cmp al,0x13 
	je restart
	cmp al,0x19
	je pause_gamer1x
	cmp al,0x10
	je quit
	jmp continue_r1x
	
	
	
	keypressedr2x:
	in al, 0x60;
	cmp al, 0x48;
	je up_arrow_r2x;
	cmp al, 0x50;
	je down_arrow_r2x;
	cmp al, 0x4D;
	je right_arrow_r2x;
	cmp al, 0x4B;
	je left_arrow_r2x;
	cmp al,0x13 
	je restart
	cmp al,0x19
	je pause_gamer2x
	cmp al,0x10
	je quit
	jmp continue_r2x
	
	
	
	
	keypressedr3x:
	in al, 0x60;
	cmp al, 0x48;
	je up_arrow_r3x;
	cmp al, 0x50;
	je down_arrow_r3x;
	cmp al, 0x4D;
	je right_arrow_r3x;
	cmp al, 0x4B;
	je left_arrow_r3x;
	cmp al,0x13 
	je restart
	cmp al,0x19
	je pause_gamer3x
	cmp al,0x10
	je quit
	jmp continue_r3x
	
	;;;;;;;;;;;;;end of keys;;;;;;
	
	
	;;;;;;;;;;;;delete rows;;;;;;;;;;
	scan_rows:
	mov ebx,0xB84A6
	scan_row:
	xor ecx,ecx 
	scan:
	cmp ecx,10
	je itisfull
	mov al,byte[ebx+ecx*2]
	inc ecx
	cmp al,0xDB
	je scan
	jmp nextrow
	
	nextrow:
	add ebx,160
	cmp ebx,0xB8F46 
	jg scan_finish
	jmp scan_row
	
	itisfull:
	push ebx
	xor ecx,ecx 
	delete_row:
	cmp ecx,10
	je increase_score
	mov byte[ebx+ecx*2],0xFF
	inc ecx 
	jmp delete_row
	
	
	
	
	
	increase_score:
	mov al,byte[e]
	add al,0x01
	cmp al,0x3A
	je nextbit
	mov byte[ebp+330],al
	mov byte[e],al
	jmp increase_done
	
	nextbit:
	mov byte[e],0x30 
	mov al,byte[e]
	mov byte[ebp+330],al
	mov al,byte[f]
	add al,0x01
	cmp al,0x3A
	je nextbit2
	mov byte[ebp+328],al
	mov byte[f],al
	jmp increase_done
	
	nextbit2:
	mov byte[f],0x30 
	mov al,byte[f]
	mov byte[ebp+328],al
	mov al,byte[g]
	add al,0x01
	cmp al,0x3A
	je nextbit3
	mov byte[ebp+326],al
	mov byte[g],al
	jmp increase_done
	
	nextbit3:
	mov byte[g],0x30 
	mov al,byte[g]
	mov byte[ebp+326],al
	mov al,byte[h]
	add al,0x01
	cmp al,0x3A
	je fullbit
	mov byte[ebp+324],al
	mov byte[h],al
	jmp increase_done
	
	fullbit:
	mov byte[ebp+324],0x30
	mov byte[h],0x30
	jmp increase_done
	
	pause_games:

	xor ecx,ecx
	lpppps:
	cmp ecx,100000000
	jge pauses
	inc ecx
	jmp lpppps
	pauses:
	in al,0x60
	cmp al,0x19
	je continue_square
	jmp pauses
	
	pause_gamez:
	xor ecx,ecx
	lppppz:
	cmp ecx,100000000
	jge pausez
	inc ecx
	jmp lppppz
	pausez:
	in al,0x60
	cmp al,0x19
	je continue_z
	jmp pausez
	
	pause_gamerz:
	xor ecx,ecx
	lpppprz:
	cmp ecx,100000000
	jge pauserz
	inc ecx
	jmp lpppprz
	pauserz:
	in al,0x60
	cmp al,0x19
	je continue_rz
	jmp pauserz
	
	
	pause_gamel:
	xor ecx,ecx
	lppppl:
	cmp ecx,100000000
	jge pausel
	inc ecx
	jmp lppppl
	pausel:
	in al,0x60
	cmp al,0x19
	je continue_l
	jmp pausel
	
	
	pause_gamerl:
	xor ecx,ecx
	lpppprl:
	cmp ecx,100000000
	jge pauserl
	inc ecx
	jmp lpppprl
	pauserl:
	in al,0x60
	cmp al,0x19
	je continue_rl
	jmp pauserl
	
	
	pause_gamex:
	xor ecx,ecx
	lppppx:
	cmp ecx,100000000
	jge pausex
	inc ecx
	jmp lppppx
	pausex:
	in al,0x60
	cmp al,0x19
	je continue_x
	jmp pausex
	
	
	pause_gamer1x:
	xor ecx,ecx
	lppppr1x:
	cmp ecx,100000000
	jge pauser1x
	inc ecx
	jmp lppppr1x
	pauser1x:
	in al,0x60
	cmp al,0x19
	je continue_r1x
	jmp pauser1x
	
	
	pause_gamer2x:
	xor ecx,ecx
	lppppr2x:
	cmp ecx,100000000
	jge pauser2x
	inc ecx
	jmp lppppr2x
	pauser2x:
	in al,0x60
	cmp al,0x19
	je continue_r2x
	jmp pauser2x
	
	pause_gamer3x:
	xor ecx,ecx
	lppppr3x:
	cmp ecx,100000000
	jge pauser3x
	inc ecx
	jmp lppppr3x
	pauser3x:
	in al,0x60
	cmp al,0x19
	je continue_r3x
	jmp pauser3x
	
	
	quit:
	mov ecx,0xB8000
	lppp:
	mov byte [ecx],0xFF
	inc ecx
	cmp ecx,0xB8FA0
	jg rett
	jmp lppp
	rett:
	ret
	
	increase_done:
	drop_the_above:
	xor ecx,ecx
	sub ebx,160
	cmp ebx,0xB84A6
	jl return
	drop: 
	cmp ecx,10
	je drop_the_above
	mov al,byte[ebx+ecx*2]
	add ebx,160
	mov byte[ebx+ecx*2],al
	sub ebx,160
	inc ecx
	jmp drop
	return:
	pop ebx
	jmp nextrow
	scan_finish:
	jmp lp_another_shape
	;;;;;;;;;;end of delete rows;;;;
	

	;;;;;;;;;;;;;variables;;;;;;;;;
	jmp $
	a: db 0
	b: db 0
	c: db 0
	d: db 0
	e: db 0
	f: db 0
	g: db 0
	h: db 0
	s: dw 1
	count1: dd 0
	count2: dd 0
	count3: dd 0
	counter: dd 0
	;;;;;;;;;;;;;end of variables;;







times (0x400000 - 512) db 0

db 	0x63, 0x6F, 0x6E, 0x65, 0x63, 0x74, 0x69, 0x78, 0x00, 0x00, 0x00, 0x02
db	0x00, 0x01, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
db	0x20, 0x72, 0x5D, 0x33, 0x76, 0x62, 0x6F, 0x78, 0x00, 0x05, 0x00, 0x00
db	0x57, 0x69, 0x32, 0x6B, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x78, 0x04, 0x11
db	0x00, 0x00, 0x00, 0x02, 0xFF, 0xFF, 0xE6, 0xB9, 0x49, 0x44, 0x4E, 0x1C
db	0x50, 0xC9, 0xBD, 0x45, 0x83, 0xC5, 0xCE, 0xC1, 0xB7, 0x2A, 0xE0, 0xF2
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00