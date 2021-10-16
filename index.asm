stk segment stack 'stack'
    dw 32 dup('s')
stk ends
dts segment
p1  db 'github'
cntr    dw  39
dts ends

prcs segment
    assume cs:prcs,ds:dts

shw     proc far
    mov cx,cntr
tek:    lodsb
    lodsb
    stosw
    inc ah
    loop    tek
    ret
shw endp
prcs ends

cds segment
    assume  cs:cds,ds:dts

main    proc far
    mov ax,seg dts
    mov ds,ax
    mov ax, 0b800h
    mov es,ax
    mov si , offset   p1
    mov di,160
    cld ;   DF=0
    mov ah,85h
    call shw
    mov ah,4ch
    int 21h
main    endp
cds ends
    end main