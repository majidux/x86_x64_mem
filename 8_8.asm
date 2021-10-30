stk        segment stack 'stack'
        dw 32 dup(?)
stk        ends
dts        segment
m1        db 10,13,'CF=  '
        db 10,13,'ZF=  '
        db 10,13,'SF=  '
        db 10,13,'OF=  $'; CF=0 2^0=1 ZF=6 2^6=64 SF=7 2^7=128 OF=11 2^11=2048
dts        ends
cds        segment
        assume cs:cds,ss:stk,ds:dts
tst        proc near
        je f0
        mov byte ptr [si],31h
        jmp nx
f0:        mov byte ptr [si],30h
nx:        add si,7
        ret
tst        endp
main        proc far
        mov ax,seg dts
        mov ds,ax
        mov si,offset m1+6
        mov cl,2
        mov al,10000010b;130
        shl al,cl
        pushf
        pop dx
        test dx,1
        call tst
        test dx,64
        call tst
        test dx,128
        call tst
        test dx,2048
        call tst
        mov ah,09
        mov dx,offset m1
        int 21h
        mov ah,4ch
        int 21h
main        endp
cds        ends
        end main