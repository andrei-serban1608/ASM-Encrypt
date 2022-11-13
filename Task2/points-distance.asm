%include "../include/io.mac"

section .data
    x1 DW 0 ; coordonata x a primului punct
    y1 DW 0 ; coordonata y a primului punct
    x2 DW 0 ; coordonata x a celui de-al doilea punct
    y2 DW 0 ; coordonata y a celui de-al doilea punct

struc point
    .x: resw 1
    .y: resw 1
endstruc

section .text
    global points_distance
    extern printf

points_distance:
    ;; DO NOT MODIFY
    
    push ebp
    mov ebp, esp
    pusha

    mov ebx, [ebp + 8]      ; points
    mov eax, [ebp + 12]     ; distance
    ;; DO NOT MODIFY
   
    ;; Your code starts here
    mov ecx, [ebx] ; folosesc ecx ca registru auxiliar in care sa retin elementele vectorului de puncte de la adresa ebx
    shr ecx, 16 ; pentru coordonata x a primului punct am nevoie de partea "high" de 16 biti a lui ecx, inaccesibila prin sintaxa, asa ca shiftez registrul cu 16 biti la dreapta, astfel ducand coordonata lui x in cx
    mov [x1], cx; realizez mutarea in variabila globala x1
    mov ecx, [ebx] ; reinitializez in ecx valoarea primului punct din vector
    mov [y1], cx ; pentru coordonata y este mai simplu deoarece aceasta se afla deja in partea de cx a lui ecx, deci doar realizez mutarea
    mov ecx, [ebx + 4] ; pentru cel de-al doilea punct este nevoie de valoarea de la adresa lui ebx, cu un offset de 4 octeti
    shr ecx, 16 ; analog realizez mutarile necesare pentru initializarea coordonatelor celui de-al doilea punct in x2 si y2
    mov [x2], cx
    mov ecx, [ebx + 4]
    mov [y2], cx
    xor ecx, ecx ; resetez registrul ecx la 0 pentru a il putea folosi in alt scop
    mov si, [x1] ; folosesc partea pe 16 biti a registrului esi pentru a retine coordonata x a primului punct
    mov di, [x2] ; analog, pentru edi si coordonata x a celui de-al doilea punct
    cmp si, di ; compar cele doua valori pentru a vedea daca sunt egale
    jz Oy ; in caz ca sunt egale, inseamna ca segmentul este paralel cu Oy, deci sare la eticheta Oy
    jmp Ox ; in caz contrar, inseamna ca coordonatele y sunt egale, deci segmentul e paralel cu Ox si se sare la eticheta Ox
Ox:
    mov cx, [x2] ; partea de 16 biti a registrului ecx pentru a retine, intai, coordonata x a celui de-al doilea punct
    sub cx, [x1] ; din aceasta, scad coordonata primului punct
    mov [eax], ecx ; mut la continutul adresei eax rezultatul cerut
    jmp exit ; deoarece mai este cod pentru label-ul Oy pe care nu vreau sa-l execut pe ramura asta, sar la o eticheta exit, care se afla la finalul programului
Oy:
    mov cx, [y2] ; analog, scad coordonatele y ale segmentului in cazul in care segmentul e paralel cu Oy si le mut in [eax]
    sub cx, [y1]
    mov [eax], ecx
exit:
    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret

    ;; DO NOT MODIFY