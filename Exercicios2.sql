-- Pergunta 1: Quantos clientes estão registrados por estado?

SELECT estado,
	COUNT(*) AS total_clientes
FROM cap05.clientes
GROUP BY estado;

-- Pergunta 2: Qual é a idade média dos clientes?

SELECT ROUND(AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, data_nascimento))), 0) AS media_idade
FROM cap05.clientes;

-- Pergunta 3: Quantos clientes têm mais de 30 anos?

SELECT COUNT(*) AS cliente_mais_30
FROM cap05.clientes
WHERE EXTRACT(YEAR FROM AGE(CURRENT_DATE, data_nascimento)) > 30;

-- Pergunta 4: Quais são as 3 cidades com o maior número de clientes?

SELECT cidade, COUNT(*) AS total_clientes
FROM cap05.clientes
GROUP BY cidade
ORDER BY total_clientes DESC
LIMIT 3;

-- Pergunta 5: Quantos clientes têm um endereço de e-mail registrado?

SELECT COUNT(*) AS total_clientes
FROM cap05.clientes
WHERE email <> '';