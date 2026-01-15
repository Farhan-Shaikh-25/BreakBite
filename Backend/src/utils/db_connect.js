import mongoose from "mongoose";
import { Order } from "../models/order.models.js";
import dotenv from "dotenv"
dotenv.config

export const DBConnect = async () =>{
    try {
        await mongoose.connect(
            process.env.MONGO_URI
        )
        console.log("Server Connected")
        // const sampleOrder = new Order({
        //     userId: "659f1a2b3c4d5e6f7a8b9c0d", // Mock User ID
        //     orderItems: [
        //         {
        //             itemId: "659f1a2b3c4d5e6f7a8b9111", // Samosa ID
        //             itemName: "Samosa",
        //             itemPrice: 15,
        //             quantity: 2
        //         },
        //         {
        //             itemId: "659f1a2b3c4d5e6f7a8b9222", // Tea ID
        //             itemName: "Chai",
        //             itemPrice: 10,
        //             quantity: 1
        //         }
        //     ],
        //     orderDate: Date.now(),
        //     // Note: We are NOT sending totalAmount or orderDate
        //     status: "Processing"
        // });

        // const savedOrder = await sampleOrder.save();
        
        // console.log("✅ Order Saved Successfully!");
        // console.log("Calculated Total:", savedOrder.totalAmount); 
        // // Should be (15*2) + (10*1) = 40
        
        // console.log("Order Date:", savedOrder.orderDate);
    } catch (error) {
        console.log("Error : "+error)
    }
    
}

