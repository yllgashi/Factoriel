org 100h

.data
    numri dw ?
    rreshtIRi db 0ah, 0dh,"$"
    tekstMesazhi db "Shkruaj nje numer: $"
    tekstRezultati db "Rezultati eshte: $" 
    faktorieli db ? 

.code
    mov dx, offset tekstMesazhi
    mov ah, 09h                   ; Udhezimi per te shtyp nje numer
    int 21h 
    
    mov ah, 01h    
    int 21h                      ; Kerkohet nga perdoruesi te shtyp nje numer                     
    mov bl, al                   ; Vleren e dhene e ruajme te regjistri bx, perkatesisht bl
    sub bx, 30h                  ; Vleres se dhene ne regjistrin bx, i zbresim 30h, per te dalur te numrat 0-9  
                                                              
    mov dx,offset rreshtIRi  ;
    mov ah, 09h              ; Dalja ne rresht tjeter per qeshtje dizajni
    int 21h                  ;
                               
    mov dx, offset tekstRezultati ;
    mov ah, 09h 
    int 21h                  ; Printimi i tekstit "Rezultati eshte:"
    mov ax, bx
   
    mov cx, 0 ; Behet 0 per t'i numeruar elementet te futura ne stack 
    mov dx, 0
    
    
Llogarit:
    cmp bx, 1
    je Paraqit
    
    ; Behet llogaritja e faktorielit pra vlera eshte e ruajtur ne ax, e cila shumezohet me bx e cila pas qdo hapi zvogelohet per 1 
    
    dec bx
    mul bx
    jmp Llogarit                 
    
Paraqit:
    mov bx, 10 ; Me pjestu me 10 per me fitu mbetjen
    cmp ax, 9       ; Nese vlera eshte me e madhe se 10 ekzekutohet label NumriShumeShifror
    ja NumriShumeShifror
                   
    mov dx, ax
    add dx, 48       ;
    mov ah, 02h      ; Printimi i nurmit me te vogel se 10
    int 21h          ;    
    jmp Exit
    
NumriShumeShifror:        ; Nese vlera eshte me e vogel se 10, nuk ekzekutohet kjo metode por vetem label Paraqit
    mov dx, 0             ; dx e bejme 0 per shkak se gjate pjestimit mbetja ruhet tek dx
    cmp ax, 0             ; Nese nuk ka mbet me numer per te pjestuar (pra nese eshte 0) shkon te label PrintoNumrinShumeShifror
    je PrintoNumrinShumeShifror
    div bx
    push dx                ; Vleren e dx e ruajme ne stack
    
    inc cx                 ; Sepse kemi dashur ta dijme sa vlera jane ruajtur ne stack
    jmp NumriShumeShifror  ; Kjo label perseritet perderisa ax eshte me e madhe se 0
                  
                  
                  
PrintoNumrinShumeShifror:
    cmp cx, 0        ; Nese nuk kemi me numer per te printuar atehere shko te label Exit
    je Exit
    
    pop dx           ; E marrim vleren e fundit nga Stack e ruajme ne dx, dhe i shtojme 48 per te dalur tek numrat ne ASCII code
    add dx, 48
    
    mov ah, 02h
    int 21h          ; Printimi i numrit
    dec cx           
    mov dx, 0        ;I jepim vleren 0 per t'a bere gati per llogaritjen e ardhshme
    jmp PrintoNumrinShumeShifror  
    
       
Exit:
    ret  
