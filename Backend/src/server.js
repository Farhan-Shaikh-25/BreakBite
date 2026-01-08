import express from "express"
import dotenv from "dotenv"
import { userRoute } from "./routes/user.route.js";
import { DBConnect } from "./utils/db_connect.js";
dotenv.config()

const app = express();

app.use(express.json())
DBConnect()

app.use('/user', userRoute)

app.get("/",(req,res) => {
    console.log("request recieved")
    res.send("Hello There BreakBite")
})

// app.get("/signup/",authCheck,(req,res) => {
//     console.log("request recieved")
//     res.send(`Hello There BreakBite ${req.user.email}`)
// })

app.listen( process.env.PORT || 5000 , () => {console.log("Server Started")})