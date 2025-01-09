import database from '../repository/mysql.js';

async function getClienteById(id_cliente) {
  const sql = 'SELECT * FROM clientes WHERE id_cliente = ?';
  const conn = await database.connectDB();
  const [rows] = await conn.query(sql, [id_cliente]);
  conn.end();
  return rows[0];
}

async function getAllClientes() {
  const sql = 'SELECT * FROM clientes';
  const conn = await database.connectDB();
  const [rows] = await conn.query(sql);
  conn.end();
  return rows;
}

async function createCliente(nome, telefone, email, data_nascimento, alergia, CPF, cliente_frequente, beneficios, observacoes) {
  const sql = 'INSERT INTO clientes (nome, telefone, email, data_nascimento, alergia, CPF, cliente_frequente, beneficios, observacoes) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)';
  const conn = await database.connectDB();
  await conn.query(sql, [nome, telefone, email, data_nascimento, alergia, CPF, cliente_frequente, beneficios, observacoes]);
  conn.end();
}

async function updateCliente(id_cliente, nome, telefone, email, data_nascimento, alergia, CPF, cliente_frequente, beneficios, observacoes) {
  const sql = 'UPDATE clientes SET nome = ?, telefone = ?, email = ?, data_nascimento = ?, alergia = ?, CPF = ?, cliente_frequente = ?, beneficios = ?, observacoes = ? WHERE id_cliente = ?';
  const conn = await database.connectDB();
  await conn.query(sql, [nome, telefone, email, data_nascimento, alergia, CPF, cliente_frequente, beneficios, observacoes, id_cliente]);
  conn.end();
}

async function deleteCliente(id_cliente) {
  const sql = 'DELETE FROM clientes WHERE id_cliente = ?';
  const conn = await database.connectDB();
  await conn.query(sql, [id_cliente]);
  conn.end();
}

export default { getClienteById, getAllClientes, createCliente, updateCliente,  deleteCliente };