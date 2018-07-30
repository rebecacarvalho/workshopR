
# CepespR -----------------------------------------------------------------

# O CepespR é um pacote criado para auxiliar o acesso dos usuários a API do CepespData. Por meio
#deste pacote é possível ter um acesso mais rápido e organizado aos dados do TSE a respeito das eleições
#ocorridas no Brasil entres os anos de 1998 e 2016.

# Pensando nisto, este script tem como seu objetivo principal mostrar exemplos de como o pacote CepespR funciona e,
#assim, facilitar a vida dos usuários na hora de utilizar o R. Seguindo a rotina de cógidos abaixo, o usuário ao final 
#deste script terá as consultas realizadas salvas com sucesso em formato ompatível com o excel(.csv).
# 1. Instalando o CepespR -------------------------------------------------

# Para instalar o pacote CepespR é preciso rodar o código abaixo apenas 
#uma vez (apenas em caso de troca de computador é preciso instalar novamente 
#o pacote):

if (!require("devtools")) install.packages("devtools")
devtools::install_github("Cepesp-Fgv/cepesp-r") 

# Uma vez instalado o CepespR, é preciso "ativar" a library toda vez.
# Por isso SEMPRE que for utilizar o CepespData, é necessário rodar o código abaixo:

library(cepespR)


# 2. Explorando as funcoes do CepespR -------------------------------------

# Uma vez carregado o pacote do CepespR, o usuário poderá fazer uso de 4 tipos de funções: 
#get_candidates, get_coalitions, get_votes e get_elections. Cada função mostra
#ao usuário diferentes partes dos dados do TSE, retornando sempre ao final da consulta
#um data frame com os detalhes das eleições. Veja abaixo o que cada função faz:


##2.1.Consultar perfil dos candidatos -----------------------------------

# Para obter detalhes a respeito das características individuais dos candidatos que 
#concorreram em uma eleição específica, a funcao get_candidates é a indicada:

# A função funciona assim:
# base_de_dados<-get_candidates(year= "Ano escolhido", position = "cargo escolhido"). 
# Como no exemplo abaixo:

candidatos_presidente_2014 <- get_candidates(year=2014, position=11)

# Para visualizar os dados do data frame criado usamos a função VIEW

View(candidatos_presidente_2014)

# A ordem da funcao é sempre esta: nome do data frame onde você quer salvar estas 
#informações + nome da função + variáveis de interesse

# Também é possível realizar as consultas indicando os códigos dos cargos.
# Para visualizar quais códigos representam cada cargo, por favor, acesse: 
#https://github.com/Cepesp-Fgv/cepesp-rest/blob/master/EleicoesPorCargo_BETA.md
# Vamos fazer uma consulta usando o código do cargo:

# Suponhamos que estamos interessados nas eleições para prefeito ocorridas em 2012? Neste caso, 
#é preciso mudar apenas os valores dos parâmetros da função. Veja:

candidatos_prefeitos_2012 <- get_candidates(year=2012, position="Prefeito")
# Você também poderia ter escrito "Prefeito" no lugar do código 11, que o resultado seria o mesmo.
# Note que apenas o ano e o nome(código) do cargo foram alterados

View(candidatos_prefeitos_2012)

##2.2.Consultar Coligações ----------------------------------------------

# Para obter detalhes a respeito dos partidos que compuseram as coligacões em 
#uma eleição específica, a funcao get_coalitions é a indicada:

# Ela funciona de forma similar a get_candidates:

coligacoes_presidente_2014 <- get_coalitions(year=2014, position="Presidente")
View(coligacoes_presidente_2014)

# Suponhamos que agora estamos interessados nas coligações da eleição para 
#presidente em 2002. Neste caso, a função será escrita assim:

coligacoes_presidente_2002 <- get_coalitions(year=2002, position="Presidente")
View(coligacoes_presidente_2002)

##2.3.Consultar votos por eleição ---------------------------------------

# Para obter detalhes a respeito do número de votos de cada candidato em uma 
#eleição específica, a funcao get_votos é a indicada:

votos_presidente_2014_mun <- get_votes(year=2014, position="Presidente", regional_aggregation="Municipio")
View(votos_presidente_2014_mun)

# Diferente das funções anteriores, essa função precisa de uma AGREGAÇÃO REGIONAL. 
#Ou seja, você pode escolher a que nível de detalhe você quer ver os dados, se é por seção, municipio, nacional, etc. 
#Os diferentes níveis de agregação disponíveis podem ser consultados em: https://github.com/Cepesp-Fgv/cepesp-r

#E se estivéssemos interessados em ver a agregação por Estado (unidade da federação)?

votos_presidente_2014_estad <-get_votes(year=2014, position="Presidente", regional_aggregation="Estado")
View(votos_presidente_2014_estad)

##2.4.Consultar resultado de eleições por cargo -------------------------

# Além das consultas disponíveis no TSE, é possível fazer uma consulta integrada as eleições.
#Esta consulta agrega informações de candidato, coligações e votos. 
#A consulta ainda está em fase BETA e podem haver pontos de melhoria.

# Para obter detalhes a respeito de uma eleição especificando-se o cargo, 
#use a funcao get_elections:

eleicoes_presidente_2014 <- get_elections(year=2014, position="Presidente", regional_aggregation="Municipio", political_aggregation="Candidato")
View(eleicoes_presidente_2014)

# Esta função permite também consultar o resultado por diferentes agregações: 
#Candidato, Partido, Coligação e Consolidado

# Em resultado consolidado da eleição você pode encontrar dado de comparecimento, votos válidos
#e votos brancos e nulos. Veja:

eleicoes_presidente_2014_consol <- get_elections(year=2014, position="Presidente", regional_aggregation="Estado", political_aggregation="Consolidado")
View(eleicoes_presidente_2014_consol)

# 3. Filtrando os resultados -----------------------------------------------

# Caso você queira restringir sua busca, é possível filtrar na consulta valores específicos

# Para limitar os resultados a valores específicos (um estado, um partido ou a um candidato, por exemplo), 
#basta acrescentar os parâmetros STATE, PARTY ou CANDIDATE_NUMBER e alterá-los de acordo com o interesse

# Para mostrar apenas os resultados do Rio Grande do Sul, por exemplo, acrescente o parâmetro STATE

eleicoes_presidente_2014_RS <- get_elections(year=2014, position="Presidente", regional_aggregation="Estado", political_aggregation="Partido", state="RS")
View(eleicoes_presidente_2014_RS)

# Para mostrar apenas os resultados referentes ao PT, por exemplo, acrescente o parâmetro PARTY

eleicoes_presidente_2014_PT <- get_elections(year=2014, position="Presidente", regional_aggregation="Estado", political_aggregation="Partido", party="13")
View(eleicoes_presidente_2014_PT)
 
# Para mostrar apenas os resultados referentes ao candidato 2511, por exemplo, acrescente o parâmetro CANDIDATE_NUMBER

eleicoes_deputado_federal_2511 <- get_elections(year=2014, position="Deputado Federal", regional_aggregation="Estado", political_aggregation="Candidato", candidate_number=2511)
View(eleicoes_deputado_federal_2511)


# 4. Selecionando apenas as colunas que me interessam ---------------------

# As funçõs do CepespR retornam todas as colunas disponíveis, mas é possivel limitar 
#o tamanho dos resultados selecionando apenas as colunas de interesse. Veja:

## PASSO 1: Primeiro visualizamos quais são as colunas padrões através da função NAMES. Veja:

# Na função get_candidates,por exemplo, as colunas padrões são:

names(get_candidates(year = 2014, position = "Presidente"))

#Note que uma lista de 46 colunas apareceu no seu console. E para as outras funções?

names(get_coalitions(year = 2014, position = "Presidente"))#Lista as colunas da função get_coalition

names(get_votes(year = 2014, position = "Presidente"))#Lista as colunas da função get_votes

names(get_elections(year = 2014, position = "Presidente"))#Lista as colunas da função get_elections

## PASSO 2: Em segundo, criamos uma lista com o nome das colunas que desejamos: 

# Se queremos analisar os dados referentes aos votos, por exemplo, poderíamos
#reduzir nosso data frame a seguintes colunas:

colunas <- list("NUMERO_CANDIDATO", "UF", "QTDE_VOTOS", "COD_MUN_IBGE")

## PASSO 3: Acrescentamos o parâmetro columns_list a nossa função e indicamos a lista criada com o nome das colunas:

votos_pres_2014_new <- get_votes(year="2014", position="Presidente", regional_aggregation="Municipio", columns_list=colunas)
View(votos_pres_2014_new)

# Outra maneira de selecionar as colunas de interesse é através da função SUBSET. Para isto, basta:

eleicoes_presidente_2014_2 <- subset(eleicoes_presidente_2014_uf,select= c("SIGLA_PARTIDO", "ANO_ELEICAO"))
View(eleicoes_presidente_2014_2)

# Note que a função foi escrita na seguinte ordem: nome do novo data frame+subset+nome do antigo data frame+
#nome das colunas de interesse


# 5. Salvando os resultados -----------------------------------------------

# Para salvar os data frames gerados neste script em formato .csv, basta usar a função abaixo:

# A função está organizada da seguinte maneira:
# write.csv2(nome do data frame que quero exportar, nome que quero dar ao meu arquivo .csv)

write.csv2(eleicoes_presidente_2014, "eleicoes_presidente_2014.csv")


# 6. Analisando os resultados ---------------------------------------------


