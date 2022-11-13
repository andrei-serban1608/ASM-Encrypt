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
    global road
    extern printf

road:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]      ; points
    mov ecx, [ebp + 12]     ; len
    mov ebx, [ebp + 16]     ; distances
    ;; DO NOT MODIFY
   
    ;; Your code starts here
    dec ecx ; am scazut 1 din ecx deoarece eu scad dintre un punct si urmatorul indexul fiind plasat pe cel anterior, asadar pentru intreaga lungime s-ar fi repetat o data in plus
begin: ; codul si comentariile de mai jos sunt copiate de la primul subpunct al taskului doar ca sunt puse in loopul care se intoarce la label-ul begin
    mov edx, [eax] ; folosesc edx ca registru auxiliar in care sa retin elementele vectorului de puncte de la adresa eax
    shr edx, 16 ; pentru coordonata x a primului punct am nevoie de partea "high" de 16 biti a lui edx, inaccesibila prin sintaxa, asa ca shiftez registrul cu 16 biti la dreapta, astfel ducand coordonata lui x in cx
    mov [x1], dx; realizez mutarea in variabila globala x1
    mov edx, [eax] ; reinitializez in edx valoarea primului punct din vector
    mov [y1], dx ; pentru coordonata y este mai simplu deoarece aceasta se afla deja in partea de dx a lui edx, deci doar realizez mutarea
    mov edx, [eax + 4] ; pentru cel de-al doilea punct este nevoie de valoarea de la adresa lui eax, cu un offset de 4 octeti
    shr edx, 16 ; analog realizez mutarile necesare pentru initializarea coordonatelor celui de-al doilea punct in x2 si y2
    mov [x2], dx
    mov edx, [eax + 4]
    mov [y2], dx
    xor edx, edx ; resetez registrul edx la 0 pentru a il putea folosi in alt scop
    mov si, [x1] ; folosesc partea pe 16 biti a registrului esi pentru a retine coordonata x a primului punct
    mov di, [x2] ; analog, pentru edi si coordonata x a celui de-al doilea punct
    cmp si, di ; compar cele doua valori pentru a vedea daca sunt egale
    jz Oy ; in caz ca sunt egale, inseamna ca segmentul este paralel cu Oy, deci sare la eticheta Oy
    jmp Ox ; in caz contrar, inseamna ca coordonatele y sunt egale, deci segmentul e paralel cu Ox si se sare la eticheta Ox
Ox:
    xor edi, edi ; setez partea high de 16 biti pe 0 cu xor
    mov dx, [x2] ; partea de 16 biti a registrului edx retine coordonata x a celui de-al doilea punct
    mov di, [x1] ; partea de 16 biti a registrului edi retine coordonata x a primului punct
    cmp dx, di ; compar cele doua numere sa vad care e mai mare
    jg dx_greater1 ; daca dx e mai mare decat di, se sare la labelul dx_greater1
    sub di, dx ; in cazul in care di e mai mare decat dx se scade din di valoarea lui dx
    mov [ebx], edi ; se muta valoarea din registrul edi la adresa retinuta de ebx
    jmp end1 ; in cazul asta se sare peste ramura cu eticheta "dx_greater1"
dx_greater1:
    sub dx, di ; se scade valoarea lui di din dx
    mov [ebx], edx ; mut la continutul adresei ebx rezultatul cerut
end1:
    jmp exit ; deoarece mai este cod pentru label-ul Oy pe care nu vreau sa-l execut pe ramura asta, sar la o eticheta exit, care se afla la finalul programului
Oy:
    xor edi, edi ; analog, scad coordonatele y ale segmentului in cazul in care segmentul e paralel cu Oy si le mut in [ebx]
    mov dx, [y2]
    mov di, [y1]
    cmp dx, di
    jg dx_greater2
    sub di, dx
    mov [ebx], edi
    jmp exit
dx_greater2:
    sub dx, di
    mov [ebx], edx
exit:
    add ebx, 4 ; cresc offsetul adresei retinute la ebx cu marimea unui int pentru a putea plasa urmatorul element in vector
    add eax, 4 ; cresc offsetul adresei retinute la eax cu 2 * marimea unui short pentru a putea citi urmatorul punct din vectorul de structuri
    dec ecx ; modific instructiunea loop begin cu dec ecx; jnz begin, deoarece distanta de la aceasta instructiune la labelul begin e mai mare decat permite loop
    jnz begin
    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY