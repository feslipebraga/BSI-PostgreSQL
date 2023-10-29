CREATE TABLE usuarios (
    IDUsuario SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    senha VARCHAR(10) NOT NULL,
    tipoDeUsuario INTEGER NOT NULL DEFAULT 0, -- USUARIOS: 0-normal (DEFAULT), 1-gerente, 2-admin
	logradouro VARCHAR(50),
    numero INTEGER,
    complemento VARCHAR(50),
    cep VARCHAR(8),
    cidade VARCHAR(50),
    uf VARCHAR(2)
);

CREATE TABLE fornecedores (
    IDFornecedor SERIAL PRIMARY KEY,
    nome VARCHAR(50),
    email VARCHAR(50),
    logradouro VARCHAR(50),
    numero VARCHAR(10),
    complemento VARCHAR(50),
    cep VARCHAR(8),
    cidade VARCHAR(50),
    uf VARCHAR(2)
);

CREATE TABLE clientes (
    IDCliente SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    logradouro VARCHAR(50) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(50) NOT NULL,
    cep VARCHAR(8) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    uf VARCHAR(2) NOT NULL
);

CREATE TABLE categorias (
	IDCategoria SERIAL PRIMARY KEY,
	descricao VARCHAR(50) NOT NULL
);

CREATE TABLE produtos (
    IDProduto SERIAL PRIMARY KEY,
    Descricao VARCHAR(50) NOT NULL,
    PrecoCusto DECIMAL DEFAULT 0,
    precoVenda DECIMAL DEFAULT 0,
    quantidadeEstoque INTEGER DEFAULT 0,
    IDCategoria INTEGER NOT NULL,
    FOREIGN KEY (IDCategoria) REFERENCES categorias (IDCategoria) ON DELETE CASCADE
);

CREATE TABLE entradas (
    numeroNFEntrada SERIAL PRIMARY KEY,
	data DATE NOT NULL,
    valorTotal DECIMAL,
    IDFornecedor INTEGER NOT NULL,
    FOREIGN KEY (IDFornecedor) REFERENCES fornecedores (IDFornecedor) ON DELETE CASCADE
);

CREATE TABLE saidas (
    numeroNFSaida SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    valorTotal DECIMAL NOT NULL,
    IDCliente INTEGER NOT NULL,
    IDUsuario INTEGER NOT NULL,
    FOREIGN KEY (IDCliente) REFERENCES clientes (IDCliente) ON DELETE CASCADE,
    FOREIGN KEY (IDUsuario) REFERENCES usuarios (IDUsuario) ON DELETE CASCADE
);

CREATE TABLE itens_saida (
    IDItemVenda SERIAL PRIMARY KEY,
    quantidade INTEGER NOT NULL,
    valorUnitario DECIMAL NOT NULL,
    numeroNFSaida INTEGER NOT NULL,
    IDProduto INTEGER NOT NULL,
    FOREIGN KEY (numeroNFSaida) REFERENCES saidas (numeroNFSaida) ON DELETE CASCADE,
    FOREIGN KEY (IDProduto) REFERENCES produtos (IDProduto)
);

CREATE TABLE itens_entrada (
    IDItemCompra SERIAL PRIMARY KEY,
    quantidade INTEGER NOT NULL,
    valorUnitario DECIMAL NOT NULL,
    IDProduto INTEGER NOT NULL,
    numeroNFEntrada INTEGER NOT NULL,
    FOREIGN KEY (IDProduto) REFERENCES produtos (IDProduto) ON DELETE CASCADE,
    FOREIGN KEY (numeroNFEntrada) REFERENCES entradas (numeroNFEntrada) ON DELETE CASCADE
);
