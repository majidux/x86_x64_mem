extrn   cntr:word
public  shw

prcs    segment
        assume  cs:prcs
shw     proc    far
        mov     cx,cntr
tek:    lodsb
        lodsb
        stosw
        inc     ah
        loop    tek
        ret
shw     endp
prcs    ends
        end