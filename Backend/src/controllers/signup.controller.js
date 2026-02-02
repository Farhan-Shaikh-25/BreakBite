import { User } from "../models/user.models.js"

export const signupController = async (req) => {
    const token = req.user.uid
    const fname = req.body.uname
    const email = req.body.uemail
    const password = req.body.upass
    const pnum = req.body.upnum
    const sap = req.body.usap

    console.log(req.user)
    console.log(req.body)
    console.log(token)
    console.log(fname)
    console.log(email)
    console.log(password)
    console.log(pnum)
    console.log(sap)

    const userExists = await User.findOne({uid: token})

    if(userExists != null){ 
        console.log("UE")
        return "User Already Exists!"
    }

    const newUser = new User({
        uid : token,
        fullName : fname,
        email : email,
        password : password,
        phoneNumber : pnum,
        sapId : sap
    })
    await newUser.save()
    console.log(req.user)
    console.log(token)
    console.log(fname)
    console.log(email)
    console.log(password)
    console.log(pnum)
    console.log(sap)
    console.log("UC")
    return "User Creaated Successfully"
}