import { Order } from "../models/order.models.js";

export const updateStatusController = async (req) => {
    const {id, newStatus} = req.body
    const order = await Order.findByIdAndUpdate({ _id : id }, {status : newStatus})
    return "Status Changed"
}