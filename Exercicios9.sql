-- 1. Crie uma query para comparar em um relatório os dados de vendas diárias com a média móvel
-- Considere janela de 3 dias para a média móvel

SELECT data_venda, valor_venda,
	ROUND(AVG(valor_venda) OVER (
	ORDER BY data_venda
	ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING), 2) AS media_movel
FROM cap12.vendas_temporais;

-- 2. Crie uma query para comparar em um relatório os dados de vendas diárias com a média móvel
-- Considere janela de 7 dias para a média móvel

SELECT data_venda, valor_venda,
	ROUND(AVG(valor_venda) OVER (
	ORDER BY data_venda
	ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING), 2) AS media_movel
FROM cap12.vendas_temporais;

-- 3. Crie uma query que mostre o crescimento das vendas diárias em relação ao dia anterior
-- Por exemplo: De um dia para outro a venda aumento em 23 ou diminuiu em 57

SELECT data_venda, valor_venda,
	COALESCE(valor_venda - LAG(valor_venda) OVER (ORDER BY data_venda), 0) AS crescimento_dia_anterior
FROM cap12.vendas_temporais;

-- 4. Crie uma query que mostre a soma acumulada de vendas dia a dia

SELECT data_venda,
	SUM(valor_venda) OVER (PARTITION BY EXTRACT(MONTH FROM data_venda) ORDER BY data_venda) AS soma_acumulada
FROM cap12.vendas_temporais;

-- 5. [Desafio] Crie um ranking de vendas por funcionário considerando o valor total de vendas por dia e de cada funcionário

SELECT 
    *,
    DENSE_RANK() OVER (PARTITION BY funcionario_id ORDER BY valor_venda DESC) as rank_vendas
FROM 
    (SELECT data_venda, funcionario_id, SUM(valor_venda) as valor_venda
     FROM cap12.vendas_temporais
     GROUP BY data_venda, funcionario_id) as subquery
ORDER BY 
    funcionario_id, rank_vendas;