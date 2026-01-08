import mongoose from "mongoose";
import dotenv from "dotenv"
dotenv.config

export const DBConnect = async () =>{
    try {
        await mongoose.connect(
            process.env.MONGO_URI
        )
        console.log("Server Connected")
    } catch (error) {
        console.log("Error : "+error)
    }
}

