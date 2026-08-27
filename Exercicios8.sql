-- Pergunta 1: Qual o total de vendas por produto?

SELECT Produto, SUM(Quantidade * ValorUnitario) AS TotalVendas
FROM cap10.vendas
GROUP BY Produto;

-- Pergunta 2: Qual o total de vendas por vendedor?

SELECT Vendedor, SUM(Quantidade * ValorUnitario) AS TotalVendas
FROM cap10.vendas
GROUP BY Vendedor;

-- Pergunta 3: Qual o total de vendas por dia?

SELECT DataVenda, SUM(Quantidade * ValorUnitario) AS TotalVendas
FROM cap10.vendas
GROUP BY DataVenda
ORDER BY DataVenda;

-- Pergunta 4: Como as vendas se acumulam por dia e por produto (incluindo subtotais diários)?

SELECT 
	COALESCE(TO_CHAR(DataVenda, 'YYYY-MM-DD'), 'Total Geral') AS DataVenda, 
	COALESCE(Produto, 'Todos os Produtos') AS Produto, 
	SUM(Quantidade * ValorUnitario) AS TotalVendas
FROM cap10.vendas
GROUP BY ROLLUP(DataVenda, Produto)
ORDER BY GROUPING(Produto);

-- Pergunta 5: Qual a combinação de vendedor e produto gerou mais vendas (incluindo todos os subtotais possíveis)?

SELECT 
	COALESCE(Vendedor, 'Total') AS Vendedor,
	COALESCE(Produto, 'Total') AS Produto,
	SUM(Quantidade * ValorUnitario) AS TotalVendas
FROM cap10.vendas
GROUP BY CUBE(Vendedor, Produto)
ORDER BY GROUPING(Vendedor), Produto;

-- Imagine que você queira analisar as vendas totais por Produto, por Vendedor e também o total geral de todas as vendas. 
-- Como seria a Query SQL?

SELECT 
	COALESCE(Produto, 'Todos') AS Vendedor,
	COALESCE(Vendedor, 'Todos') AS Produto,
	SUM(Quantidade * ValorUnitario) AS TotalVendas
FROM cap10.vendas
GROUP BY GROUPING SETS(
	(Produto), 
	(Vendedor), 
	()
);