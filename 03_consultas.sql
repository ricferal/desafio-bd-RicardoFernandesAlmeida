-- =====================================================
-- 03_consultas.sql
-- Bateria de consultas - Escola de Música
-- =====================================================


-- 1. Quais alunos possuem e-mail cadastrado com domínio "email.com"?
-- Consulta básica com filtro usando ILIKE.
SELECT 
    id_aluno,
    nome,
    email
FROM alunos
WHERE email ILIKE '%email.com';


-- 2. Quais cursos são dos níveis "Iniciante" ou "Intermediário"?
-- Consulta básica com filtro usando IN.
SELECT 
    id_curso,
    nome_curso,
    nivel
FROM cursos
WHERE nivel IN ('Iniciante', 'Intermediário');


-- 3. Quais matrículas foram realizadas entre 01/07/2026 e 07/07/2026?
-- Consulta básica com filtro usando BETWEEN.
SELECT 
    id_matricula,
    id_aluno,
    id_curso,
    data_matricula,
    status
FROM matriculas
WHERE data_matricula BETWEEN '2026-07-01' AND '2026-07-07';


-- 4. Quantos cursos existem por nível?
-- Agregação com GROUP BY.
SELECT 
    nivel,
    COUNT(*) AS quantidade_cursos
FROM cursos
GROUP BY nivel
ORDER BY quantidade_cursos DESC;


-- 5. Quais alunos possuem mais de uma matrícula?
-- Agregação com GROUP BY e HAVING.
SELECT 
    a.id_aluno,
    a.nome,
    COUNT(m.id_matricula) AS quantidade_matriculas
FROM alunos a
INNER JOIN matriculas m
    ON a.id_aluno = m.id_aluno
GROUP BY a.id_aluno, a.nome
HAVING COUNT(m.id_matricula) > 1
ORDER BY quantidade_matriculas DESC;


-- 6. Quais cursos são ministrados por quais professores?
-- JOIN INNER entre cursos e professores.
SELECT 
    c.nome_curso,
    c.nivel,
    p.nome AS professor,
    p.especialidade
FROM cursos c
INNER JOIN professores p
    ON c.id_professor = p.id_professor
ORDER BY p.nome, c.nome_curso;


-- 7. Quais alunos estão matriculados em quais cursos, com professor e instrumento?
-- JOIN INNER com 3 ou mais tabelas.
SELECT 
    a.nome AS aluno,
    c.nome_curso,
    c.nivel,
    i.nome_instrumento,
    p.nome AS professor,
    m.data_matricula,
    m.status
FROM matriculas m
INNER JOIN alunos a
    ON m.id_aluno = a.id_aluno
INNER JOIN cursos c
    ON m.id_curso = c.id_curso
INNER JOIN instrumentos i
    ON c.id_instrumento = i.id_instrumento
INNER JOIN professores p
    ON c.id_professor = p.id_professor
ORDER BY a.nome, c.nome_curso;


-- 8. Quais cursos possuem alunos matriculados e quais ainda não possuem matrícula?
-- LEFT JOIN mostrando cursos com contagem 0 quando não houver matrícula.
-- Para aparecer linha com 0, é necessário existir algum curso sem matrícula na tabela cursos.
SELECT 
    c.id_curso,
    c.nome_curso,
    COUNT(m.id_matricula) AS quantidade_matriculas
FROM cursos c
LEFT JOIN matriculas m
    ON c.id_curso = m.id_curso
GROUP BY c.id_curso, c.nome_curso
ORDER BY quantidade_matriculas ASC, c.nome_curso;


-- 9. Quais cursos têm quantidade de matrículas acima da média geral de matrículas por curso?
-- Consulta usando CTE WITH.
WITH matriculas_por_curso AS (
    SELECT 
        c.id_curso,
        c.nome_curso,
        COUNT(m.id_matricula) AS total_matriculas
    FROM cursos c
    LEFT JOIN matriculas m
        ON c.id_curso = m.id_curso
    GROUP BY c.id_curso, c.nome_curso
),
media_matriculas AS (
    SELECT 
        AVG(total_matriculas) AS media
    FROM matriculas_por_curso
)
SELECT 
    mpc.id_curso,
    mpc.nome_curso,
    mpc.total_matriculas
FROM matriculas_por_curso mpc
CROSS JOIN media_matriculas mm
WHERE mpc.total_matriculas > mm.media
ORDER BY mpc.total_matriculas DESC;


-- 10. Qual é o ranking dos cursos com mais matrículas?
-- Consulta usando window function RANK().
SELECT 
    c.id_curso,
    c.nome_curso,
    COUNT(m.id_matricula) AS total_matriculas,
    RANK() OVER (
        ORDER BY COUNT(m.id_matricula) DESC
    ) AS posicao_ranking
FROM cursos c
LEFT JOIN matriculas m
    ON c.id_curso = m.id_curso
GROUP BY c.id_curso, c.nome_curso
ORDER BY posicao_ranking, c.nome_curso;


-- Aluno com telefone NULL
SELECT * 
FROM alunos
WHERE telefone IS NULL;

-- Curso sem matrícula, útil para LEFT JOIN
SELECT 
    c.nome_curso,
    COUNT(m.id_matricula) AS quantidade_matriculas
FROM cursos c
LEFT JOIN matriculas m
    ON c.id_curso = m.id_curso
GROUP BY c.id_curso, c.nome_curso
ORDER BY quantidade_matriculas;