%include "../include/io.mac"

section .text
    global beaufort
    extern printf

; void beaufort(int len_plain, char *plain, int len_key, char *key, char tabula_recta[26][26], char *enc) ;
beaufort:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; len_plain
    mov ebx, [ebp + 12] ; plain (address of first element in string)
    mov ecx, [ebp + 16] ; len_key
    mov edx, [ebp + 20] ; key (address of first element in matrix)
    mov edi, [ebp + 24] ; tabula_recta
    mov esi, [ebp + 28] ; enc
    ;; DO NOT MODIFY
    ;; TODO: Implement spiral encryption
    ;; FREESTYLE STARTS HERE
    mov edi, eax ; vreau sa decrementez din edi in loc de eax deoarece nu folosesc registrul edi cu scopul lui dar am nevoie de un registru cu o parte de un octet accesibila, deci il inlocuiesc cu eax
    xor eax, eax ; resetez bitii de pe partile high ale lui eax
begin:
    mov al, byte [edx] ; incep prin a muta la adresa esi literele din cheie de la adresa edx, folosind al ca registru auxiliar
    mov byte [esi], al
    mov al, byte [ebx] ; acum folosesc al pentru a retine numarul de pozitii pe care trebuie sa-l scad din litera cheii pentru a ajunge la litera rezultanta buna
    sub al, 65 ; acest numar de pozitii este egal cu litera din plaintext din care se scade litera A (cod ASCII 65)
    sub byte [esi], al ; scad acel numar de pozitii din litera din cheie
    cmp byte [esi], 65 ; verific daca am depasit inferior litera A
    jge jump ; in cazul in care nu am depasit, se sare peste urmatoarea instructiune
    add byte [esi], 26 ; in cazul in care am depasit, adun din nou lungimea alfabetului la acea litera pentru a ma reintoarce la Z
jump:
    inc ebx ; trec la urmatoarea litera din plaintext
    inc esi ; trec la urmatoarea pozitie de litera in stringul criptat
    inc edx ; trec la urmatoarea litera din cheie
    dec ecx ; scad lungimea cheii
    jnz over
    mov ecx, [ebp + 16] ; in cazul in care lungimea cheii ajunge la 0, aceasta, dar si adresa cheii in sine se reinitializeaza cu valorile de pe stiva
    mov edx, [ebp + 20]
over:
    dec edi ; trec la urmatoarea litera de criptat scazand edi, care contine valoarea care initial era in eax, lungimea stringului plain
    jnz begin
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
