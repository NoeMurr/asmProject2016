.code32

.section .data

.section .text
    .globl  _check
    .type   _check, @function

_check:
    cmpl    $0, init
    je      _init_0

    cmpl    $2000, rpm
    jl      _sg
    cmpl    $4000, rpm
    jle     _opt

_fg:
    movl    $3, %eax        # Nuova mod
    cmpl    $1, reset
    je      _reset_numb

    cmpl    $3, mod
    jne     _reset_numb

    incl    numb
    movl    %eax, mod

    cmpl    $15, numb
    jge      _set_alm

    ret


_opt:
    movl    $2, %eax
    cmpl    $1, reset
    je      _reset_numb

    cmpl    $2, mod
    jne     _reset_numb

    incl    numb
    movl    %eax, mod

    ret


_sg:
    movl    $1, %eax
    cmpl    $1, reset
    je      _reset_numb

    cmpl    $1, mod
    jne      _reset_numb

    incl    numb
    movl    %eax, mod
    ret

_reset_numb:
    movl    %eax, mod
    movl    $0, numb
    movl    $0, alm
    ret

_set_alm:
    movl    $1, alm

    ret

_init_0:
    movl    $0, alm
    movl    $0, numb
    movl    $0, mod

    ret
