# Calculadora

## User Story 1 - Operações Básicas Adição / Subtração / Multiplicação / Divisão

**Como** caixa do mercadinho
**Eu quero** fazer contas básicas no celular
**Para** cobrar os clientes

**Definition of Done:**
 - [ ] Considero aceito se for possível fazer contas inteiras ou decimais com resultados de até 9 dígitos na seguinte ordem:
>1) Entrada do primeiro número
>2) Seleção da operação
>3) Entrada do segundo número
>4) Botão "="

## User Story 2 - Limpeza de valores

**Como** caixa do mercadinho
**Eu quero** poder limpar os valores sem fechar a calculadora
**Para** ganhar tempo

**Definition of Done:**
 - [ ] Tecla AC (all clear) limpa toda a expressão
 - [ ] Tecla C (clear) limpa apenas o último valor inserido

## User Story 3 - Erro

**Como** caixa do mercadinho
**Eu quero** saber de forma clara quando houver algum erro na operação 
**Para** não passar para o cliente algum valor equivocado

**Definition of Done:**
 - [ ] Aparecer a mensagem "Erro" (ex: divisão por zero)

## User Story 4 - Número Negativos

**Como** estudante universitário
**Eu quero** fazer contas com números negativos
**Para** resolver os exercícios 

**Definition of Done:**
 - [ ] Botão +/- que transforma o número apresentado em negativo ou em positivo (no caso de já estar como negativo)

## User Story 5 - Porcentagem

**Como** caixa do mercadinho
**Eu quero** fazer contas de porcentagem
**Para** dar desconto para os clientes preferenciais

**Definition of Done:**
 - [ ] 
 
 ## User Story 10 - Coding Style

**Como** tech lead
**Eu quero** garantir que o código tenha o mesmo estilo independentemente do desenvolvedor
**Para** garantir a legibilidade, manutenibilidade e escalabilidade do código

**Definition of Done:**

 - [ ] Haver uma ferramenta de análise estática com mesmas regras para todos os desenvolvedores

---
### Não priorizadas na primeira sprint:

## User Story 6 - Repetição da última operação

**Como** caixa do mercadinho
**Eu quero** poder repetir infinitamente a última operação com um único toque
**Para** ganhar tempo

**Definition of Done:**
 - [ ] Tecla "=" deve ser considerada como "repetir a última operação"


## User Story 7 - Operações em sequência

**Como** caixa do mercadinho
**Eu quero** poder fazer várias operações em sequência 
**Para** ganhar tempo e saber os resultados parciais

**Definition of Done:**

- [ ] Assim que qualquer tecla de operação for selecionada, deve aparecer o resultado da operação anterior no display.
Exemplos: 

2 + 4 * 5, deve aparecer o resultado 20 no display e só após pressionar =, aparecer 22
4 * 5 + 2 + 4, deve aparecer o resultado 6 no display e só após pressionar =, aparecer 26


## User Story 8 - Localização / Idioma

**Como** desenvolvedor da calculadora
**Eu quero** publicar o app em todos os países 
**Para** ter meu trabalho conhecido

**Definition of Done:**

- [ ] Separação de milhar de acordo com localização do dispositivo (ex: ponto para pt-br e vírgula para en-us)
- [ ] Separação de decimal de acordo com localização do dispositivo (ex: ponto para pt-br e vírgula para en-us)
- [ ] Mensagem de erro localizada ("Erro" para pt-br, "Error" para en-us e es-ar)
  
## User Story 9 - Números Grandes / Notação científica

**Como** estudante de engenharia
**Eu quero** fazer contas com numeros grandes
**Para** fazer os laboratórios

**Definition of Done:**
 - [ ] Valores menores de -999.999.999 , maiores de +999.999.999 ou com parte inteira 0 (zero) e mais de 8 casas decimais não poderão ser inseridos pelo usuário. No entanto,  deverão ser apresentados em notação científica caso sejam resultado de operação.
 - [ ] Resultados em notação científica devem ter um limite de 8 dígitos
 
##
Documento escrito com ajuda do [Stackedit](https://stackedit.io/app)
