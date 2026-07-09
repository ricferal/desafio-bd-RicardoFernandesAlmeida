## Mini-mundo: Escola de Música

Este projeto modela o banco de dados de uma escola de música que oferece cursos de diferentes instrumentos musicais. A escola possui alunos, professores, cursos, instrumentos e categorias de instrumentos. As categorias representam grupos como Cordas, Teclas, Percussão e Sopros, enquanto os instrumentos representam itens específicos, como Violão, Piano, Bateria e Flauta.

Cada instrumento pode estar associado a uma ou mais categorias, e cada categoria pode conter vários instrumentos. Por isso, o relacionamento entre `categorias` e `instrumentos` é do tipo N:N e foi resolvido pela tabela associativa `categorias_instrumentos`. Além disso, cada curso está ligado a um único instrumento e a um único professor, enquanto um professor pode ministrar vários cursos.

Os alunos podem se matricular em vários cursos, e cada curso pode possuir vários alunos matriculados. Esse relacionamento N:N entre `alunos` e `cursos` é resolvido pela tabela `matriculas`, que armazena informações próprias da matrícula, como a data da matrícula e o status. Dessa forma, o modelo permite controlar quais alunos estão inscritos em quais cursos, quem ministra cada curso e a qual instrumento e categoria cada curso está relacionado.
