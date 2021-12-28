O padrão do SAS é sempre ordenar as bases de forma crescente (do menor ao maior valor). Mas se o objetivo é ordenar uma base de forma decrescente, basta colocar, antes do nome da variável a ser ordenada, o termo descending (“descendente” em inglês), como no exemplo abaixo, que ordena a base de clientes pelo CPF de forma descendente.
PROC SORT
  data=alura.cadastro_cliente_v3;
  by descending CPF;
RUN;COPIAR CÓDIGO
Podemos usar o comando in em ambas as bases a serem criadas se desejarmos fazer filtros que dependam de ambas as bases. No exemplo em que desejamos cruzar a base de operações com a base de produtos, se queremos manter apenas os jogos que estão presentes em ambas as bases para evitar criar uma base com jogos não alugados ou com aquela observação problemática da base de operações, poderíamos, por exemplo, usar o código abaixo:
DATA jogos_alugados;
merge alura.operacoes_201709 (in=A)
  alura.cadastro_produto_v3
  (in=B rename=(Numero=COD_PRODUTO));
by COD_PRODUTO;
if A and B;
RUN;
