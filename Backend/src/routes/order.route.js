import express from 'express'
import { getOrderController } from '../controllers/getOrder.controller.js'
import { addOrderController } from '../controllers/addOrder.controller.js'
import { updateStatusController } from '../controllers/updateStatusController.js'

export const orderRoute = express.Router()

orderRoute.get("/", async (req,res) => {
    const msg = await getOrderController()
    res.json({"message": msg})
    console.log("Data sent")
})

orderRoute.post("/add", async (req,res) => {
    const msg = await addOrderController(req)
    res.json({"message": msg})
    console.log("Order added")
})

orderRoute.patch("/updatestatus", async (req,res) => {
    const msg = await updateStatusController(req)
    res.json({"message": msg})
    console.log("Status Updated")
})
