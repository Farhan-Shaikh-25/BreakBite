import express from "express"
import { authCheck } from "../middlewares/authCheck.js"

export const userRoute = express.Router()

userRoute.post('/signup/', authCheck, (req,res) => {
    msg = signupController(req)
    res.json({"message": msg})
})
