import { Order } from "../models/order.models.js";
import { User } from "../models/user.models.js";
import { admin } from "../utils/firebase_app.js";

export const updateCollectedController = async (req) => {
    const {id} = req.body
    const order = await Order.findByIdAndUpdate({ _id : id }, {status : newStatus})
    const user = await User.findById(order.userId);

    if (user && user.fcmToken) {
        const message = {
            notification: {
                title: "BreakBite: Food is Ready!",
                body: `Order #${order._id.toString().slice(-4)} is ready for pickup.`,
            },
            token: user.fcmToken, 
        };
        await admin.messaging().send(message);
        console.log("Notification sent successfully to:", user.email);
    }
    return "Order Collected"
}