import express from "express"
import { authCheck } from "../middlewares/authCheck.js"
import { signupController } from "../controllers/signup.controller.js"
import { loginController } from "../controllers/login.controller.js"
import { updateFcmToken, clearFcmToken } from "../controllers/fcm.controller.js";

export const userRoute = express.Router()

userRoute.post('/signup/', authCheck, async (req,res) => {
    const msg = await signupController(req)
    res.json({"message": msg})
    console.log("User Signed Up")
})

userRoute.get('/login', authCheck, async (req,res) => {
    const msg = await loginController(req)
    let userType = "normal"
    if( msg == "admin123") userType = "undefined"
    res.json({"message": msg, "userType": userType})
    console.log("User Logged In!")
})

userRoute.patch("/update-fcm", authCheck, updateFcmToken);

userRoute.patch("/clear-fcm", authCheck, clearFcmToken);
