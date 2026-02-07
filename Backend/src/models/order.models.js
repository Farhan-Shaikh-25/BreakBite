import mongoose from "mongoose";

const orderSchema = new mongoose.Schema(
    {
        userId: {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'User',
            required: true
        },
        orderItems: [
            {
                itemId: {
                    type: mongoose.Schema.Types.ObjectId,
                    ref: 'Item',
                    required: true,
                },
                itemName: {
                    type: String,
                    required: true
                },
                itemPrice: {
                    type: Number,
                    required: true
                },
                quantity: {
                    type: Number,
                    required: true
                }
            }
        ],
        orderDate: {
            type: Date,
            default: Date.now()
        },
        totalAmount: {
            type: Number,
            default: 0
        },
        status: {
            type: String,
            enum: ["Processing", "Preparing", "Completed"],
            required: true,
            default: "Processing"
        }
    },
    {timestamps:true}
)

orderSchema.pre("save", function(){
    var total = 0
    this.orderItems.forEach(item => {
        total += item.itemPrice * item.quantity
    });
    this.totalAmount = total
})
export const Order = mongoose.model("Order", orderSchema)