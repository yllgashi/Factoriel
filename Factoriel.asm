org 100h

.data
    newLine db 0ah, 0dh,"$"
    description db "Type a number: $"
    message db "Result is: $" 

.code
    mov dx, offset description
    mov ah, 09h                  ; Description for writing a number
    int 21h 
    
    mov ah, 01h    
    int 21h                     ; Write a number                  
    mov bl, al                  ; Value is stored in bx register, respectively in bl
    sub bx, 30h                 ; Substract value in bx with 30h (there are numbers in ASCII code)
                                                              
    mov dx,offset newLine       ;
    mov ah, 09h                 ; New Line
    int 21h
                               
    mov dx, offset message
    mov ah, 09h 
    int 21h                     ; Print message
    mov ax, bx
   
    mov cx, 0                   ; Counter is used to count elements in stack
    mov dx, 0
    
    
Calculate:
    cmp bx, 1
    je Show   
                                ; Value is stored in ax register   
    dec bx
    mul bx
    jmp Calculate                 
    
Show:
    mov bx, 10                  ; Divide by 10 to store modulus in another register
    cmp ax, 9                   ; If value is greater than 10, call method "MultiDigit"
    ja MultiDigit
                   
    mov dx, ax
    add dx, 48
    mov ah, 02h                 ; Print number who is less than 10
    int 21h  
    jmp Exit
    
MultiDigit:                     ; If factoriel calculation is smaller than 10, this method does not execute
    mov dx, 0                   ; Changing dx value with 0, because dx is needed at next step
    cmp ax, 0                   ; If there is not another number to divide, call method PrintMultiDigitNumber
    je PrintMultiDigitNumber
    div bx
    push dx                     ; Store value of dx in stack
    
    inc cx                      ; For counting all elements in stack
    jmp MultiDigit              ; Repeat this method while ax is greater than 0
                  
                  
                  
PrintMultiDigitNumber:
    cmp cx, 0                   ; If there is not any number to print, call method Exit
    je Exit
    
    pop dx                      ; Pop value from stack, store in dx register, and add 48 (because there are numbers in ASCII code)
    add dx, 48
    
    mov ah, 02h
    int 21h                     ; Print number
    dec cx           
    mov dx, 0                   ; Reset dx for next calculation
    jmp PrintMultiDigitNumber  
    
       
Exit:
    ret  
