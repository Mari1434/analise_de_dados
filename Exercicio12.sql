-- 1. Qual o Número Total de Vendas e Média de Quantidade Vendida?

SELECT
	COUNT(*) AS total_vendas,
	ROUND(AVG(quantidade), 2) AS media_vendida
FROM cap17.vendas;

-- 2. Qual o Número Total de Produtos Únicos Vendidos?

SELECT
	COUNT(DISTINCT id_produto) AS total_produtos_unicos
FROM cap17.vendas;

-- 3. Quantas Vendas Ocorreram Por Produto? Mostre o Resultado em Ordem Decrescente.

SELECT p.nome, COUNT(v.id_produto) AS total_num_vendas
FROM cap17.vendas v
JOIN cap17.produtos p ON v.id_produto = p.id_produto
GROUP BY p.nome
ORDER BY total_num_vendas DESC;

-- 4. Quais os 5 Produtos com Maior Número de Vendas?

SELECT p.nome, COUNT(v.id_produto) AS total_num_vendas
FROM cap17.vendas v
JOIN cap17.produtos p ON v.id_produto = p.id_produto
GROUP BY p.nome
ORDER BY total_num_vendas DESC
LIMIT 5;

-- 5. Quais Clientes Fizeram 6 ou Mais Transações de Compra?

SELECT c.nome, COUNT(v.id_cliente) AS transacoes
FROM cap17.vendas v
JOIN cap17.clientes c ON v.id_cliente = c.id_cliente
GROUP BY c.nome
HAVING COUNT(v.id_cliente) >= 6
ORDER BY transacoes DESC;

-- 6. Qual o Total de Transações Comerciais Por Mês no Ano de 2024? Apresente os Nomes
-- dos Meses no Resultado, Que Deve Ser Ordenado Por Mês.

SELECT
    CASE
        WHEN EXTRACT(MONTH FROM Data_Venda) = 1 THEN 'Janeiro'
        WHEN EXTRACT(MONTH FROM Data_Venda) = 2 THEN 'Fevereiro'
        WHEN EXTRACT(MONTH FROM Data_Venda) = 3 THEN 'Março'
        WHEN EXTRACT(MONTH FROM Data_Venda) = 4 THEN 'Abril'
        WHEN EXTRACT(MONTH FROM Data_Venda) = 5 THEN 'Maio'
        WHEN EXTRACT(MONTH FROM Data_Venda) = 6 THEN 'Junho'
        WHEN EXTRACT(MONTH FROM Data_Venda) = 7 THEN 'Julho'
        WHEN EXTRACT(MONTH FROM Data_Venda) = 8 THEN 'Agosto'
        WHEN EXTRACT(MONTH FROM Data_Venda) = 9 THEN 'Setembro'
        WHEN EXTRACT(MONTH FROM Data_Venda) = 10 THEN 'Outubro'
        WHEN EXTRACT(MONTH FROM Data_Venda) = 11 THEN 'Novembro'
        WHEN EXTRACT(MONTH FROM Data_Venda) = 12 THEN 'Dezembro'
    END AS mes,
    COUNT(*) AS total_vendas
FROM cap17.vendas
WHERE EXTRACT(YEAR FROM Data_Venda) = 2024
GROUP BY EXTRACT(MONTH FROM Data_Venda)
ORDER BY EXTRACT(MONTH FROM Data_Venda);

-- 7. Quantas Vendas de Notebooks Ocorreram em Junho e Julho de 2023?

SELECT COUNT(*) AS total_vendas_notebook
FROM cap17.vendas v
JOIN cap17.produtos p ON v.id_produto = p.id_produto
WHERE p.nome = 'Notebook'
  AND EXTRACT(YEAR FROM v.data_venda) = 2023
  AND EXTRACT(MONTH FROM v.data_venda) IN (6, 7);

-- 8. Qual o Total de Vendas Por Mês e Por Ano ao Longo do Tempo?

SELECT DATE_TRUNC('month', Data_Venda) AS mes, COUNT(*) AS total_vendas
FROM cap17.vendas
GROUP BY mes
ORDER BY mes;

-- 9. Quais Produtos Tiveram Menos de 100 Transações de Venda?

SELECT
	p.nome,
	COUNT(v.id_produto) AS transacoes
FROM cap17.vendas v
JOIN cap17.produtos p ON v.id_produto = p.id_produto
GROUP BY p.nome
HAVING COUNT(v.id_produto) < 100
ORDER BY transacoes;

-- 10. Quais Clientes Compraram Smartphone e Também Compraram Smartwatch?

-- Subconsulta para clientes que compraram Smartphone
WITH compradores_smartphone AS (
    SELECT v.id_cliente
    FROM cap17.vendas v
    JOIN cap17.produtos p ON v.id_produto = p.id_produto
    WHERE p.nome = 'Smartphone'
    GROUP BY v.id_cliente
),
-- Subconsulta para clientes que compraram Smartwatch
compradores_smartwatch AS (
    SELECT v.id_cliente
    FROM cap17.vendas v
    JOIN cap17.produtos p ON v.id_produto = p.id_produto
    WHERE p.nome = 'Smartwatch'
    GROUP BY v.id_cliente
)
-- Seleciona clientes que estão em ambas as subconsultas
SELECT c.nome
FROM cap17.clientes c
WHERE c.id_cliente IN (
    SELECT id_cliente FROM compradores_smartphone
    INTERSECT
    SELECT id_cliente FROM compradores_smartwatch
)
ORDER BY c.nome;

-- 11. Quais Clientes Compraram Smartphone e Também Compraram Smartwatch, Mas 
-- Não Compraram Notebook?

-- Clientes que compraram Smartphone
WITH clientes_smartphone AS (
    SELECT id_cliente
    FROM cap17.vendas
    JOIN cap17.produtos ON vendas.id_produto = produtos.id_produto
    WHERE produtos.nome = 'Smartphone'
),
-- Clientes que compraram Smartwatch
clientes_smartwatch AS (
    SELECT id_cliente
    FROM cap17.vendas
    JOIN cap17.produtos ON vendas.id_produto = produtos.id_produto
    WHERE produtos.nome = 'Smartwatch'
),
-- Clientes que compraram Notebook
clientes_notebook AS (
    SELECT id_cliente
    FROM cap17.vendas
    JOIN cap17.produtos ON vendas.id_produto = produtos.id_produto
    WHERE produtos.nome = 'Notebook'
)
-- Clientes que compraram Smartphone e Smartwatch, mas não compraram Notebook
SELECT clientes.nome
FROM cap17.clientes
WHERE id_cliente IN (
    SELECT id_cliente FROM clientes_smartphone
    INTERSECT
    SELECT id_cliente FROM clientes_smartwatch
)
AND id_cliente NOT IN (
    SELECT id_cliente FROM clientes_notebook
);

-- 12. Quais Clientes Compraram Smartphone e Também Compraram Smartwatch, 
-- Mas Não Compraram Notebook em Maio/2024?

-- Clientes que compraram Smartphone em Maio/2024
WITH clientes_smartphone AS (
    SELECT id_cliente
    FROM cap17.vendas
    JOIN cap17.produtos ON vendas.id_produto = produtos.id_produto
    WHERE produtos.nome = 'Smartphone'
      AND DATE_PART('year', vendas.data_venda) = 2024
      AND DATE_PART('month', vendas.data_venda) = 5
),
-- Clientes que compraram Smartwatch em Maio/2024
clientes_smartwatch AS (
    SELECT id_cliente
    FROM cap17.vendas
    JOIN cap17.produtos ON vendas.id_produto = produtos.id_produto
    WHERE produtos.nome = 'Smartwatch'
      AND DATE_PART('year', vendas.data_venda) = 2024
      AND DATE_PART('month', vendas.data_venda) = 5
),
-- Clientes que compraram Notebook em Maio/2024
clientes_notebook AS (
    SELECT id_cliente
    FROM cap17.vendas
    JOIN cap17.produtos ON vendas.id_produto = produtos.id_produto
    WHERE produtos.nome = 'Notebook'
      AND DATE_PART('year', vendas.data_venda) = 2024
      AND DATE_PART('month', vendas.data_venda) = 5
)
-- Clientes que compraram Smartphone e Smartwatch, mas não Notebook em Maio/2024
SELECT cap17.clientes.nome
FROM cap17.clientes
WHERE id_cliente IN (
    SELECT id_cliente FROM clientes_smartphone
    INTERSECT
    SELECT id_cliente FROM clientes_smartwatch
)
AND id_cliente NOT IN (
    SELECT id_cliente FROM clientes_notebook
);

-- 13. Qual a Média Móvel de Quantidade de Unidades Vendidas ao Longo do Tempo?
-- Considere Janela de 7 Dias.

SELECT
    data_venda,
    quantidade,
    ROUND(AVG(quantidade) OVER (ORDER BY data_venda
                          ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING), 2) AS media_movel_7dias
FROM cap17.vendas
ORDER BY data_venda;

-- 14. Qual a Média Móvel e Desvio Padrão Móvel de Quantidade de Unidades Vendidas ao
-- Longo do Tempo? Considere Janela de 7 Dias.

SELECT
    data_venda,
    quantidade,
    ROUND(AVG(quantidade) OVER (ORDER BY data_venda
                                ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING), 2) AS media_movel_7dias,
    ROUND(STDDEV(quantidade) OVER (ORDER BY data_venda
                                   ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING), 2) AS desvio_padrao_7dias
FROM cap17.vendas
ORDER BY data_venda;

-- 15. Quais Clientes Estão Cadastrados, Mas Ainda Não Fizeram Transação?

SELECT c.id_cliente, c.nome
FROM cap17.clientes c
LEFT JOIN cap17.vendas v ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL;