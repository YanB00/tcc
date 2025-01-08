import database from '../repository/mysql.js';

async function register(fullName, businessName, email, password, phone, cpf) {
    const sql = 'INSERT INTO tbl_saloes (nome_completo, nome_salao, email, senha, telefone, cpf) VALUES (?, ?, ?, ?, ?, ?)';
    const userData = [fullName, businessName, email, password, phone, cpf];

    const conn = await database.connectDB();
    await conn.query(sql, userData);
    conn.end();
}

export default { register };