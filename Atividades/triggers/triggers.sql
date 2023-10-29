-- TABELA
CREATE TABLE logs (
    id SERIAL PRIMARY KEY,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tableName TEXT NOT NULL,
    oldData TEXT DEFAULT '',
    newData TEXT DEFAULT ''
);

-- FUNCTION
CREATE OR REPLACE FUNCTION f_registraLogSaidas()
RETURNS TRIGGER AS $$
DECLARE
    tabela TEXT;
    dadosAntigos TEXT;
    dadosNovos TEXT;
BEGIN
    tabela = 'SAIDAS';
    IF TG_OP = 'UPDATE' THEN
        dadosAntigos = ROW(OLD.*);
        dadosNovos = ROW(NEW.*);
        INSERT INTO logs (tableName, oldData, newData)
        VALUES (tabela, dadosAntigos, dadosNovos);
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        dadosAntigos = ROW(OLD.*);
        INSERT INTO logs (tableName, oldData, newData)
        VALUES (tabela, dadosAntigos, DEFAULT);
        RETURN OLD;
    ELSIF TG_OP = 'INSERT' THEN
        dadosNovos = ROW(NEW.*);
        INSERT INTO logs (tableName, oldData, newData)
        VALUES (tabela, DEFAULT, dadosNovos);
        RETURN NEW;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- TRIGGER
CREATE TRIGGER t_registraLogSaidas
AFTER INSERT OR UPDATE OR DELETE ON saidas
FOR EACH ROW
EXECUTE FUNCTION f_registraLogSaidas();

-- INSERT
INSERT INTO saidas (data, valorTotal, IDCliente, IDUsuario)
VALUES ('2023-10-22', 100.50, 1, 1);

INSERT INTO saidas (data, valorTotal, IDCliente, IDUsuario)
VALUES ('2023-10-23', 150.75, 1, 1);

-- UPDATE
UPDATE saidas
SET valorTotal = 120.00
WHERE numeroNFSaida = 4;

UPDATE saidas
SET IDCliente = 1
WHERE numeroNFSaida = 5;

-- DELETE
DELETE FROM saidas
WHERE numeroNFSaida = 4;

DELETE FROM saidas
WHERE numeroNFSaida = 4;

-- VERIFICA COMO ESTÃO AS TABELAS
SELECT * FROM SAIDAS;

-- LOG COM TODAS AS OPERACOES NA TABELA 'SAIDAS'
SELECT * FROM LOGS;
