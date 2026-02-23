import { User } from "../models/user.models.js"

export const signupController = async (req) => {
    const token = req.user.uid
    const fname = req.body.uname
    const email = req.body.uemail
    const password = req.body.upass
    const pnum = req.body.upnum
    const sap = req.body.usap

    const userExists = await User.findOne({uid: token})

    if(userExists != null){ 
        console.log("User Exists")
        return "User Already Exists!"
    }
    
    try{
    const newUser = new User({
        uid : token,
        fullName : fname,
        email : email,
        password : password,
        phoneNumber : pnum,
        sapId : sap
    })
    await newUser.save()
    console.log("User Created")
    return "User Creaated Successfully"
}catch(e){
    console.log("Duplicate fields")
    return "Duplicate Fields"
}
}
