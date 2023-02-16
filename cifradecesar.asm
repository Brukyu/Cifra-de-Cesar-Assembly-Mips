# Aplicação em assembly MIPS para criptografar uma mensagem com a Cifra de César com deslocamento fornecido pelo usuário

.data
msg:    .space 256      # Espaço para armazenar a mensagem
prompt: .asciiz "Digite a mensagem a ser criptografada: "
keymsg: .asciiz "Digite o deslocamento da Cifra de César: "

.text
.globl main

main:
    # Pede para o usuário digitar a mensagem
    li $v0, 4           # Código do syscall para imprimir string
    la $a0, prompt      # Endereço da mensagem de prompt
    syscall

    # Lê a mensagem digitada pelo usuário
    li $v0, 8           # Código do syscall para ler string
    la $a0, msg         # Endereço do buffer para armazenar a mensagem
    li $a1, 256         # Tamanho máximo da mensagem
    syscall

    # Pede para o usuário digitar o deslocamento da Cifra de César
    li $v0, 4           # Código do syscall para imprimir string
    la $a0, keymsg      # Endereço da mensagem de prompt para o deslocamento
    syscall

    # Lê o deslocamento da Cifra de César digitado pelo usuário
    li $v0, 5           # Código do syscall para ler inteiro
    syscall
    move $s0, $v0       # Salva o deslocamento em $s0

    # Percorre a mensagem e criptografa cada letra
    la $t0, msg         # Endereço da primeira letra da mensagem
loop:
    lb $t1, ($t0)       # Carrega a próxima letra da mensagem em $t1
    beqz $t1, done      # Verifica se chegou ao fim da mensagem
    add $t2, $t1, $s0   # Adiciona o deslocamento ao valor ASCII da letra
    sb $t2, ($t0)       # Armazena a letra criptografada de volta na mensagem
    addi $t0, $t0, 1    # Avança para a próxima letra da mensagem
    j loop              # Volta para o início do loop

done:
    # Imprime a mensagem criptografada
    li $v0, 4           # Código do syscall para imprimir string
    la $a0, msg         # Endereço da mensagem criptografada para imprimir
    syscall

    # Encerra o programa
    li $v0, 10          # Código do syscall para encerrar o programa
    syscall
