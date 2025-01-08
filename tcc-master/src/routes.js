import express from "express";
import registerControllers from "./controllers/registerControllers.js"
import loginControllers from './controllers/logincontrollers.js'


const routes = express.Router();

routes.use("/register", registerControllers)
routes.use("/login", loginControllers)

export default routes;