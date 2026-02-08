import { Order } from '../models/order.models.js'
import { User } from '../models/user.models.js'

export const addOrderController = async (req) => {
    const uid = req.user.uid
    const user = await User.findOne({uid: uid})
    const { orderItems } = req.body
    const newOrder = new Order({
        userId: user._id,
        orderItems: orderItems,
    })
    await newOrder.save();
    return "Order Placed !!"
}