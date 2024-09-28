# TechChallenge FIAP - G24 FASE 3


## Grupo 24 - Integrantes
💻 *<b>RM355456</b>*: Franciele de Jesus Zanella Ataulo </br>
💻 *<b>RM355476</b>*: Bruno Luis Begliomini Ataulo </br>
💻 *<b>RM355921</b>*: Cesar Pereira Moroni </br>



## Nome Discord:
Franciele RM 355456</br>
Bruno - RM355476</br>
Cesar P Moroni RM355921</br>


## Amazon RDS
Este repositório é responsável por configurar toda a infraestrutura do nosso banco de dados na nuvem da AWS utilizando o Amazon RDS, por meio do TerraForm. Esse banco será utilizado pela aplicação LancheRapido.

O provisionamento de todos os recursos é executado via GitHub Actions com base nos arquivos Terraform.

## Razões para Utilizar o SQL server
- Suporta diversas linguagens de programação;
- Alta segurança, possui ferramentas como criptografia e autenticação multifator;
- Alto desempenho, mesmo com grande volume de dados e consultas frequentes;
- O SQL server é amplamente utilizado em sistemas de gerenciamento de bancos de dados (SGBD).

## Escolha do banco
O Amazon RDS oferece um ambiente completamente gerenciado para bancos de dados relacionais, simplificando a administração sem comprometer as funcionalidades. Optamos por um banco de dados relacional devido às seguintes vantagens:
- Armazenamento e recuperação de dados de forma flexível;
- Facilidade na manipulação de dados;
- Permite criar novas estruturas sem impactar as existentes;
- Alta performance nas consultas de dados.



## MER
![Modelo Entidade Relacionamento](assets/MER%20github.png)


## Observação
Para atualizar o RDS crie um pull request da branch utilizada para a "main", assim que realizar o merge, o github actions fará toda a atualizanção para o serviço do AWS.

## Requisitos técnicos
* Conta aws</br>
   AWS_ACCESS_KEY_ID=[id da chave]</br>
   AWS_SECRET_ACCESS_KEY=[chave secreta]
