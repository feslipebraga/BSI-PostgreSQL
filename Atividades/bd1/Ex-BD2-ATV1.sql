-- FELIPE BEZERRA BRAGA

-- WHERE, BETWEEN, ORDER BY, LIMIT e SUM().

-- Selecionar todas as compras de um cliente, em um determinado período, ordenando por data (da mais nova para a mais antiga)

SELECT s.numeronfsaida, s.data, s.valortotal, s.idcliente, c.nome
FROM saidas AS s
WHERE s.idcliente = 1
AND s.data BETWEEN '2023-01-01' AND '2023-12-31'
ORDER BY s.data DESC;

-- Selecionar todas as entradas de uma determinada mercadoria, em um dado período (ordenando da mais antiga para a mais nova)

SELECT e.numeroNFEntrada, e.data, e.valorTotal
FROM entradas AS e
WHERE e.numeroNFEntrada IN (
    SELECT ie.numeroNFEntrada
    FROM itens_entrada AS ie
    WHERE ie.IDProduto = 2)
AND e.data BETWEEN '2023-01-01' AND '2023-12-31'
ORDER BY e.data;

-- Quais os fornecedores do produto “X”?

/* NÃO FOI POSSÍVEL ENCONTRAR POIS NÃO HÁ UMA RELAÇÃO (FK) ENTRE FORNECEDORES E PRODUTOS NOS SCRIPTS DDL REPASSADOS.

Para resolver o exercício eu adicionei uma coluna 'idfornecedor' como fk na tabela 'produtos' e rodei o seguinte script: */

SELECT nome AS nomeFornecedor
FROM fornecedores
WHERE IDFornecedor IN (
    SELECT idfornecedor
    FROM produtos
    WHERE descricao = 'X');

-- Quais os 10 produtos mais vendidos no período informado, em ordem decrescente?

SELECT p.descricao,
    (SELECT SUM(isd.quantidade)
    FROM itens_saida AS isd
    JOIN saidas s ON isd.numeronfsaida = s.numeronfsaida
    WHERE p.idproduto = isd.idproduto
    AND s.data BETWEEN '2023-01-01' AND '2023-12-31')
    as totalVendido
FROM produtos p
ORDER BY totalVendido DESC
LIMIT 10;


-- Qual o cliente que mais comprou (valor) no período informado?

SELECT c.nome AS cliente, (SELECT SUM(s.valorTotal)
FROM saidas s
WHERE c.idcliente = s.idcliente
AND s.data BETWEEN '2023-01-01' AND '2023-12-31') AS totalComprado
FROM clientes c
ORDER BY totalComprado DESC
LIMIT 1;