	;===========================random shape=====================
	xor eax,eax
	call rng
	mov word[s],ax
	lp_another_shape:
	
	mov ebx,0xB86A4
	add ebx,346
	
	call rng
	cmp ax,1
	je BS
	cmp ax,2
	je ZS
	cmp ax,3
	je IS
	cmp ax,4
	je LS
	;=======================
	cont:
	
	mov ebx,0xB84AE
	mov cx,word[s]
	mov word[s],ax
	cmp cx,1
	je lps
	cmp cx,2
	je lpz
	cmp cx,3
	je lpl
	cmp cx,4
	je lpx	
		
	
	
	
	rng : 
	rdtsc
	xor dx ,dx
	xor cx,cx
	mov cx , 4 
	div cx 
	mov ax ,dx
	add ax , 1
	ret 
	