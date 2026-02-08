import mongoose from "mongoose";

const userSchema = new mongoose.Schema(
    {
        uid : {
            type: String,
            unique: true,
            required: true
        },
        fcmToken: {
            type: String,
            default: ""
        },
        fullName : {
            type: String,
            required: true
        },
        email : {
            type: String,
            unique: true,
            required: true
        },
        password : {
            type: String,
            required: true
        },
        phoneNumber : {
            type: String,
            unique: true,
            required: true
        },
        sapId : {
            type: String,
            unique: true,
            required: true
        }
    },
    {
        timestamps: true
    })

export const User = await mongoose.model("User", userSchema)



