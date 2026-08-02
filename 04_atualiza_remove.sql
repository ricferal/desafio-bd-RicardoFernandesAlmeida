-- =====================================================
-- 04_atualiza_remove.sql
-- Atualização e remoção - Mini-mundo Escola de Música
-- PostgreSQL
-- =====================================================


-- 1. UPDATE com WHERE
-- Pergunta de negócio:
-- Atualizar o status da matrícula da aluna Eduarda Santos no curso Violão Popular
-- de "Cancelada" para "Ativa".
--
-- O WHERE é essencial porque limita a alteração a uma matrícula específica.
-- Sem o WHERE, todas as matrículas da tabela seriam alteradas para "Ativa",
-- apagando indevidamente os status "Cancelada" e "Concluída".

UPDATE matriculas
SET status = 'Ativa'
WHERE id_aluno = 5
  AND id_curso = 1;


-- Conferência após o UPDATE
SELECT 
    id_matricula,
    id_aluno,
    id_curso,
    data_matricula,
    status
FROM matriculas
WHERE id_aluno = 5
  AND id_curso = 1;


-- 2. DELETE com WHERE
-- Pergunta de negócio:
-- Remover a matrícula do aluno Bruno Silva no curso Bateria Básica.
--
-- O WHERE é essencial porque limita a remoção a uma matrícula específica.
-- Sem o WHERE, todas as matrículas da tabela seriam apagadas,
-- causando perda total do histórico de inscrições dos alunos nos cursos.

DELETE FROM matriculas
WHERE id_aluno = 2
  AND id_curso = 4;


-- Conferência após o DELETE
SELECT 
    id_matricula,
    id_aluno,
    id_curso,
    data_matricula,
    status
FROM matriculas
ORDER BY id_matricula;