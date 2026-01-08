import { admin } from "../utils/firebase_app.js"

export const authCheck = async (req,res,next) => {
    token = req.headers.authorization?.split(" ")[1]
    if(!token) res.status(401).send("Access denied No token");
    else{
        decodedToken = await admin.auth().verifyIdToken(token)
        req.user = decodedToken
        next()
    }
}
