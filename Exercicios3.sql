-- Pergunta 1: Qual é o valor total de produtos em estoque por categoria?

SELECT categoria,
	SUM(preco * quantidade) AS valor_total
FROM cap05.produtos
GROUP BY categoria
ORDER BY categoria;

-- Pergunta 2: Qual é a quantidade média de produtos em estoque por categoria?

SELECT categoria,
	ROUND(AVG(quantidade), 0) AS media_estoque
FROM cap05.produtos
GROUP BY categoria
ORDER BY categoria;

-- Pergunta 3: Qual é o preço médio dos produtos por categoria?

SELECT categoria,
	ROUND(AVG(preco), 2) AS preco_medio
FROM cap05.produtos
GROUP BY categoria
ORDER BY categoria;

-- Pergunta 4: Qual é o número total de categorias de produtos?

SELECT COUNT(DISTINCT categoria) AS total_categorias
FROM cap05.produtos;

-- Pergunta 5: Qual é a categoria com a maior quantidade de produtos em estoque?

SELECT categoria,
	SUM(quantidade) AS quantidade_total
FROM cap05.produtos
GROUP BY categoria
ORDER BY quantidade_total DESC
LIMIT 1;