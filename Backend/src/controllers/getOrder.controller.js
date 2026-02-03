import { Order } from "../models/order.models.js";

export const getOrderController = async () => {
    const orders = await Order.find().sort({orderDate: -1})
    return orders
}