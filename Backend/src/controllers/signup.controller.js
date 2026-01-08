import { User } from "../models/user.model.js"

export const signupController = async (req) => {
    token = req.body.user
    fname - req.body.uname
    pnum = req.body.pnum
    sap = req.body.sap

    const userExists = await User.findOne(token.uid)

    if(userExists){
        return "User Already Exists!"
    }
    
    const newUser = new User({
        _id : token.uid,
        fullName : fname,
        email : token.email,
        password : token.password,
        phoneNumber : pnum,
        sapId : sap
    })
    await newUser.save()
    return "User Creaated Successfully"
}