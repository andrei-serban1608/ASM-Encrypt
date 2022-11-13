%include "../include/io.mac"

section .text
    global is_square
    extern printf

is_square:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov ebx, [ebp + 8]      ; dist
    mov eax, [ebp + 12]     ; nr
    mov ecx, [ebp + 16]     ; sq
    ;; DO NOT MODIFY
   
    ;; Your code starts here
    mov edi, eax ; mut numarul de la eax in registrul edi pentru a putea folosi instructiunea mul care inmulteste doar pe eax
begin:
    cmp dword [ebx], 0 ; in cazul special in care distanta e 0 si punctul e acelasi de 2 ori, 0 este patrat perfect dar nu verifica algoritmul meu, asa ca sar direct la labelul unde se scrie 1 in vectorul de rezultate
    jz is_one
    xor edx, edx ; pentru fiecare iteratie, registrii auxiliari pe care ii folosesc se reseteaza la 0
    xor eax, eax
    xor esi, esi
begin_mul:
    mov eax, esi ; deoarece de fiecare data, la instructiunea mul, se schimba valoarea lui eax, retin valoarea nemodificata in esi si i-o dau inapoi lui eax la inceputul fiecarei iteratii
    inc edx ; cresc cele doua registre care trec prin toate numerele naturale
    inc eax
    mov esi, eax ; aici mut valoarea din eax in esi pentru a o retine la urmatoarea iteratie
    mul eax ; rezultatul inmultirii dintre eax si edx e in eax
    cmp eax, [ebx] ; se compara valoarea numarului din sirul patratelor perfecte cu cea din vectorul cu adresa la ebx
    jg is_zero ; in cazul in care patratul e mai mare decat distanta inseamna ca distanta nu are cum sa fie patrat perfect, deci se sare la is_zero
    jl begin_mul ; in cazul in care patratul e mai mic se trece la urmatorul patrat din sir
is_one: ; la eticheta is_one se adauga 1 in vectorul sq
    mov dword [ecx], 1
    jmp exit ; se sare peste eticheta is_zero
is_zero: ; la labelul is_zero se adauga 0 in sq
    mov dword [ecx], 0
exit:
    add ebx, 4 ; cresc adresele de la ebx si ecx cu marimea unui int pentru a trece la urmatorul element din ambii vectori
    add ecx, 4
    dec edi ; se decrementeaza edi pana ajunge la 0, moment in care iese din loop-ul de la eticheta begin
    jnz begin
    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY