import express from "express"
import { authCheck } from "../middlewares/authCheck.js"
import { signupController } from "../controllers/signup.controller.js"
import { loginController } from "../controllers/login.controller.js"

export const userRoute = express.Router()

userRoute.post('/signup/', authCheck, async (req,res) => {
    const msg = await signupController(req)
    res.json({"message": msg})
})

userRoute.get('/login', authCheck, async (req,res) => {
    const msg = await loginController(req)
    res.json({"message": msg})
})
