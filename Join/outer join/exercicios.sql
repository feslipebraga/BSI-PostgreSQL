-- 1) Buscar os dados de todos os ambulatórios e, para aqueles ambulatórios em que médicos dão atendimento, exibir também os seus códigos e nomes
SELECT a.*, f.cpf, f.nome
FROM ambulatorios a
full JOIN atendimento at ON at.numeroambulatorio = a.numero
left JOIN funcionarios f ON f.cpf = at.cpffuncionario;

-- 2) Buscar o CPF e o nome de todos os médicos e, para aqueles médicos com consultas marcadas, exibir os CPFs e nomes dos seus pacientes e as datas das consultas.
SELECT f.cpf, f.nome, p.cpf, p.nome, c.data
FROM funcionarios f
FULL JOIN consulta c ON c.cpffuncionario = f.cpf
LEFT JOIN pacientes p ON p.cpf = c.cpfpaciente;