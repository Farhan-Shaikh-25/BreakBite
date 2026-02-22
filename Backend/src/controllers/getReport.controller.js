import { Order } from "../models/order.models.js";

export const getReportController = async (req) => {
    const timeRange = req.params.tr;
    const startDate = new Date()
    startDate.setHours(0,0,0,0)
    if(timeRange == "monthly"){
        startDate.setDate(1)
    }
    else if(timeRange == "weekly"){
        let day = startDate.getDay()
        let diff = day == 0 ? 6 : day - 1
        startDate.setDate(startDate.getDate() - diff)
    }
   
    const orders = await Order.find({
        createdAt: { $gte: startDate },
        status: { $in: ["Completed", "Collected"] }
    });

    let totalSales = 0;
    const itemCounts = {}; 
    const hourCounts = {}; 

    orders.forEach(order => {
        
        // --- A. Add to Total Sales ---
        totalSales += order.totalAmount;

        // --- B. Tally Items ---
        order.orderItems.forEach(item => {
            if (itemCounts[item.itemName]) {
                itemCounts[item.itemName] += item.quantity;
            } else {
                itemCounts[item.itemName] = item.quantity;
            }
        });

        const istString = order.createdAt.toLocaleString("en-US", { timeZone: "Asia/Kolkata" });
        const istDate = new Date(istString);
        const hour = istDate.getHours(); 

        if (hourCounts[hour]) {
            hourCounts[hour]++;
        } else {
            hourCounts[hour] = 1;
        }
    });

    let mostSoldProduct = { name: null, quantity: 0 };
    for (const [name, quantity] of Object.entries(itemCounts)) {
        if (quantity > mostSoldProduct.quantity) {
            mostSoldProduct = { name, quantity };
        }
    }

    let peakHour = { hour: null, ordersPlaced: 0 };
    for (const [hour, count] of Object.entries(hourCounts)) {
        if (count > peakHour.ordersPlaced) {
            peakHour = { hour: parseInt(hour), ordersPlaced: count };
        }
    }

    return {
        "totalSales": totalSales,
        "mostSoldProduct": mostSoldProduct,
        "peakHour": peakHour
    }
}