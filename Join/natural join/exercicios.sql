-- 1) Buscar o código e o nome dos pacientes com consulta marcada para horários após às 14 horas
SELECT DISTINCT p.cpf, p.nome
FROM pacientes p
NATURAL JOIN consulta c
WHERE c.hora > '14:00:00';

-- 2) Buscar o número e o andar dos ambulatórios cujos médicos possuem consultas marcadas para o dia 12/10/2018
SELECT DISTINCT a.numero, a.andar
FROM ambulatorios a
JOIN atendimento at ON a.numero = at.numeroAmbulatorio
NATURAL JOIN consulta c
WHERE c.data = '2018-10-12';

-- 3) Buscar o nome, CPF e especialidade dos médicos que possuem consultas marcadas com pacientes que estão com tendinite
SELECT DISTINCT f.nome, f.cpf, f.especialidade
FROM funcionarios f
JOIN consulta c ON f.cpf = c.cpfFuncionario
NATURAL JOIN posse p
NATURAL JOIN doencas d
WHERE d.descricao = 'Tendinite';