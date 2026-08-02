-- =====================================================
-- 01_cria.sql
-- Criação das tabelas - Mini-mundo Escola de Música
-- PostgreSQL
-- =====================================================

-- =====================================================
-- 1. TABELA CATEGORIAS
-- Exemplo: Cordas, Teclas, Percussão, Sopros
-- =====================================================

CREATE TABLE categorias (
    id_categoria SERIAL PRIMARY KEY,
    nome_categoria VARCHAR(100) NOT NULL UNIQUE
);


-- =====================================================
-- 2. TABELA INSTRUMENTOS
-- Exemplo: Violão, Guitarra, Piano, Bateria
-- =====================================================

CREATE TABLE instrumentos (
    id_instrumento SERIAL PRIMARY KEY,
    nome_instrumento VARCHAR(100) NOT NULL UNIQUE
);


-- =====================================================
-- 3. TABELA PROFESSORES
-- Cada professor possui nome e uma especialidade musical
-- =====================================================

CREATE TABLE professores (
    id_professor SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100) NOT NULL
);


-- =====================================================
-- 4. TABELA ALUNOS
-- Cada aluno deve ter e-mail único
-- =====================================================

CREATE TABLE alunos (
    id_aluno SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100) NOT NULL UNIQUE
);


-- =====================================================
-- 5. TABELA ASSOCIATIVA CATEGORIAS_INSTRUMENTOS
-- Resolve o relacionamento N:N entre categorias e instrumentos
-- Uma categoria pode ter vários instrumentos
-- Um instrumento pode pertencer a várias categorias
-- =====================================================

CREATE TABLE categorias_instrumentos (
    id_categoria INT NOT NULL,
    id_instrumento INT NOT NULL,

    PRIMARY KEY (id_categoria, id_instrumento),

    FOREIGN KEY (id_categoria)
        REFERENCES categorias(id_categoria),

    FOREIGN KEY (id_instrumento)
        REFERENCES instrumentos(id_instrumento)
);


-- =====================================================
-- 6. TABELA CURSOS
-- Cada curso pertence a um instrumento e é ministrado por um professor
-- =====================================================

CREATE TABLE cursos (
    id_curso SERIAL PRIMARY KEY,
    nome_curso VARCHAR(100) NOT NULL,
    nivel VARCHAR(50) NOT NULL,
    carga_horaria INT NOT NULL,

    id_instrumento INT NOT NULL,
    id_professor INT NOT NULL,

    FOREIGN KEY (id_instrumento)
        REFERENCES instrumentos(id_instrumento),

    FOREIGN KEY (id_professor)
        REFERENCES professores(id_professor),

    CHECK (carga_horaria > 0),

    CHECK (nivel IN ('Iniciante', 'Intermediário', 'Avançado'))
);


-- =====================================================
-- 7. TABELA MATRICULAS
-- Resolve o relacionamento N:N entre alunos e cursos
-- Um aluno pode se matricular em vários cursos
-- Um curso pode ter vários alunos
-- =====================================================

CREATE TABLE matriculas (
    id_matricula SERIAL PRIMARY KEY,

    id_aluno INT NOT NULL,
    id_curso INT NOT NULL,

    data_matricula DATE NOT NULL,
    status VARCHAR(30) NOT NULL,

    FOREIGN KEY (id_aluno)
        REFERENCES alunos(id_aluno),

    FOREIGN KEY (id_curso)
        REFERENCES cursos(id_curso),

    UNIQUE (id_aluno, id_curso),

    CHECK (status IN ('Ativa', 'Cancelada', 'Concluída'))
);