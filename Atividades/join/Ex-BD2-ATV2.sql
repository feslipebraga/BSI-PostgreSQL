-- FELIPE BEZERRA BRAGA

-- Selecionar todas as compras de um cliente, em um determinado período, ordenando por data (da mais nova para a mais antiga)

SELECT s.numeronfsaida, s.data, s.valortotal, s.idcliente, c.nome
FROM saidas AS s
JOIN clientes c ON s.idcliente = c.idcliente
WHERE s.idcliente = 1
AND s.data BETWEEN '2023-01-01' AND '2023-12-31'
ORDER BY s.data DESC;

-- Selecionar todas as entradas de uma determinada mercadoria, em um dado período (ordenando da mais antiga para a mais nova)

SELECT e.numeronfentrada, e.data, e.valorTotal
FROM entradas AS e
JOIN itens_entrada AS ie ON e.numeroNFEntrada = ie.numeroNFEntrada
WHERE ie.IDProduto = 2
AND e.data BETWEEN '2023-01-01' AND '2023-12-31'
ORDER BY e.data;

-- Quais os fornecedores do produto “X”?

/* NÃO FOI POSSÍVEL ENCONTRAR POIS NÃO HÁ UMA RELAÇÃO (FK) ENTRE FORNECEDORES E PRODUTOS NOS SCRIPTS DDL REPASSADOS.

Para resolver o exercício eu adicionei uma coluna 'idfornecedor' como fk na tabela 'produtos' e rodei o seguinte script: */

SELECT f.nome AS nomeFornecedor
FROM fornecedores f
JOIN produtos p ON f.idfornecedor = p.idfornecedor
WHERE p.descricao = 'X';

-- Quais os 10 produtos mais vendidos no período informado, em ordem decrescente?

SELECT p.descricao, SUM(isd.quantidade) as totalVendido
FROM produtos p
JOIN itens_saida isd ON p.idproduto = isd.idproduto
JOIN saidas s ON isd.numeronfsaida = s.numeronfsaida
WHERE s.data BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY p.descricao
ORDER BY totalVendido DESC
LIMIT 10;

-- Qual o cliente que mais comprou (valor) no período informado?

SELECT c.nome AS cliente, SUM(s.valorTotal) AS totalComprado
FROM clientes c
JOIN saidas s ON c.IDCliente = s.IDCliente
WHERE s.data BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY c.nome
ORDER BY totalComprado DESC
LIMIT 1;