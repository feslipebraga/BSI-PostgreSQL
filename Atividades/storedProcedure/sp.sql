-- Incluir Fornecedor.

CREATE OR REPLACE PROCEDURE
	incluirFornecedor(nome varchar(50), email varchar(50), logradouro varchar(50), numero varchar(10), complemento varchar(50), cep varchar(8), cidade varchar(50), uf varchar(2))
	AS $$
	BEGIN
		INSERT INTO fornecedores (nome, email, logradouro, numero, complemento, cep, cidade, uf)
		VALUES (nome, email, logradouro, numero, complemento, cep, cidade, uf);
	END
	$$ LANGUAGE PLPGSQL;

CALL incluirFornecedor('Fornecedor A', 'fornecedor_a@example.com', 'Avenida Central', '1234', 'Sala 101', '54321123', 'Cidade ABC', 'SP');

-- Incluir Produto.

CREATE OR REPLACE PROCEDURE
	incluirProduto(descricao varchar, precocusto float, precovenda float, quantidadeestoque int, idcategoria int)
	AS $$
	BEGIN
		INSERT INTO produtos (descricao, precocusto, precovenda, quantidadeestoque, idcategoria)
		VALUES (descricao, precocusto, precovenda, quantidadeestoque, idcategoria);
	END
	$$ LANGUAGE PLPGSQL;


call incluirProduto('iPhone 11', 1600, 2300, 10, 1);

-- Atualizar estoque (saída).

CREATE OR REPLACE PROCEDURE
	p_attEstoqueSaida(a_idproduto int, a_quantidade int)
	AS $$
	BEGIN
		UPDATE produtos
		SET quantidadeestoque = quantidadeestoque - a_quantidade
		WHERE idproduto = a_idproduto;
	END
	$$
	LANGUAGE plpgsql;

CALL p_attEstoqueSaida(1, 20);

-- Atualizar estoque (entrada: estoque, preço custo, preço de venda).

CREATE OR REPLACE PROCEDURE p_attEstoqueEntrada(a_id int, a_quantidade int, a_precocusto decimal, a_precovenda decimal)
	AS $$
	BEGIN
		UPDATE produtos
		SET quantidadeestoque = quantidadeestoque + a_quantidade, precocusto = a_precocusto, precovenda = a_precovenda
		WHERE idproduto = a_id;
	END
	$$
	LANGUAGE PLPGSQL;

CALL p_attEstoqueEntrada(6, 20, 1500, 2150);
