-- Criação das Tabelas

CREATE DATABASE oficina_mecanica;
USE oficina_mecanica;

-- Cliente
CREATE TABLE cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    documento VARCHAR(20),
    telefone VARCHAR(20),
    email VARCHAR(120),
    endereco VARCHAR(200),
    criado_em DATETIME,
    atualizado_em DATETIME
);

-- Veículo
CREATE TABLE veiculo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    placa VARCHAR(10) NOT NULL UNIQUE,
    chassi VARCHAR(25),
    marca VARCHAR(40),
    modelo VARCHAR(60),
    ano INT,
    cor VARCHAR(20),
    FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

-- Equipe
CREATE TABLE equipe (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(80),
    nota TEXT
);

-- Mecânico
CREATE TABLE mecanico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    endereco VARCHAR(200),
    especialidade VARCHAR(80),
    equipe_id INT,
    FOREIGN KEY (equipe_id) REFERENCES equipe(id)
);

-- Ordem de Serviço
CREATE TABLE ordem_servico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    veiculo_id INT NOT NULL,
    equipe_id INT NOT NULL,
    data_emissao DATETIME NOT NULL,
    data_prevista_conclusao DATETIME,
    status VARCHAR(20),
    valor_total DECIMAL(12,2),
    autorizado BOOLEAN,
    data_autorizacao DATETIME,
    observacoes TEXT,
    FOREIGN KEY (veiculo_id) REFERENCES veiculo(id),
    FOREIGN KEY (equipe_id) REFERENCES equipe(id)
);

-- Catálogo de Serviços
CREATE TABLE servico_ref (
    id INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(120) NOT NULL,
    valor_mao DECIMAL(10,2) NOT NULL
);

-- Serviços na OS
CREATE TABLE os_servico (
    os_id INT NOT NULL,
    servico_ref_id INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    valor_unit_mao DECIMAL(10,2) NOT NULL,
    desconto DECIMAL(10,2),
    subtotal DECIMAL(12,2),
    PRIMARY KEY (os_id, servico_ref_id),
    FOREIGN KEY (os_id) REFERENCES ordem_servico(id),
    FOREIGN KEY (servico_ref_id) REFERENCES servico_ref(id)
);

-- Peças
CREATE TABLE peca (
    id INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(120) NOT NULL,
    preco_ref DECIMAL(10,2) NOT NULL
);

-- Peças na OS
CREATE TABLE os_peca (
    os_id INT NOT NULL,
    peca_id INT NOT NULL,
    quantidade INT NOT NULL,
    valor_unit DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(12,2),
    PRIMARY KEY (os_id, peca_id),
    FOREIGN KEY (os_id) REFERENCES ordem_servico(id),
    FOREIGN KEY (peca_id) REFERENCES peca(id)
);

-- Inserção dos dados na tabela para testes

-- Clientes
INSERT INTO cliente (nome, documento, telefone, email, endereco, criado_em)
VALUES 
('João Silva', '12345678900', '81999999999', 'joao@email.com', 'Rua A, Recife', NOW()),
('Maria Oliveira', '98765432100', '81988888888', 'maria@email.com', 'Rua B, Recife', NOW()),
('Carlos Pereira', '32165498700', '81977777777', 'carlos@email.com', 'Rua C, Recife', NOW()),
('Ana Souza', '65498732100', '81966666666', 'ana@email.com', 'Rua D, Olinda', NOW()),
('Lucas Santos', '74185296300', '81955555555', 'lucas@email.com', 'Rua E, Jaboatão', NOW()),
('Fernanda Lima', '85296374100', '81944444444', 'fernanda@email.com', 'Rua F, Paulista', NOW()),
('Roberto Almeida', '96374185200', '81933333333', 'roberto@email.com', 'Rua G, Recife', NOW()),
('Juliana Costa', '14725836900', '81922222222', 'juliana@email.com', 'Rua H, Olinda', NOW());

-- Veículos (cada cliente com 1 veículo)
INSERT INTO veiculo (cliente_id, placa, marca, modelo, ano, cor)
VALUES 
(1, 'ABC1234', 'Fiat', 'Uno', 2010, 'Prata'),
(2, 'XYZ9876', 'Toyota', 'Corolla', 2018, 'Preto'),
(3, 'KLM4321', 'Chevrolet', 'Onix', 2020, 'Branco'),
(4, 'QWE9876', 'Hyundai', 'HB20', 2019, 'Vermelho'),
(5, 'RTY1234', 'Volkswagen', 'Gol', 2012, 'Cinza'),
(6, 'UIO5678', 'Honda', 'Civic', 2017, 'Azul'),
(7, 'ASD2468', 'Renault', 'Duster', 2021, 'Verde'),
(8, 'ZXC1357', 'Ford', 'Ka', 2014, 'Preto');

-- Equipes
INSERT INTO equipe (nome, nota) VALUES
('Equipe Alfa', 'Especializada em motores'),
('Equipe Beta', 'Especializada em elétrica'),
('Equipe Gama', 'Especializada em suspensão'),
('Equipe Delta', 'Especializada em freios');

-- Mecânicos
INSERT INTO mecanico (nome, especialidade, equipe_id)
VALUES 
('Carlos Souza', 'Motor', 1),
('Paulo Santos', 'Elétrica', 2),
('Marcos Oliveira', 'Suspensão', 3),
('Ricardo Alves', 'Freios', 4),
('Diego Ramos', 'Motor', 1),
('Felipe Rocha', 'Elétrica', 2);

-- Serviços de referência
INSERT INTO servico_ref (descricao, valor_mao) VALUES
('Troca de óleo', 100.00),
('Alinhamento', 150.00),
('Revisão completa', 500.00),
('Troca de freios', 250.00),
('Troca de bateria', 120.00);

-- Peças
INSERT INTO peca (descricao, preco_ref) VALUES
('Filtro de óleo', 40.00),
('Pneu', 350.00),
('Bateria', 500.00),
('Pastilha de freio', 200.00),
('Amortecedor', 400.00);

-- Ordens de serviço
INSERT INTO ordem_servico (veiculo_id, equipe_id, data_emissao, status, autorizado)
VALUES
(1, 1, NOW(), 'concluido', TRUE),
(2, 2, NOW(), 'em_execucao', TRUE),
(3, 3, NOW(), 'aberto', FALSE),
(4, 4, NOW(), 'em_execucao', TRUE),
(5, 1, NOW(), 'concluido', TRUE),
(6, 2, NOW(), 'aberto', FALSE),
(7, 3, NOW(), 'concluido', TRUE),
(8, 4, NOW(), 'em_execucao', TRUE);

-- Serviços executados nas OS
INSERT INTO os_servico (os_id, servico_ref_id, quantidade, valor_unit_mao, desconto, subtotal)
VALUES 
(1, 1, 1, 100.00, 0, 100.00),
(1, 2, 1, 150.00, 10.00, 140.00),
(2, 3, 1, 500.00, 50.00, 450.00),
(3, 5, 1, 120.00, 0, 120.00),
(4, 4, 1, 250.00, 0, 250.00),
(5, 1, 1, 100.00, 0, 100.00),
(6, 2, 1, 150.00, 0, 150.00),
(7, 3, 1, 500.00, 100.00, 400.00),
(8, 4, 1, 250.00, 0, 250.00);

-- Peças usadas nas OS
INSERT INTO os_peca (os_id, peca_id, quantidade, valor_unit, subtotal)
VALUES
(1, 1, 1, 40.00, 40.00),
(1, 2, 2, 350.00, 700.00),
(2, 3, 1, 500.00, 500.00),
(3, 3, 1, 500.00, 500.00),
(4, 4, 2, 200.00, 400.00),
(5, 1, 1, 40.00, 40.00),
(6, 5, 2, 400.00, 800.00),
(7, 2, 4, 350.00, 1400.00),
(8, 4, 1, 200.00, 200.00);


-- Queries (Consultas)

-- Recuperação simples
SELECT nome, telefone, email FROM cliente;

-- Ordenação
SELECT * FROM ordem_servico
ORDER BY data_emissao DESC;


--  Quais são os clientes cadastrados e seus veículos?
SELECT c.nome AS cliente,
       v.placa,
       v.marca,
       v.modelo,
       v.ano
FROM cliente c
JOIN veiculo v ON c.id = v.cliente_id
ORDER BY c.nome;
  
-- Qual o valor total gasto por cada cliente em ordens de serviço?
SELECT c.nome AS cliente,
       SUM(COALESCE(oss.subtotal,0) + COALESCE(op.subtotal,0)) AS total_gasto
FROM cliente c
JOIN veiculo v ON c.id = v.cliente_id
JOIN ordem_servico os ON v.id = os.veiculo_id
LEFT JOIN os_servico oss ON os.id = oss.os_id
LEFT JOIN os_peca op ON os.id = op.os_id
GROUP BY c.nome
ORDER BY total_gasto DESC;


-- Quais serviços são mais executados na oficina?
SELECT sr.descricao AS servico,
       COUNT(*) AS vezes_executado
FROM os_servico oss
JOIN servico_ref sr ON oss.servico_ref_id = sr.id
GROUP BY sr.descricao
ORDER BY vezes_executado DESC;

-- Quais peças mais geram receita na oficina?
SELECT p.descricao AS peca,
       SUM(op.subtotal) AS receita_total
FROM os_peca op
JOIN peca p ON op.peca_id = p.id
GROUP BY p.descricao
ORDER BY receita_total DESC;

-- Quais ordens de serviço têm valor acima de R$ 1000,00?
SELECT os.id AS ordem_servico,
       c.nome AS cliente,
       SUM(COALESCE(oss.subtotal,0) + COALESCE(op.subtotal,0)) AS valor_total
FROM ordem_servico os
JOIN veiculo v ON os.veiculo_id = v.id
JOIN cliente c ON v.cliente_id = c.id
LEFT JOIN os_servico oss ON os.id = oss.os_id
LEFT JOIN os_peca op ON os.id = op.os_id
GROUP BY os.id, c.nome
HAVING valor_total > 1000
ORDER BY valor_total DESC;


-- Quais equipes estão mais ocupadas (com mais ordens de serviço)?
SELECT e.nome AS equipe,
       COUNT(os.id) AS total_ordens
FROM equipe e
JOIN ordem_servico os ON e.id = os.equipe_id
GROUP BY e.nome
ORDER BY total_ordens DESC;

-- Quais clientes ainda têm ordens de serviço em aberto?
SELECT DISTINCT c.nome AS cliente,
       os.id AS ordem_servico,
       os.status
FROM cliente c
JOIN veiculo v ON c.id = v.cliente_id
JOIN ordem_servico os ON v.id = os.veiculo_id
WHERE os.status IN ('aberto','em_execucao');


-- Qual a média de valor das ordens de serviço concluídas?
SELECT ROUND(AVG(total.valor_total), 2) AS media_valor_concluidas
FROM (
    SELECT os.id,
           SUM(COALESCE(oss.subtotal,0) + COALESCE(op.subtotal,0)) AS valor_total
    FROM ordem_servico os
    LEFT JOIN os_servico oss ON os.id = oss.os_id
    LEFT JOIN os_peca op ON os.id = op.os_id
    WHERE os.status = 'concluido'
    GROUP BY os.id
) total;

-- Quais mecânicos pertencem a cada equipe?
SELECT e.nome AS equipe,
       m.nome AS mecanico,
       m.especialidade
FROM mecanico m
JOIN equipe e ON m.equipe_id = e.id
ORDER BY e.nome, m.nome;
