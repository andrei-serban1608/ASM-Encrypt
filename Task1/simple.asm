%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
     ;; Your code starts here
    mov eax, 0 ; indexul cu care voi parcurge stringul necriptat
str_rep:
    mov ebx, [esi + eax] ; copiez litera cu offset-ul eax din stringul initial in cel ce trebuie criptat, pentru fiecare litera
    mov [edi + eax], ebx
    add [edi + eax], edx ; adaug step-ul la litera ce trebuie criptata
    cmp byte [edi + eax], 90 ; verific daca litera, la care adaug step-ul, depaseste litera Z (cod ASCII: 90)
    jle continue ; in cazul in care nu depaseste, urmatoarele instructiuni, de resetare a literei, nu se parcurg, sarindu-se la label-ul continue
    sub dword [edi + eax], 26 ; in cazul in care depaseste, se scade din litera de la offset-ul eax lungimea alfabetului englez
continue:
    inc eax ; cresc offset-ul
loop str_rep ; folosesc instructiunea loop pentru a numara iteratiile (parcurgerea caracter cu caracter), deoarece lungimea sirului se afla in registrul ecx
    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY