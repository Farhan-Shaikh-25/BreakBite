import { Order } from "../models/order.models.js";
import { User } from "../models/user.models.js";
import { admin } from "../utils/firebase_app.js";


export const updateStatusController = async (req) => {
    const {id, newStatus} = req.body
    const order = await Order.findByIdAndUpdate({ _id : id }, {status : newStatus}, {new : true})
    if (newStatus == "Completed") {
        const user = await User.findById(order.userId);
        console.log(user)
        console.log(user.fcmToken)
        if (user && user.fcmToken) {
            try {
                const message = {
                    notification: {
                        title: "BreakBite: Food is Ready!",
                        body: `Order #${order._id.toString().slice(-4)} is ready for pickup.`,
                    },
                    token: user.fcmToken,
                };

                const response = await admin.messaging().send(message);
                console.log("✅ FCM Success Response:", response); 
            } catch (fcmError) {
                console.error("❌ FCM Error Details:", fcmError);
            }
            console.log("Notification sent successfully to:", user.email);
        }
    }
    return "Status Changed"
}