
# CepespR -----------------------------------------------------------------


# 1. Instalando o CepespR -------------------------------------------------

#Para instalar o pacote CepespR e preciso rodar o codigo abaixo apenas uma vez (salvo casos em que ocorra a troca de computador, neste caso, e preciso instalar novamente o pacote):

if (!require("devtools")) install.packages("devtools")
devtools::install_github("Cepesp-Fgv/cepesp-r") 

#Uma vez instalado o CepespR, para carrega-lo e torna-lo viavel para uso e preciso rodar o codigo abaixo toda vez que o RStudio for iniciado:

library(cepespR)


# 2. Explorando as funcoes do CepespR -------------------------------------


##2.1.Para obter detalhes a respeito das caracteristicas individuais dos candidatos que concorreram em uma eleicao especifica, a funcao get_candidates e a indicada:

candidatos_presidente_2014 <- get_candidates(year=2014, position="Presidente")# A ordem da funcao e sempre esta: nome do data frame onde voce quer salvar estas informacoes,nome da funcao e variaveis de interesse

#E se voce esta interessado nas eleicoes para prefeito ocorridas em 2012? Neste caso, e preciso mudar apenas os valores dos parametros da funcao. Veja:

candidatos_prefeitos_2012 <- get_candidates(year=2012, position="Prefeito")#Note que apenas o ano e o nome do cargo foram alterados


##2.2.Para obter detalhes a respeito dos partidos que compuseram as coligacoes em uma eleicao especifica, a funcao get_coalitions e a indicada:

coligacoes_presidente_2014 <- get_coalitions(year=2014, position="Presidente")

#Suponhamos que agora estamos interessados nas coligacoes da eleicao para presidente em 2002. Neste caso, a funcao sera escrita assim:

coligacoes_presidente_2002 <- get_coalitions(year=2002, position="Presidente")


##2.3.Para obter detalhes a respeito do numero de votos de cada candidato em uma eleicao especifica, a funcao get_votos e a indicada:

votos_presidente_2014_mun <- get_votes(year=2014, position="Presidente", regional_aggregation="Municipio")#Note que inserimos um novo parametro nesta funcao, regional_aggregation 

#E se estivessemos interessados em outro tipo de agregacao? Suponhamos que queremos os dados agregados por Estado:

votos_presidente_2014_estad <-get_votes(year=2014, position="Presidente", regional_aggregation="Estado")


##2.4.Para obter detalhes a respeito de uma eleicao especificando-se o cargo, a funcao get_elections e a indicada:

eleicoes_presidente_2014 <- get_elections(year=2014, position="Presidente", regional_aggregation="Municipio", political_aggregation="Candidato")

#E se quisessemos que a agregacao regional fosse por Estado e a agregacao politica por partido? Veja:

eleicoes_presidente_2014_uf <- get_elections(year=2014, position="Presidente", regional_aggregation="Estado", political_aggregation="Partido")


# 3. Filtrando os resultados -----------------------------------------------


#Para limitar os resultados a valores especificos (um estado, um partido ou a um candidato, por exemplo), basta acrescentar os seguintes parametros e altera-los de acordo com o interesse:


eleicoes_presidente_2014_RS <- get_elections(year=2014, position="Presidente", regional_aggregation="Estado", political_aggregation="Partido", state="RS")#Para mostrar apenas os resultados do Rio Grande do Sul

eleicoes_presidente_2014_PT <- get_elections(year=2014, position="Presidente", regional_aggregation="Estado", political_aggregation="Partido", party="13")#Para mostrar apenas os resultados referentes ao PT

eleicoes_deputado_federal_2511 <- get_elections(year=2014, position="Deputado Federal", regional_aggregation="Estado", political_aggregation="Candidato", candidate_number=2511)#Para mostrar apenas os resultados referentes ao candidato 2511


# 4. Selecionando apenas as colunas que me interessam ---------------------

#As funcoes do CepespR retornam todas as colunas disponiveis, mas e possivel limitar o tamanho dos resultados selecionando apenas as colunas de interesse. Veja:


##PASSO 1: Primeiro criamos uma lista com o nome das colunas que desejamos: 

colunas <- list("NUMERO_CANDIDATO", "UF", "QTDE_VOTOS", "COD_MUN_IBGE")

##PASSO 2: Acrescentamos o parametro columns_list a nossa funcao e indicamos a lista criada com o nome das colunas:

votos_pres_2014_new <- get_votes(year="2014", position="Presidente", regional_aggregation="Municipio", columns_list=colunas)


#Outra maneira de selecionar as colunas de interesse e atraves da funcao subset. Para isto, basta:

eleicoes_presidente_2014_2 <- subset(eleicoes_presidente_2014_uf,select= c("SIGLA_PARTIDO", "ANO_ELEICAO"))

#Note que a funcao foi escrita na seguinte ordem: nome do novo data frame+subset+nome do antigo data frame+nome das colunas de interesse

