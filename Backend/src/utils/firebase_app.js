import firebase from "firebase-admin"
import dotenv from "dotenv"
dotenv.config()

const serviceAccount = JSON.parse(process.env.FIREBASE_SERVICE_ACCOUNT)
export const admin = firebase.initializeApp({
    credential: firebase.credential.cert(serviceAccount)
})
