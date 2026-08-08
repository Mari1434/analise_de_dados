-- Pergunta 1: Qual é o total de vendas por produto?

SELECT id_produto,
	SUM(valor) AS total_vendas
FROM cap05.vendas
GROUP BY id_produto
ORDER BY id_produto;

-- Pergunta 2: Quantos produtos diferentes foram vendidos?

SELECT COUNT(DISTINCT id_produto) AS produtos_diferentes
FROM cap05.vendas;

-- Pergunta 3: Qual é o total de vendas por dia?

SELECT data_venda, SUM(valor) AS total_vendas
FROM cap05.vendas
GROUP BY data_venda
ORDER BY data_venda;

-- Pergunta 4: Em quais dias o valor total de vendas foi superior a $100?

SELECT data_venda, total_vendas
FROM (
	SELECT data_venda, SUM(valor) AS total_vendas
	FROM cap05.vendas
	GROUP BY data_venda
	ORDER BY data_venda
	)
WHERE total_vendas > 100;

-- Pergunta 5: Quais produtos tiveram um valor total de vendas superior a $50?

SELECT id_produto, total_vendas
FROM (
	SELECT id_produto,
		SUM(valor) AS total_vendas
	FROM cap05.vendas
	GROUP BY id_produto
	ORDER BY id_produto
	)
WHERE total_vendas > 50;