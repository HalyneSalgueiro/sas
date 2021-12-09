/*
* PROGRAMA QUE CHECA A MINHA BASE DE CADASTRO PRODUTO
*/

/* Declara o atalho para a minha pasta da AluraPlay */
libname alura "/home/u49194826/AluraPlay";

* Vou checar o meu diretório da Alura;
PROC DATASETS 
	lib=Alura details;
RUN;

* Checa o conteúdo da minha base de cadastro produto;
PROC CONTENTS
	data=alura.cadastro_produto;
RUN;	

* Imprime a minha base de cadastro produto;	
PROC PRINT
	data=alura.cadastro_produto;
RUN;

* Gera as frequencias das variáveis Gênero, Plataforma e Nome;
PROC FREQ
	data=alura.cadastro_produto nlevels;
	table genero plataforma nome;
RUN;

/* Cria uma nova base com a variável de flag de lançamentos */
DATA teste;
set alura.cadastro_produto;

if data > 201606
    then lancamento = 1;
    else lancamento = 0;

if data < 201401
    then antigo = 1;
    else antigo = 0;

RUN;

* Imprime minha nova base;
PROC PRINT
	data=teste;
RUN;

*Gera a tabela de frequência da minha variável de lançamento;
PROC FREQ
    data = teste;
    table lancamento antigo;
RUN;

*Gera a frequencia cruzada das variáveis Gênero e lançamento;	
PROC FREQ
	data=teste;
	table genero*lancamento
	/nocol norow nopercent;
RUN;

*Gera a lista cruzada das variáveis Nome e Gênero;
PROC FREQ
	data=alura.cadastro_produto nlevels;
	*table nome;
	table nome;
	table nome*genero
	/list;
RUN;

/* Salva a minha base intermediária no diretório da AluraPlay*/
DATA alura.cadastro_produto_v2;
set teste;
rename lancamento = flag_lancamento;	
label Genero = "Gênero"	 
	lancamento = "Marca 1 para jogos que são lançamentos e 0 caso contrário";
RUN;

* Checar se minha base "cadastro produto v2" foi criada corretamente;
PROC CONTENTS
	data=alura.cadastro_produto_v2;
RUN;	
