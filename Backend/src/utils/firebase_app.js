import firebase from "firebase-admin"
import serviceAccount from "../../serviceAccount.json" with {type:'json'}

export const admin = firebase.initializeApp({
    credential: firebase.credential.cert(serviceAccount)
})
