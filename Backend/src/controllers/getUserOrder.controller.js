import { Order } from "../models/order.models.js";
import { User } from "../models/user.models.js";

export const getUserOrderController = async (req) => {
    const uid = req.user.uid
    const user = await User.findOne({uid: uid})
    const orders = await Order.find({ userId: user._id }).sort({orderDate: -1})
    console.log(orders)
    return orders
}