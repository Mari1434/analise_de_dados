-- 1. Quem são os funcionários do departamento de Engenharia? Retorne nome e sobrenome.

SELECT nome, sobrenome
FROM cap04.funcionarios
WHERE departamento = 'Engenharia';

-- 2. Quais funcionários foram contratados em 2021 ou depois? Retorne nome, sobrenome e data_contratacao.

SELECT nome, sobrenome, data_contratacao
FROM cap04.funcionarios
WHERE data_contratacao >= '2021-01-01';

-- 3. Quais funcionários recebem salário entre 5000 e 6000? Retorne nome, sobrenome, salario e departamento.

SELECT nome, sobrenome, salario, departamento
FROM cap04.funcionarios
WHERE salario BETWEEN 5000 AND 6000;

-- 4. Quais funcionários têm nome começando com a letra J ou com a letra B? Retorne nome, sobrenome e departamento.

SELECT nome, sobrenome, departamento
FROM cap04.funcionarios
WHERE nome LIKE 'J%' OR nome LIKE 'B%';

-- 5. Há algum funcionário cujo sobrenome tenha as letras 've', seja do departamento de Marketing e o salário seja maior do que 5500?

SELECT *
FROM cap04.funcionarios
WHERE sobrenome LIKE '%ve%' AND departamento = 'Marketing' AND salario > 5500;