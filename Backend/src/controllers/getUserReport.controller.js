import { Order } from "../models/order.models.js";
import { User } from "../models/user.models.js";

export const getUserReportController = async (req) => {
    const user = await User.findOne({uid: req.user.uid})
    const orders = await Order.find({userId: user._id})
    let totalSpend = 0;
    let itemCounts = {}

    orders.map((order) => {
        totalSpend += order.totalAmount

        order.orderItems.forEach((item) => {
            if(itemCounts[item.itemName])
                itemCounts[item.itemName] += item.quantity
            else
                itemCounts[item.itemName] = item.quantity
        })
    })


    let favouriteItem = { name: null, quantity: 0}
    for (const [name, quantity] of Object.entries(itemCounts)) {
        if (quantity > favouriteItem.quantity) {
            favouriteItem = { name, quantity }
        }
    }
     
    return {"totalSpend": totalSpend, "favouriteItem": favouriteItem}
}