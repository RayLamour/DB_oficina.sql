#  Oficina Mecânica – Banco de Dados Relacional

Projeto desenvolvido como parte de um desafio de modelagem e implementação de banco de dados.  
O objetivo é criar um sistema de **controle de ordens de serviço (OS) em uma oficina mecânica**, desde o modelo lógico até a execução de queries complexas em MySQL.

---

##  Estrutura do Projeto

O sistema gerencia:
- **Clientes** e seus **veículos**  
- **Equipes** e **mecânicos** especializados  
- **Ordens de serviço (OS)**, incluindo serviços e peças utilizados  
- Catálogo de **serviços de referência** e **peças**  

---

## Modelo Relacional (Lógico)

**Entidades principais:**
- Cliente  
- Veículo  
- Equipe  
- Mecânico  
- Ordem de Serviço  
- Serviços de referência  
- Peças  

Relacionamentos:
- Cliente → Veículo → Ordem de Serviço  
- Equipe → Mecânico → Ordem de Serviço  
- Ordem de Serviço ↔ Serviços (N:N)  
- Ordem de Serviço ↔ Peças (N:N)  

---

## Scripts SQL

### 1. Criação do Banco de Dados
-  create_tables.sql
Contém a definição de todas as tabelas com chaves primárias, estrangeiras e relacionamentos.

### 2. Inserção de Dados de Teste
- insert_data.sql`  
Inclui:
- 8 clientes com veículos  
- 4 equipes com mecânicos  
- Catálogo de serviços e peças  
- 8 ordens de serviço preenchidas com dados reais de teste  

### 3. Consultas SQL
Consultas para responder perguntas de negócio, incluindo:
- Lista de clientes e seus veículos  
- Total gasto por cliente  
- Serviços mais executados  
- Peças que mais geram receita  
- OS com valor acima de R$ 1000,00  
- Equipes mais ocupadas  
- Clientes com OS em aberto  
- Média de valor das OS concluídas  
- Mecânicos por equipe  

---

##  Como Usar

Clone o repositório anexo no seu MySQL

---

## Tecnologias utilizadas
- MySQL 8.0+
-	Modelagem com Modelo ER → Modelo Relacional
-	Scripts SQL (DDL, DML, DQL)
