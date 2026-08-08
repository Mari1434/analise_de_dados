-- Pergunta 1: Qual é a quantidade de fornecedores por estado?

SELECT estado, 
	COUNT(*) AS quantidade_fornecedores
FROM cap05.fornecedores
GROUP BY estado;

-- Pergunta 2: Qual é o estado com o maior número de fornecedores?

SELECT estado
FROM cap05.fornecedores
GROUP BY estado
ORDER BY COUNT(*) DESC
LIMIT 1;

-- Pergunta 3: Quantos fornecedores foram registrados no mês de Setembro de 2023?

SELECT COUNT(*) AS quantidade_fornecedores
FROM cap05.fornecedores
WHERE EXTRACT(MONTH FROM data_registro) = 09 AND EXTRACT(YEAR FROM data_registro) = 2023;

-- Pergunta 4: Qual é a média de registros de fornecedores por mês?

SELECT ROUND(AVG(quantidade), 0) AS media_registros_por_mes
FROM (
	SELECT EXTRACT(MONTH FROM data_registro) AS mes, COUNT(*) AS quantidade
	FROM cap05.fornecedores
	GROUP BY EXTRACT(MONTH FROM data_registro)
) AS subquery;

-- Pergunta 5: Qual é o fornecedor mais recente registrado?

SELECT nome, data_registro
FROM cap05.fornecedores
WHERE data_registro = (SELECT MAX(data_registro) FROM cap05.fornecedores);