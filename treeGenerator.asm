.model small
.stack 200h
.data
    lungimePrecedenta dw 0
    culoareSchimbata db 0
    culoare db 0110b
    initX dw 0
    initY dw 30
    curentX dw 0
    curentY dw 0
    finalX dw 20
    offsetDeLaStanga dw 10
    nrLinii dw 0
    rand dw 15 ;trb sa fie de maxim 1 byte (am ales marimea dw pt usurinta atribuirii)
.code
    start:
        mov ax, @data
        mov ds, ax

        ;pentru un exemplu de brad tastati:
        ;322239888777666554433322211

        ;explicatie: fiecare valoarea introdusa reprezinta grosimea unei linii (de jos in sus)
        ;din forma bradului

        ;initializam stiva cu o val de 0 ca sa stie programul cand sa se opreasca
        push 0h

        ;initializam valorile pentru curentX si curentY
        mov ax, initX
        mov curentX, ax
        mov ax, initY
        mov curentY, ax

        citireCifra:
            ;citire caracter
            mov ah, 01h
            int 21h

            ;daca e CR (Enter) se termina citirea
            cmp al, 13
            je startVideo

            ;daca nu e CR
            ;in ax se pune doar valoarea citita
            mov ah, 0
            sub al, 30h
            ;se inmulteste cu 10 ca sa se vada mai bine linia
            mov bx, 2
            mul bx
            ;se depoziteaza valoarea citita pe stiva
            push ax
            
            ;crestem numarul de linii
            mov ax, nrLinii
            inc ax
            mov nrLinii, ax

            jmp citireCifra
        startVideo:

            ;video mode
            mov al, 13h
            mov ah, 0
            int 10h 
            
            ;mutam in dx val de la care sa fie desenata prima linie
            mov dx, curentX

            ;initializam bp cu adresa din varful stivei
            mov bp, sp 


        enumerareLinii:
            ;scoatem de pe stiva grosimea liniei

            ; pop cx

            ;echivalent cu pop cx dar fara sa stearga valoarea 
            ;(schimba pozitia pointerului la urmatorea adresa a unui element din stiva)
            mov cx, [bp]
            mov ax, 2
            add bp, ax

            ;copiem valoarea in ax ca sa o modificam
            mov ax, cx

            ;schimbam culoarea cand devine lungimea liniei mai mica decat inainte
            mov bx, offset culoareSchimbata
            mov dx, 0106h
            cmp [bx], dh
            je continuaEnumerare

            mov bx, offset lungimePrecedenta
            mov dh, [bx]
            cmp dh,al 
            jg schimbaCuloareaMaro

            schimbaCuloareaVerde:
                ;verde deschis 1010b 
                ; verde inchis 0010b
                mov dl, 0010b
                jmp continuaEnumerare

            schimbaCuloareaMaro:
                mov bx, offset culoareSchimbata
                mov dh, 1
                mov [bx], dh
                mov dx, 0006h

            continuaEnumerare:

            ;daca valoarea extrasa de pe stiva e 0 atunci terminam programul
            cmp cx, 0000h
            je startBecuri

            ;schimbam culoarea
            mov culoare, dl

            ;atribuim lungimea precedenta
            mov lungimePrecedenta, cx

            ;curentX
            mov ax, cx
            mov dl, 2
            idiv dl
            xor ah, ah

            ;se ia un offset in considerare (10 pentru ca val maxima care poate fi introdusa e 9)
            ;ca toate valorile sa fie centrate
            mov dx , offsetDeLaStanga
            sub dx, ax

            ;mutam valoarea calculata de offset in curentX
            mov curentX, dx

            ;finalX
            ;adaugam valoarea noua pentru curentX cu lungimea liniei pt a obtine noul finalX
            mov ax, cx
            add ax, dx
            mov finalX, ax

            ;curentY
            ;mutam curentY pe urmatorul rand pentru desenarea liniei 
            mov ax, 1
            add curentY, ax

            jmp deseneazaLinie

        gotoEnumerareLinii:
            jmp enumerareLinii
        deseneazaLinie:
            ;deseneaza pixel

            ;culoare
            mov al, culoare
            ;coloana
            mov cx, curentX
            ;rand
            mov dx, curentY

            ;comanda pentru desensarea pixelului cu atributele de mai sus
            mov ah, 0ch
            int 10h

            ;comparare X
            mov ax, 1
            add curentX, ax
            mov ax, curentX

            ;daca curentX e egal cu finalX linia a terminat a fi desenata
            cmp ax, finalX
            je gotoEnumerareLinii

            ;daca nu e egal curentX cu finalX se reia
            jmp deseneazaLinie
        final:
            mov ah, 4ch
            int 21h
        startBecuri:
            ;initializam bp cu adresa de la varful stivei 
            mov bp, sp

            ;reinitializam curentY ca sa desenam peste pixelii bradului
            mov ax, initY
            mov curentY, ax
            
            ;initializa culoarea cu albastru (e cea mai mica nuanta ca valoare in afara de negru)
            mov dx, 0001b
        enumerareBecuri:
            ;scoatem de pe stiva grosimea liniei

            ; pop cx

            ;echivalent cu pop cx dar fara sa stearga valoarea 
            ;(schimba pozitia pointerului la urmatorea adresa a unui element din stiva)
            mov cx, [bp]
            mov ax, 2
            add bp, ax
            
            ;daca valoarea extrasa de pe stiva e 0 atunci terminam programul
            cmp cx, 0000h
            je final

            ;copiem valoarea in ax ca sa o modificam
            mov ax, cx

            ;punem culoarea globurilor in ordine aparent intamplatoare
            add dx, 1
            or dh, dl

            ;daca vreti doar globuri rosii mai este varianta
            ; mov dx, 0100b

            ;schimbam culoarea
            mov culoare, dl

            ;atribuim lungimea precedenta
            mov lungimePrecedenta, cx

            ;curentX
            mov ax, cx
            mov dl, 2
            idiv dl
            xor ah, ah

            ;se ia un offset in considerare (10 pentru ca val maxima care poate fi introdusa e 9)
            ;ca toate valorile sa fie centrate
            mov dx , offsetDeLaStanga
            sub dx, ax

            ;mutam valoarea calculata de offset in curentX
            mov curentX, dx

            ;curentY
            ;mutam curentY pe urmatorul rand pentru desenarea liniei 
            mov ax, 1
            add curentY, ax

            jmp deseneazaBecuri
        deseneazaBecuri:
            ;coloana
            mov cx, curentX
            ;rand
            mov dx, curentY

            ;verificam culoarea pixelului
            mov ah, 0dh
            int 10h

            ;punem culoarea maro in bl pt comparatie
            mov ah, 0110b

            ;daca culoarea pixelului este maro atunci terminam programul (nu punem globuri pe scoarta)
            cmp al, ah
            je final

            ;punem o valoare "random" bazata pe un seed initial din rand in ax 
            ;(care e in raport cu adresa de pe stiva a lungimii actuale)
            mov ax, rand
            mul ax
            add ax, 9eh
            mov dx, 1
            add rand, dx
            ;totusi tinem cont de lungimea liniei pentru ca valorile 
            ;sa ramana in aria bradului (luand restul impartirii la lungimea liniei)
            mov bx, lungimePrecedenta
            mov dh, bl
            div dh

            ;stocam catul impartirii in al si golim ah
            mov al, ah
            xor ah,ah

            ;adaugam offset "random" la coloana
            add cx, ax

            ; mov cx, ax

            ;rand
            mov dx, curentY

            ;culoare
            mov al, culoare

            ;comanda pentru desensarea pixelului cu atributele de mai sus
            mov ah, 0ch
            int 10h

            ;se duce la urmatorul rand
            jmp enumerareBecuri

    end start