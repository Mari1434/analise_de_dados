-- Exercício 1: Liste todos os livros vendidos e seus respectivos autores.

SELECT a.id_livro, b.id_autor
FROM cap08.livros_vendidos a
JOIN cap08.livros_vendidos b USING (id_livro);

-- Fiz um self join acima, mas também poderia fazer igual abaixo:

SELECT l.titulo AS "Nome do Livro", a.nome AS "Nome do Autor"
FROM cap08.livros AS l
INNER JOIN cap08.livros_vendidos AS la ON l.id_livro = la.id_livro
INNER JOIN cap08.autores AS a ON a.id_autor = la.id_autor;

-- Exercício 2: Liste todos os autores e seus respectivos livros, incluindo autores que não têm livros cadastrados.

SELECT a.id_autor, a.nome,
	CASE
		WHEN id_livro IS NULL THEN 'Sem cadastro'
		ELSE CAST(id_livro AS VARCHAR)
	END AS id_livro
FROM cap08.livros_vendidos
RIGHT JOIN cap08.autores a USING (id_autor)
ORDER BY a.id_autor;

-- Solução do professor:

SELECT a.nome AS "Nome do Autor", COALESCE(l.titulo, 'Nenhum livro associado') AS "Nome do Livro"
FROM cap08.autores AS a
LEFT JOIN cap08.livros_vendidos AS la ON a.id_autor = la.id_autor
LEFT JOIN cap08.livros AS l ON l.id_livro = la.id_livro;

-- Exercício 3: Liste todos os livros e seus respectivos autores, incluindo livros que não têm autores cadastrados.

SELECT l.id_livro, l.titulo,
	CASE
		WHEN id_autor IS NULL THEN 'Sem cadastro'
		ELSE CAST(id_autor AS VARCHAR)
	END AS id_autor
FROM cap08.livros_vendidos
RIGHT JOIN cap08.livros l USING (id_livro)
ORDER BY id_livro;

-- Solução do professor:

SELECT l.titulo AS "Nome do Livro", COALESCE(a.nome, 'Nenhum autor associado') AS "Nome do Autor"
FROM cap08.autores AS a
RIGHT JOIN cap08.livros_vendidos AS la ON a.id_autor = la.id_autor
RIGHT JOIN cap08.livros AS l ON l.id_livro = la.id_livro;

-- Exercício 4: Liste os autores que nasceram antes de 1970 e os livros que eles escreveram.

SELECT lv.id_autor, data_nascimento, id_livro
FROM cap08.autores
RIGHT JOIN cap08.livros_vendidos lv USING (id_autor)
WHERE EXTRACT(YEAR FROM data_nascimento) < 1970;

-- Solução do professor:

SELECT a.nome AS "Nome do Autor", l.titulo AS "Nome do Livro"
FROM cap08.autores AS a
INNER JOIN cap08.livros_vendidos AS la ON a.id_autor = la.id_autor
INNER JOIN cap08.livros AS l ON l.id_livro = la.id_livro
WHERE a.data_nascimento < '1970-01-01';

-- Exercício 5: Liste os livros publicados após 2017, incluindo os que não têm autores associados.

SELECT l.id_livro, ano_publicacao
FROM cap08.livros l
LEFT JOIN cap08.livros_vendidos USING (id_livro)
WHERE ano_publicacao > 2017
ORDER BY l.id_livro;

-- Solução do professor:

SELECT l.titulo AS "Nome do Livro", COALESCE(a.nome, 'Nenhum autor associado') AS "Nome do Autor"
FROM cap08.livros AS l
LEFT JOIN cap08.livros_vendidos AS la ON l.id_livro = la.id_livro
LEFT JOIN cap08.autores AS a ON a.id_autor = la.id_autor
WHERE l.ano_publicacao > 2017;