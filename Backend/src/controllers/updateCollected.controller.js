import { Order } from "../models/order.models.js";
import { User } from "../models/user.models.js";
import { admin } from "../utils/firebase_app.js";

export const updateCollectedController = async (req) => {
    const {id} = req.body
    const order = await Order.findByIdAndUpdate({ _id : id }, {status : "Collected"})
    return "Order Collected"
}