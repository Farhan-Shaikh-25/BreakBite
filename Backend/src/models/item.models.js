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
            enum: ["Beverages", "Snacks", "Thali", "South Indian"],
            required: true
        }
    },
    {timestamps: true}
)

export const Item = mongoose.model("Item", itemSchema)
