import { admin } from "../utils/firebase_app.js"

export const authCheck = async (req,res,next) => {
    const token = req.headers.authorization?.split(" ")[1]
    if(!token) res.status(401).json({"message": "Access denied No token"});
    else{
        const decodedToken = await admin.auth().verifyIdToken(token)
        req.user = decodedToken
        console.log("User Auth done")
        next()
    }
}
