
;GRUPO: MATHEUS AMORIM, PEDRO FIGUEIRÊDO, RAFAEL PRAXEDES, SANDOVAL NETO, THIAGO WESLEY

pilha   segment stack
	db      128 dup(?)      ;inicia
pilha   ends

dados   segment
mens1   db      'Digite o numero de notas para calculo da media (1 a 5):#'
mens2   db      'Digite a primeira nota (numeros de 0 a 100):#'
mens3   db      'Digite a segunda nota (numeros de 0 a 100):#'
mens4   db      'Digite a terceira nota (numeros de 0 a 100):#'
mens5   db      'Digite a quarta nota (numeros de 0 a 100):#'
mens6   db      'Digite a quinta nota (numeros de 0 a 100):#'
mens7   db      'Digite a nota da final (numeros de 0 a 100):#'
mens8   db      'Media:#'
mens9   db      'Aluno Aprovado#'
mens10  db      'Aluno em Exame Final#'
mens11  db      'Aluno Reprovado#'
mens12  db      'Deixe de ser burro, digite um numero de 1 a 5!#'
mens13  db      'Deixe de ser burro, digite um numero!#'
mens14  db      'Aluno foi pra final precisando de: #'


nnotas  db      0
nota1   db      3 dup(0)
nota2   db      3 dup(0)
nota3   db      3 dup(0)
nota4   db      3 dup(0)
nota5   db      3 dup(0)
notaF   db      3 dup(0)
MediaF  db      3 dup(0)
; Variáveis usadas na conversão
resto db  3 dup(0)
numConv db      3 dup(0)
var1 db 3 dup(?)
var2 db 3 dup(?)
var3 db 3 dup(?)
;Variável usada no calculo da média
sumMed  dw      0
dados ends

codigo  segment
	assume  ss:pilha, cs:codigo, ds:dados, es:dados
teste   proc    far
	push    ds
	xor     ax,ax
	push    ax
	mov     ax,dados
	mov     ds,ax
	mov     es,ax   ;ds e es segmento de dados com valor dados
	call    limpa
	mov     dx,0
	call    pos
	lea     bx, mens1
	mov     cl,1d
	call	exibe_1
bola1: call tec ;chama rotina do teclado
       cmp al,0dh
       jz atalhoFim1 ; Digitou Enter
       call video
       cmp al,31h ; maior que 1
       jl bola3
       cmp al,35h ; menor que 5
       jg bola3
       mov nnotas,al
       dec cl
       jz  PromptNota1
       jmp bola1
bola3: mov al,0dh
       call video
       mov al,0ah
       call video
       lea bx,mens12
       call exibe_1
	mov     al,0dh
	call    video
	mov     al,0ah
	call    video
    jmp     bola1

atalhoFim1:
    jmp fim

erroNotas:
    ;exibe mensagem de erro
    mov al,0dh
    call video
    mov al,0ah
    call video
    lea bx,mens13
    call exibe_1
    mov     al,0dh
    call    video
    mov     al,0ah
    call    video

    ;seta cl para 3, para ler o numero de 3 algarismos
    mov cl, 3d

    ;se for nota1
    cmp dl, 1h
    jz  atalhoNota1

    ;se for nota2
    cmp dl, 2h
    jz  atalhoNota2

    ;se for nota3
    cmp dl, 3h
    jz  atalhoNota3

    ;se for nota4
    cmp dl, 4h
    jz  atalhoNota4

    ;se for nota4
    cmp dl, 5h
    jz  atalhoNota5

    ;se dl nao for de nenhuma nota
    jmp fim

atalhoNota1:
    lea di, nota1
    jmp PedeNota1
atalhoNota2:
    lea di, nota2
    jmp PedeNota2
atalhoNota3:
    lea di, nota3
    jmp PedeNota3
atalhoNota4:
    lea di, nota4
    jmp PedeNota4
atalhoNota5:
    lea di, nota5
    jmp PedeNota5


PromptNota1:
    mov al,0dh
    call video
    mov al,0ah
    call video
;escrever mensagem na tela
    lea     bx, mens2
    mov     cl,3d
    call	exibe_1
    lea di, nota1

PedeNota1:
    call tec ;chama rotina do teclado
    cmp al,0dh
    jz atalhoFim1 ; Digitou Enter
    call video
    mov dl, 1h ; Armazena informação da nota atual
    cmp al,30h ; maior que 0
    jl erroNotas
    cmp al,39h ; menor que 9
    jg erroNotas
    cmp cl, 3
    je Digito1Nota1
DigitoOKNota1:
    mov [di],al
    inc di
    dec cl
    jz  ChecagemNnotas1
    jmp PedeNota1

Digito1Nota1:
    cmp al, 30h
    je  DigitoOKNota1
    ;Atribui100Nota1
    lea di, nota1
    mov al, 31h
    mov [di], al
    inc di
    mov al, 30h
    mov [di], al
    inc di
    mov al, 30h
    mov [di], al
    inc di
    jmp ChecagemNnotas1

ChecagemNnotas1:
    ;Adicionar nota1 à soma de médias
    lea si, nota1;
    call CONVERTE_ASCII_BIN
    mov al, [di]
    add sumMed, ax
    ;Checando se há mais notas
    mov al, nnotas
    cmp al, 31h
    jg PromptNota2
    jmp CalculoMedia

atalhoFim2:
    jmp fim

atalhoErroNotas2:
    jmp erroNotas

PromptNota2:
    mov al,0dh
    call video
    mov al,0ah
    call video
;escrever mensagem na tela
    lea     bx, mens3
    mov     cl,3d
    call	exibe_1
    lea di, nota2

PedeNota2:
    call tec ;chama rotina do teclado
    cmp al,0dh
    jz atalhoFim2 ; Digitou Enter
    call video
    mov dl, 2h ; Armazena informação da nota atual
    cmp al,30h ; maior que 0
    jl atalhoErroNotas2
    cmp al,39h ; menor que 9
    jg atalhoErroNotas2
    cmp cl, 3
    je Digito1Nota2
DigitoOKNota2:
    mov [di],al
    inc di
    dec cl
    jz  ChecagemNnotas2
    jmp PedeNota2

Digito1Nota2:
    cmp al, 30h
    je  DigitoOKNota2
    ;Atribui100Nota2
    lea di, nota2
    mov al, 31h
    mov [di], al
    inc di
    mov al, 30h
    mov [di], al
    inc di
    mov al, 30h
    mov [di], al
    inc di
    jmp ChecagemNnotas2

ChecagemNnotas2:
    ;Adicionar nota2 à soma de médias
    lea si, nota2;
    call CONVERTE_ASCII_BIN
    mov al, [di]
    add sumMed, ax
    ;Checando se há mais notas
    mov al, nnotas
    cmp al, 32h
    jg PromptNota3
    jmp CalculoMedia

atalhoFim3:
    jmp fim

atalhoErroNotas3:
    jmp erroNotas

PromptNota3:
    mov al,0dh
    call video
    mov al,0ah
    call video
;escrever mensagem na tela
    lea     bx, mens4
    mov     cl,3d
    call	exibe_1
    lea di, nota3

PedeNota3:
    call tec ;chama rotina do teclado
    cmp al,0dh
    jz atalhoFim3 ; Digitou Enter
    call video
    mov dl, 3h ; Armazena informação da nota atual
    cmp al,30h ; maior que 0
    jl atalhoErroNotas3
    cmp al,39h ; menor que 9
    jg atalhoErroNotas3
    cmp cl, 3
    je Digito1Nota3
DigitoOKNota3:
    mov [di],al
    inc di
    dec cl
    jz  ChecagemNnotas3
    jmp PedeNota3

Digito1Nota3:
    cmp al, 30h
    je  DigitoOKNota3
    ;Atribui100Nota3
    lea di, nota3
    mov al, 31h
    mov [di], al
    inc di
    mov al, 30h
    mov [di], al
    inc di
    mov al, 30h
    mov [di], al
    inc di
    jmp ChecagemNnotas3

ChecagemNnotas3:
    ;Adicionar nota3 à soma de médias
    lea si, nota3;
    call CONVERTE_ASCII_BIN
    mov al, [di]
    add sumMed, ax
    ;Checando se há mais notas
    mov al, nnotas
    cmp al, 33h
    jg PromptNota4
    jmp CalculoMedia

atalhoFim4:
    jmp fim

atalhoErroNotas4:
    jmp erroNotas

PromptNota4:
    mov al,0dh
    call video
    mov al,0ah
    call video
    ;escrever mensagem na tela
    lea     bx, mens5
    mov     cl,3d
    call	exibe_1
    lea di, nota4

    PedeNota4:
    call tec ;chama rotina do teclado
    cmp al,0dh
    jz atalhoFim4 ; Digitou Enter
    call video
    mov dl, 4h ; Armazena informação da nota atual
    cmp al,30h ; maior que 0
    jl atalhoErroNotas4
    cmp al,39h ; menor que 9
    jg atalhoErroNotas4
    cmp cl, 3
    je Digito1Nota4
DigitoOKNota4:
    mov [di],al
    inc di
    dec cl
    jz  ChecagemNnotas4
    jmp PedeNota4

Digito1Nota4:
    cmp al, 30h
    je  DigitoOKNota4
    ;Atribui100Nota4
    lea di, nota4
    mov al, 31h
    mov [di], al
    inc di
    mov al, 30h
    mov [di], al
    inc di
    mov al, 30h
    mov [di], al
    inc di
    jmp ChecagemNnotas4

ChecagemNnotas4:
    ;Adicionar nota4 à soma de médias
    lea si, nota4;
    call CONVERTE_ASCII_BIN
    mov al, [di]
    add sumMed, ax
    ;Checando se há mais notas
    mov al, nnotas
    cmp al, 34h
    jg PromptNota5
    jmp CalculoMedia

atalhoFim5:
    jmp fim

atalhoErroNotas5:
    jmp erroNotas

PromptNota5:
    mov al,0dh
    call video
    mov al,0ah
    call video
    ;escrever mensagem na tela
    lea     bx, mens6
    mov     cl,3d
    call	exibe_1
    lea di, nota5

PedeNota5:
    call tec ;chama rotina do teclado
    cmp al,0dh
    jz atalhoFim5 ; Digitou Enter
    call video
    mov dl, 4h ; Armazena informação da nota atual
    cmp al,30h ; maior que 0
    jl atalhoErroNotas5
    cmp al,39h ; menor que 9
    jg atalhoErroNotas5
    cmp cl, 3
    je Digito1Nota5
DigitoOKNota5:
    mov [di],al
    inc di
    dec cl
    jz  ChecagemNnotas5
    jmp PedeNota5

Digito1Nota5:
    cmp al, 30h
    je  DigitoOKNota5
    ;Atribui100Nota5
    lea di, nota5
    mov al, 31h
    mov [di], al
    inc di
    mov al, 30h
    mov [di], al
    inc di
    mov al, 30h
    mov [di], al
    inc di
    jmp ChecagemNnotas5

ChecagemNnotas5:
    ;Adicionar nota5 à soma de médias
    lea si, nota5;
    call CONVERTE_ASCII_BIN
    mov al, [di]
    add sumMed, ax
    jmp CalculoMedia

CalculoMedia:
    ;Conversão de nnotas para binário
    mov al, nnotas
    sub al, 30h
    ;Divide-se a soma das notas pelo número de notas
    mov nnotas, al
    xor al,al
    mov ax, sumMed
    mov bl, nnotas
    div bl
    ;Mostra mensagem de acordo com situação do aluno
    cmp ah, 0d
    jnz JumpArrendonda
AnalisaSituacaoAluno:
    mov sumMed, ax

    mov al,0dh
    call video
    mov al,0ah
    call video
    ;escrever mensagem na tela
    lea     bx, mens8
    call	exibe_1

    mov ax, sumMed
    call convba
    mov al, var3
    call video
    mov al, var2
    call video
    mov al, var1
    call video

    mov ax, sumMed
    cmp al, 070d
    jge AlunoAprovado
    cmp al, 040d
    jl AlunoReprovado
AlunoEmFinal:
    mov al,0dh
    call video
    mov al,0ah
    call video
    ;escrever mensagem na tela
    lea     bx, mens10
    call	exibe_1
    jmp CalculaPontuacaoNaFinal

JumpArrendonda:
    jmp Arrendonda

AlunoAprovado:
    mov al,0dh
    call video
    mov al,0ah
    call video
    ;escrever mensagem na tela
    lea     bx, mens9
    call	exibe_1
    jmp fim
AlunoReprovado:
    mov al,0dh
    call video
    mov al,0ah
    call video
    ;escrever mensagem na tela
    lea     bx, mens11
    call	exibe_1
    jmp fim

CalculaPontuacaoNaFinal:
    mov bx, 500d
    mov ax, sumMed
    mov dl, 6d
    mul dl
    sub bx, ax
    mov dl, 4d
    mov ax, bx
    div dl
    mov cx, ax

    mov al,0dh
    call video
    mov al,0ah
    call video
    ;escrever mensagem na tela
    lea     bx, mens14
    call	exibe_1

    mov ax, cx
    jmp ArrendondaNotaFinal

PosArredondar:
    call convba

    mov al, var3
    call video

    mov al, var2
    call video

    mov al, var1
    call video

    jmp fim

ArrendondaNotaFinal:
    mov bl, al
    mov al, ah
    xor ah, ah
    mov dl, 2d
    mul dl
    cmp al, nnotas
    jge ArrendondaNotaFinalCima
; Arredonda Nota Final Para baixo
    mov al, bl
    jmp PosArredondar
ArrendondaNotaFinalCima:
    mov al, bl
    add al, 1d
    jmp PosArredondar

Arrendonda:
    mov bl, al
    mov al, ah
    xor ah, ah
    mov dl, 2d
    mul dl
    cmp al, nnotas
    jge ArredondaParaCima
    ; Arredonda Para baixo
    mov al, bl
    jmp AnalisaSituacaoAluno
ArredondaParaCima:
    mov al, bl
    add al, 1d
    jmp AnalisaSituacaoAluno


fim:
    ret
teste   endp

exibe_1	proc	near
	mov     al,[bx]
	cmp     al,'#'
	jz      bola2
	call    video; exibe a mensagem por caracter
	inc     bx
	jmp     exibe_1
bola2:	ret
exibe_1	endp

video   proc    near
	push    si
	push    bx
	push    di
	push    cx
	mov     bx,0
	mov     ah,14
	int     10h
	pop     cx
	pop     di
	pop     bx
	pop     si
	ret
video   endp

;dl,dh posiciona o cursor
pos proc near
    push AX
    push BX
    push cx
    xor BX,BX
    mov AH,2
    int 10h
    pop cx
    pop bx
    pop ax
    ret
pos endp

tec     proc    near
	push    di
	push    bx
	push    si
	push    cx
	mov     ah,0
	int     16h
	pop     cx
	pop     si
	pop     bx
	pop     di
	ret
tec     endp

limpa proc near
      push AX
      push BX
      push CX
      push DX
      xor al,al ; numero de linhas a rolar(0 significa todas as linhas)
      xor cx,cx ; cl = coluna do canto superior esquerdo, ch = linha do canto superior esquerdo
      mov dh,24 ; dh = linha do canto inferior direito
      mov dl,79 ; dl = coluna do canto inferior direito
      mov bh,07h; bh = atributo a ser usado nas linhas que ficarem em branco
      mov ah,06 ;rola a pagina de vÌdeo ativa para cima
      int 10h
      pop DX
      pop CX
      pop BX
      pop AX
      ret
limpa endp

;------------- Converte de ASCII para Bin·rio ---------------;

CONVERTE_ASCII_BIN PROC NEAR

    lea di, numConv
    mov cl, 1


SUBTRACAO:
    mov al, [si]
    mov bl, 3
    sub al, 30h
    sub bl, cl
    cmp bl, 0
    jz FIMASCIIBIN

MULT10:
    mov dl, 10d
    mul dl
    dec bl
    cmp bl, 0
    jnz MULT10
    mov [di], al
    inc cl
    inc si
    inc di
    jmp SUBTRACAO

FIMASCIIBIN:
    mov [di], al
    lea di, numConv
    lea si, numConv
    mov cl, 1

SOMA:
    cmp cl, 3
    je retornaASCIIBin
    inc si
    mov dl, [si]
    add [di], dl
    inc cl
    jmp SOMA

retornaASCIIBin:
    ret

CONVERTE_ASCII_BIN ENDP

;conversão de BINARIO para ASCII
convba proc near
mov bl, 10
div bl
add ah, 30h
mov var1, ah
mov ah,0
div bl
add ah, 30h
mov var2, ah
mov ah, 0
div bl
add ah, 30h
mov var3, ah
ret
convba endp

codigo  ends
	end     teste
