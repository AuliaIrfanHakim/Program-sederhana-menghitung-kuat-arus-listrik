.model small
.stack 100h

.data
prompt1 db 'Masukkan tegangan (V): $'
prompt2 db 'Masukkan hambatan (R): $'
result db 'Kuat arus (I) = ', '$'
v dw ?
r dw ?
i dw ? 

.code
start:
mov ax, @data
mov ds, ax

mov ah, 09h
mov dx, offset prompt1
int 21h

mov ah, 01h
int 21h
sub al, 30h
mov cl, al
mov ah, 01h
int 21h
sub al, 30h
mov ch, al
shl cl, 4
or cl, ch
mov [v], cx

mov ah, 09h
mov dx, offset prompt2
int 21h

mov ah, 01h
int 21h
sub al, 30h
mov cl, al
mov ah, 01h
int 21h
sub al, 30h
mov ch, al
shl cl, 4
or cl, ch
mov [r], cx

xor dx, dx
mov ax, [v]
div word ptr [r]
mov [i], ax

mov ah, 09h
mov dx, offset result
int 21h

mov cx, 10
mov bx, [i]
mov ax, 0

print_loop:
xor dx, dx
mov ax, bx
div cx
add dl, '0'
mov ah, 02h
int 21h

print_done:
mov ah, 00h
int 16h

mov ax, 4c00h
int 21h

end start
