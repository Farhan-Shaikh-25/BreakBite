import mongoose from "mongoose";

const itemSchema = new mongoose.Schema(
    {
        itemName: {
            type: String,
            required: true,
            unique: true
        },
        itemPrice: {
            type: Number,
            required: true
        },
        category: {
            type: String,
            enum: ["Drinks", "Snacks", "Thali", "South Indian"],
            required: true
        }
    },
    {timestamps: true}
)

export const Item = new mongoose.model("Item", itemSchema)
