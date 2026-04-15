-- =========================
-- SCHEMAS
-- =========================
CREATE SCHEMA academico;
CREATE SCHEMA seguranca;

-- =========================
-- TABELAS
-- =========================

CREATE TABLE academico.aluno (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE academico.professor (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE academico.disciplina (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE academico.turma (
    id SERIAL PRIMARY KEY,
    id_disciplina INT,
    id_professor INT,
    semestre VARCHAR(10),
    ativo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_disciplina) REFERENCES academico.disciplina(id),
    FOREIGN KEY (id_professor) REFERENCES academico.professor(id)
);

CREATE TABLE academico.matricula (
    id SERIAL PRIMARY KEY,
    id_aluno INT,
    id_turma INT,
    nota NUMERIC(4,2),
    ativo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_aluno) REFERENCES academico.aluno(id),
    FOREIGN KEY (id_turma) REFERENCES academico.turma(id)
);

-- =========================
-- SEGURANÇA (DCL)
-- =========================
CREATE ROLE professor_role;
CREATE ROLE coordenador_role;

GRANT UPDATE (nota) ON academico.matricula TO professor_role;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA academico TO coordenador_role;

REVOKE SELECT (email) ON academico.aluno FROM professor_role;

-- =========================
-- DADOS
-- =========================

INSERT INTO academico.professor (nome) VALUES
('Carlos Silva'),
('Ana Souza');

INSERT INTO academico.disciplina (nome) VALUES
('Banco de Dados'),
('Algoritmos');

INSERT INTO academico.turma (id_disciplina, id_professor, semestre) VALUES
(1, 1, '2026/1'),
(2, 2, '2026/1');

INSERT INTO academico.aluno (nome, email) VALUES
('João Silva', 'joao@email.com'),
('Maria Souza', 'maria@email.com'),
('Pedro Lima', 'pedro@email.com');

INSERT INTO academico.matricula (id_aluno, id_turma, nota) VALUES
(1, 1, 8.5),
(2, 1, 5.0),
(3, 1, 9.5),
(1, 2, 7.0);

-- =========================
-- QUERIES
-- =========================

-- 1. Matriculados 2026/1
SELECT a.nome AS aluno, d.nome AS disciplina, t.semestre
FROM academico.matricula m
JOIN academico.aluno a ON a.id = m.id_aluno
JOIN academico.turma t ON t.id = m.id_turma
JOIN academico.disciplina d ON d.id = t.id_disciplina
WHERE t.semestre = '2026/1';

-- 2. Média < 6
SELECT d.nome, AVG(m.nota) AS media
FROM academico.matricula m
JOIN academico.turma t ON t.id = m.id_turma
JOIN academico.disciplina d ON d.id = t.id_disciplina
GROUP BY d.nome
HAVING AVG(m.nota) < 6;

-- 3. Professores e turmas
SELECT p.nome AS professor, d.nome AS disciplina, t.semestre
FROM academico.turma t
JOIN academico.professor p ON p.id = t.id_professor
JOIN academico.disciplina d ON d.id = t.id_disciplina;

-- 4. Melhor nota em Banco de Dados
SELECT a.nome, m.nota
FROM academico.matricula m
JOIN academico.aluno a ON a.id = m.id_aluno
JOIN academico.turma t ON t.id = m.id_turma
JOIN academico.disciplina d ON d.id = t.id_disciplina
WHERE d.nome = 'Banco de Dados'
AND m.nota = (
    SELECT MAX(m2.nota)
    FROM academico.matricula m2
    JOIN academico.turma t2 ON t2.id = m2.id_turma
    JOIN academico.disciplina d2 ON d2.id = t2.id_disciplina
    WHERE d2.nome = 'Banco de Dados'
);