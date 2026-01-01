const express = require("express")
const admin = require("firebase-admin")
const serviceAccount = require("../serviceAccount.json")
require("dotenv").config();

admin.initializeApp({
    credential : admin.credential.cert(serviceAccount)
})

const authCheck = async (req,res,next) => {
    token = req.headers.authorization?.split(" ")[1]
    if(!token) res.status(401).send("Access denied No token");
    else{
        decodedToken = await admin.auth().verifyIdToken(token)
        req.user = decodedToken
        next()
    }
}


const app = express();

app.get("/",(req,res) => {
    console.log("request recieved")
    res.send("Hello There BreakBite")
})

app.get("/login/",authCheck,(req,res) => {
    console.log("request recieved")
    res.send(`Hello There BreakBite ${req.user.email}`)
})

app.listen( process.env.PORT || 5000 , () => {console.log("Server Started")})