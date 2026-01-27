import { User } from "../models/user.models.js";

export const loginController = async (req) => {
    const token = req.user.uid
    const fname = await User.findOne({uid: token}).select("fullName")
    return fname.fullName
}   