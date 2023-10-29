-- A View entradaMercadoria deve retornar, na sequência: número da NF, quantidade, código e descrição do produto, valor unitário.
CREATE VIEW entradaMercadoria as
SELECT
    e.numeronfentrada,
    ie.quantidade,
    p.idproduto,
    p.descricao,
    ie.valorunitario
FROM
    entradas e
    JOIN itens_entrada ie ON ie.numeronfentrada = e.numeronfentrada
    JOIN produtos p ON p.idproduto = ie.idproduto;
    
-- Listar todos os clientes.
CREATE VIEW nomeClientes as
SELECT
    idcliente,
    nome
FROM
    clientes;

-- Listar as compras (data, NF, produtos) de um cliente (dica: a View não deve filtrar cliente ou NF, isso é feito na consulta).
CREATE VIEW compras AS
SELECT
    c.idcliente,
    c.nome,
    s.data,
    i.numeronfsaida,
    p.descricao
FROM
    saidas s
    JOIN itens_saida i on i.numeronfsaida = s.numeronfsaida
    JOIN clientes c on c.idcliente = s.idcliente
    JOIN produtos p on p.idproduto = i.idproduto;

--Listar todos os produtos.
CREATE VIEW nomeProdutos AS
SELECT
    idproduto,
    descricao
FROM
    produtos;

-- Listar os 10 produtos mais vendidos em um período (dica: a View não deve filtrar datas, isso é feito na consulta que usa a View como origem dos dados. Use as cláusulas ORDER BY e LIMIT).

CREATE VIEW maisVendidos AS
select s.data, p.descricao as produto, i.quantidade
from itens_saida i
join produtos p on p.idproduto = i.idproduto
join saidas s on s.numeronfsaida = i.numeronfsaida
order by quantidade desc
limit 10;

select * from maisVendidos
where data between '2023-08-01' and '2023-08-03';