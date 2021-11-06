stk        segment stack 'stack'
        dw 32 dup(?)
stk        ends
dts        segment
p1        db 10,13,'Please enter max 80 characters:',10,13,'$'
max         db 80
len         db ?
str1        db 80 dup(?)
p2        db 10,13,'The number of As are:   $'
dts        ends
cds        segment
        assume cs:cds,ss:stk,ds:dts
main        proc far
        mov ax,seg dts
        mov ds,ax
        mov es,ax
        mov ah,09
        mov dx,offset p1
        int 21h
        mov ah,0ah
        mov dx,offset max
        int 21h
        cld ; clear direction DF=0
        mov al,'A' ; SCASB AL==ES:DI ZF=1
        mov di,offset str1
        xor dl,dl
        mov cl,len
        xor ch,ch ; ch=0
tek:        repne scasb ; stops repeating command if cx==0 or ZF==1
        jnz fin
        inc dl
        jmp tek
fin:        mov al,dl
        xor ah,ah
        mov dl,10
        div dl ; AX/DL AL=quotient AH=remainder
        or ax,3030h
        mov bx, offset p2+24
        mov [bx],ax
        mov ah,09
        mov dx,offset p2
        int 21h
        mov ah,4ch
        int 21h
main        endp
cds        ends
        end main
        
