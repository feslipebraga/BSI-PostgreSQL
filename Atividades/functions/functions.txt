-- Função atualizaEstoque, que recebe três parâmetros: o estoque atual; a quantidade para atualizar; e, 0 se é para adicionar ou 1 se é para reduzir do estoque. Retorna a quantidade atualizada do estoque;

CREATE OR REPLACE FUNCTION atualizaEstoque(qtdAtual int, qtd int, opcao int)
RETURNS integer AS $$
	DECLARE
		quantidadeEstoque int;
	BEGIN
		IF opcao = 0 THEN
			quantidadeestoque = qtdAtual + qtd;
		ELSIF opcao = 1 THEN
			quantidadeestoque = qtdAtual - qtd;	
		END IF;
		RETURN quantidadeEstoque;
	END;
$$ LANGUAGE PLPGSQL;

SELECT atualizaEstoque(150, 20, 0);

-- Função ehNumeroPar, recebe como entrada um número e retorna verdadeiro (true) se for par ou falso (false) se for ímpar;

CREATE OR REPLACE FUNCTION ehNumeroPar(numero int)
RETURNS boolean AS $$
	BEGIN
		IF numero % 2 = 0 THEN
			RETURN true;
		ELSE
			RETURN false;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

SELECT ehNumeroPar(2);

-- Função Fatorial, recebe como entrada um número e calcula o valor fatorial desse número.

CREATE OR REPLACE FUNCTION fatorial(numero int)
RETURNS bigint AS $$
DECLARE
    resultado bigint := 1;
    i int := 1;
BEGIN
    WHILE i <= numero LOOP
        resultado := resultado * i;
        i := i + 1;
    END LOOP;
    RETURN resultado;
END;
$$ LANGUAGE PLPGSQL;

SELECT fatorial(5);