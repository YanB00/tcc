import database from '../repository/mysql.js';

async function getFuncionarioById(id_funcionario) {
  const sql = 'SELECT * FROM funcionarios WHERE id_funcionario = ?';
  const conn = await database.connectDB();
  const [rows] = await conn.query(sql, [id_funcionario]);
  conn.end();
  return rows[0]; 
}

async function getAllFuncionarios() {
  const sql = 'SELECT * FROM funcionarios';
  const conn = await database.connectDB();
  const [rows] = await conn.query(sql);
  conn.end();
  return rows;
}

async function createFuncionario(nome, cargo, telefone, salario, data_admissao, CPF, salao_id) {
  const sql = 'INSERT INTO funcionarios (nome, cargo, telefone, salario, data_admissao, CPF, salao_id) VALUES (?, ?, ?, ?, ?, ?, ?)';
  const conn = await database.connectDB();
  await conn.query(sql, [nome, cargo, telefone, salario, data_admissao, CPF, salao_id]);
  conn.end();
}

async function updateFuncionario(id_funcionario, nome, cargo, telefone, salario, data_admissao, CPF, salao_id) {
  const sql = 'UPDATE funcionarios SET nome = ?, cargo = ?, telefone = ?, salario = ?, data_admissao = ?, CPF = ?, salao_id = ? WHERE id_funcionario = ?';
  const conn = await database.connectDB();
  await conn.query(sql, [nome, cargo, telefone, salario, data_admissao, CPF, salao_id, id_funcionario]);
  conn.end();
}

async function deleteFuncionario(id_funcionario) {
  const sql = 'UPDATE FROM funcionarios SET deletado = 1 WHERE id_funcionario = ?'
  const conn = await database.connectDB();
  await conn.query(sql, [id_funcionario]);
  conn.end();
}

export default {
  getFuncionarioById, getAllFuncionarios, createFuncionario, updateFuncionario, deleteFuncionario
};