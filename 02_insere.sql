-- =====================================================
-- 02_insere.sql
-- Inserção de dados - Mini-mundo Escola de Música
-- PostgreSQL
-- =====================================================


-- =====================================================
-- 1. CATEGORIAS
-- =====================================================

INSERT INTO categorias (nome_categoria)
VALUES
('Cordas'),
('Teclas'),
('Percussão'),
('Sopros'),
('Canto');


-- =====================================================
-- 2. INSTRUMENTOS
-- =====================================================

INSERT INTO instrumentos (nome_instrumento)
VALUES
('Violão'),
('Guitarra'),
('Piano'),
('Bateria'),
('Flauta'),
('Violino'),
('Canto Popular');


-- =====================================================
-- 3. PROFESSORES
-- =====================================================

INSERT INTO professores (nome, especialidade)
VALUES
('Carlos Mendes', 'Violão Popular'),
('Mariana Costa', 'Piano Clássico'),
('João Ribeiro', 'Bateria'),
('Fernanda Alves', 'Flauta Transversal'),
('Ricardo Lima', 'Guitarra Rock'),
('Helena Duarte', 'Violino Erudito');


-- =====================================================
-- 4. ALUNOS
-- =====================================================

INSERT INTO alunos (nome, telefone, email)
VALUES
('Ana Lima', '99999-1111', 'ana.lima@email.com'),
('Bruno Silva', '98888-2222', 'bruno.silva@email.com'),
('Carla Souza', '97777-3333', 'carla.souza@email.com'),
('Daniel Oliveira', '96666-4444', 'daniel.oliveira@email.com'),
('Eduarda Santos', '95555-5555', 'eduarda.santos@email.com'),
('Felipe Martins', NULL, 'felipe.martins@email.com');


-- =====================================================
-- 5. CATEGORIAS_INSTRUMENTOS
-- Relacionamento N:N entre categorias e instrumentos
-- =====================================================

INSERT INTO categorias_instrumentos (id_categoria, id_instrumento)
VALUES
(1, 1), -- Cordas -> Violão
(1, 2), -- Cordas -> Guitarra
(1, 6), -- Cordas -> Violino
(2, 3), -- Teclas -> Piano
(3, 4), -- Percussão -> Bateria
(4, 5), -- Sopros -> Flauta
(5, 7), -- Canto -> Canto Popular
(1, 3); -- Cordas -> Piano, caso especial para mostrar N:N


-- =====================================================
-- 6. CURSOS
-- Cada curso pertence a um instrumento e é ministrado por um professor
-- O curso "Violino Erudito" ficará sem matrícula para aparecer no LEFT JOIN
-- =====================================================

INSERT INTO cursos (
    nome_curso,
    nivel,
    carga_horaria,
    id_instrumento,
    id_professor
)
VALUES
('Violão Popular', 'Iniciante', 40, 1, 1),
('Guitarra Rock', 'Intermediário', 50, 2, 5),
('Piano Clássico', 'Intermediário', 60, 3, 2),
('Bateria Básica', 'Iniciante', 36, 4, 3),
('Flauta Doce', 'Iniciante', 30, 5, 4),
('Violino Erudito', 'Avançado', 70, 6, 6);


-- =====================================================
-- 7. MATRICULAS
-- Relacionamento N:N entre alunos e cursos
-- Observação: não há matrícula para o curso id_curso = 6
-- =====================================================

INSERT INTO matriculas (
    id_aluno,
    id_curso,
    data_matricula,
    status
)
VALUES
(1, 1, '2026-07-01', 'Ativa'),       -- Ana em Violão Popular
(1, 3, '2026-07-03', 'Ativa'),       -- Ana em Piano Clássico
(2, 2, '2026-07-04', 'Ativa'),       -- Bruno em Guitarra Rock
(3, 4, '2026-07-05', 'Ativa'),       -- Carla em Bateria Básica
(4, 5, '2026-07-06', 'Ativa'),       -- Daniel em Flauta Doce
(5, 1, '2026-07-07', 'Cancelada'),   -- Eduarda em Violão Popular
(6, 3, '2026-07-08', 'Ativa'),       -- Felipe em Piano Clássico
(2, 4, '2026-07-09', 'Concluída');   -- Bruno em Bateria Básica