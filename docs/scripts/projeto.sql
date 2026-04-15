-- SCHEMAS
CREATE SCHEMA academico;
CREATE SCHEMA seguranca;

-- TABELAS
CREATE TABLE academico.aluno (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE academico.professor (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE academico.disciplina (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE academico.matricula (
    id SERIAL PRIMARY KEY,
    id_aluno INT,
    id_disciplina INT,
    nota NUMERIC(4,2),
    ciclo VARCHAR(10),
    ativo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_aluno) REFERENCES academico.aluno(id),
    FOREIGN KEY (id_disciplina) REFERENCES academico.disciplina(id)
);

-- ROLES
CREATE ROLE professor_role;
CREATE ROLE coordenador_role;

-- PERMISSÕES
GRANT UPDATE (nota) ON academico.matricula TO professor_role;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA academico TO coordenador_role;

REVOKE SELECT (email) ON academico.aluno FROM professor_role;

-- INSERTS
INSERT INTO academico.aluno (nome, email) VALUES
('João Silva', 'joao@email.com'),
('Maria Souza', 'maria@email.com');

INSERT INTO academico.disciplina (nome) VALUES
('Banco de Dados'),
('Algoritmos');

INSERT INTO academico.matricula (id_aluno, id_disciplina, nota, ciclo) VALUES
(1, 1, 8.5, '2026/1'),
(2, 1, 5.0, '2026/1'),
(1, 2, 7.0, '2026/1');

-- QUERY 1
SELECT a.nome, d.nome, m.ciclo
FROM academico.matricula m
JOIN academico.aluno a ON a.id = m.id_aluno
JOIN academico.disciplina d ON d.id = m.id_disciplina
WHERE m.ciclo = '2026/1';

-- QUERY 2
SELECT d.nome, AVG(m.nota)
FROM academico.matricula m
JOIN academico.disciplina d ON d.id = m.id_disciplina
GROUP BY d.nome
HAVING AVG(m.nota) < 6;

-- QUERY 3
SELECT p.nome, d.nome
FROM academico.professor p
LEFT JOIN academico.disciplina d ON d.id = p.id;

-- QUERY 4
SELECT a.nome, m.nota
FROM academico.matricula m
JOIN academico.aluno a ON a.id = m.id_aluno
JOIN academico.disciplina d ON d.id = m.id_disciplina
WHERE d.nome = 'Banco de Dados'
AND m.nota = (
    SELECT MAX(nota) FROM academico.matricula
);