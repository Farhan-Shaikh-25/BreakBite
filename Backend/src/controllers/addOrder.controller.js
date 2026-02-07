import { Order } from '../models/order.models.js'

export const addOrderController = async (req) => {
    const { uid, orderItems} = req.body
    const newOrder = new Order({
        userId: uid,
        orderItems: orderItems,
        orderDate: Date.now()
    })
    await newOrder.save();
    return "Order Placed !!"
}