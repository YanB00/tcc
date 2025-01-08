import express from "express";
import registrationServices from "../services/registrationServices.js";

const router = express.Router();

router.post('/', async (req, res) => {
  const { fullName, businessName, email, password, phone, cpf } = req.body;

  try {
    await registrationServices.register(fullName, businessName, email, password, phone, cpf);
    res.status(201).send({ message: 'Usuário cadastrado com sucesso!' });
  } catch (err) {
    console.error(err);
    res.status(500).send({ message: 'Erro ao cadastrar usuário.' });
  }
});

export default router;