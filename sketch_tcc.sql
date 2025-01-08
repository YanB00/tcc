create database sketch_tcc;

use sketch_tcc;

CREATE TABLE saloes (
	id_salao int primary key auto_increment,
    nome_completo VARCHAR (100) NOT NULL,
    nome_salao VARCHAR(100) NOT NULL,
    cpf CHAR (11) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(255) NOT NULL
);

CREATE TABLE clientes(
id_cliente int primary key auto_increment,
nome varchar(100),
telefone VARCHAR(20),
email VARCHAR(100),
data_nascimento DATE,
alergia varchar(30),
CPF CHAR (11) UNIQUE NOT NULL,
cliente_frequente ENUM('sim', 'não') DEFAULT 'não',
beneficios VARCHAR(255),
observacoes TEXT
);

CREATE TABLE funcionarios(
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    cargo VARCHAR(50),
    telefone VARCHAR(20),
    salario DECIMAL(10,2),
    data_admissao DATE,
    CPF CHAR(11) UNIQUE NOT NUll,
    salao_id int,
    foreign key (salao_id) REFERENCES saloes(id_salao)
);

CREATE TABLE categorias(
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(70),
    descricao TEXT
);

CREATE TABLE servicos(
    id_servico INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    descricao TEXT,
    preco DECIMAL(10,2),
    duracao INT,
    tempo_preparo TIME,
    nota_media DECIMAL(3,1),
	numero_avaliacoes INT,
	comentarios TEXT,
    categoria_id int,
	FOREIGN KEY (categoria_id) REFERENCES categorias(id_categoria)
);

CREATE TABLE fornecedores(
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    telefone VARCHAR(20),
    email VARCHAR(100),
    CNPJ VARCHAR(14) UNIQUE NOT NULL
);

CREATE TABLE produtos(
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    descricao TEXT,
    preco_compra DECIMAL(10,2),
    preco_venda DECIMAL(10,2),
    quantidade INT,
    validade DATE,
    unidade_medida VARCHAR(20),
	id_fornecedor INT,
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedores(id_fornecedor)
);

CREATE TABLE historico_precos (
  id_historico INT PRIMARY KEY AUTO_INCREMENT,
  id_produto INT,
  preco DECIMAL(10,2),
  data_inicio DATE,
  data_fim DATE,
  FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

CREATE TABLE formas_pagamento (
    id_forma_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(50) NOT NULL
);

CREATE TABLE agendamentos(
    id_agendamento INT PRIMARY KEY AUTO_INCREMENT,
    data_hora DATETIME,
    observacao TEXT,
	valor_pago DECIMAL(10,2),
    data_pagamento DATETIME,
	status_agenda ENUM('confirmado','cancelado','realizado', 'aguardando confirmacao','Reagendado') NOT NULL,
	forma_pagamento_id int,
	id_cliente INT,
    id_funcionario INT,
    id_servico INT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario),
    FOREIGN KEY (id_servico) REFERENCES servicos(id_servico),
    FOREIGN KEY (forma_pagamento_id) REFERENCES formas_pagamento(id_forma_pagamento)
);

CREATE TABLE horarios_atendimento (
    id_horario INT PRIMARY KEY AUTO_INCREMENT,
    funcionario_id INT,
    dia_semana ENUM('domingo', 'segunda', 'terça', 'quarta', 'quinta', 'sexta', 'sabado'),
    hora_inicio TIME,
    hora_fim TIME,
    FOREIGN KEY (funcionario_id) REFERENCES funcionarios(id_funcionario)
);

CREATE TABLE avaliacoes (
    id_avaliacao INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    id_servico INT,
    id_funcionario INT,
    nota INT,
    comentario TEXT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_servico) REFERENCES servicos(id_servico),
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario)
);

CREATE TABLE compras (
    id_compra INT PRIMARY KEY AUTO_INCREMENT,
    data_compra DATE,
    numero_pedido VARCHAR(50),
    valor_total DECIMAL(10,2),
    condicao_pagamento VARCHAR(50),
    forma_pagamento_id int,
	fornecedor_id INT,
    FOREIGN KEY (fornecedor_id) REFERENCES fornecedores(id_fornecedor),
    FOREIGN KEY (forma_pagamento_id) REFERENCES formas_pagamento(id_forma_pagamento)
);

CREATE TABLE itens_compra (
    id_item_compra INT PRIMARY KEY AUTO_INCREMENT,
    id_compra INT,
    id_produto INT,
    quantidade INT,
    valor_unitario DECIMAL(10,2),
    FOREIGN KEY (id_compra) REFERENCES compras(id_compra),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

CREATE TABLE estoques(
    id_estoque INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT,
    quantidade INT,
    data_entrada DATE,
    valor_total DECIMAL(10,2),
    qt_minima int,
    data_validade DATE,
    tipo_movimentacao ENUM('entrada', 'saida') NOT NULL,
    fornecedor_id int,
    item_compra_id INT,
    FOREIGN KEY (fornecedor_id) REFERENCES fornecedores(id_fornecedor),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    FOREIGN KEY (item_compra_id) REFERENCES itens_compra(id_item_compra)
);

CREATE TABLE vendas(
id_venda INT PRIMARY KEY AUTO_INCREMENT,
data_venda DATETIME,
valor_total DECIMAL (10,2),
condicao_pagamento VARCHAR(50),
id_cliente INT,
id_funcionario INT,
forma_pagamento_id int,
FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
foreign key (id_funcionario) REFERENCES funcionarios(id_funcionario),
FOREIGN KEY (forma_pagamento_id) REFERENCES formas_pagamento(id_forma_pagamento)
);

CREATE TABLE itens_venda(
id_item INT PRIMARY KEY AUTO_INCREMENT,
id_venda INT,
id_produto INT,
quantidade INT,
valor_unitario DECIMAL(10,2),
valor_total DECIMAL(10,2),
desconto INT,
FOREIGN KEY (id_venda) REFERENCES vendas(id_venda),
FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

CREATE TABLE controle_financeiro(
    id_transacao INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(100),
    valor DECIMAL(10,2),
    data_transacao DATETIME,
    tipo ENUM('Receita', 'Despesa'),
    forma_pagamento VARCHAR(50),
    categoria_transacao ENUM('salario','conta', 'venda','outros') NOT NULL,
    venda_id INT,
    produto_id INT,
    funcionario_id INT,
    fornecedor_id INT,
	FOREIGN KEY (venda_id) REFERENCES vendas(id_venda),
	FOREIGN KEY (produto_id) REFERENCES produtos(id_produto),
	FOREIGN KEY (funcionario_id) REFERENCES funcionarios(id_funcionario),
	FOREIGN KEY (fornecedor_id) REFERENCES fornecedores(id_fornecedor)
);

CREATE TABLE promocoes (
  id_promocao INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100),
  desconto DECIMAL(10,2),
  data_inicio DATE,
  data_fim DATE,
  periodo VARCHAR(55)
  );
  
CREATE TABLE promocao_servico (
    id_promocao_servico INT PRIMARY KEY AUTO_INCREMENT,
    id_promocao INT,
    id_servico INT,
    FOREIGN KEY (id_promocao) REFERENCES promocoes(id_promocao),
    FOREIGN KEY (id_servico) REFERENCES servicos(id_servico)
);

CREATE TABLE promocao_produto (
    id_promocao_produto INT PRIMARY KEY AUTO_INCREMENT,
    id_promocao INT,
    id_produto INT,
    FOREIGN KEY (id_promocao) REFERENCES promocoes(id_promocao),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);




CREATE TABLE custo_fixo(
id_custo_fixo INT PRIMARY KEY auto_increment,
descricao VARCHAR(100) NOT NULL,
valor DECIMAL (10,2) NOT NULL
);

CREATE TABLE custo_variavel(
id_custo_varivael INT PRIMARY KEY auto_increment,
descricao VARCHAR(100) NOT NULL,
valor DECIMAL(10,2) NOT NULL,
data DATE NOT NULL
);