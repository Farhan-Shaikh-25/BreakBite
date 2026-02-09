import express from 'express'
import { getOrderController } from '../controllers/getOrder.controller.js'
import { addOrderController } from '../controllers/addOrder.controller.js'
import { updateStatusController } from '../controllers/updateStatusController.js'
import { authCheck } from '../middlewares/authCheck.js'
import { getUserOrderController } from '../controllers/getUserOrder.controller.js'
import { updateCollectedController } from '../controllers/updateCollected.controller.js'

export const orderRoute = express.Router()

orderRoute.get("/", async (req,res) => {
    const msg = await getOrderController()
    res.json({"message": msg})
    console.log("Data sent")
})

orderRoute.get("/user", authCheck, async (req,res) => {
    const msg = await getUserOrderController(req)
    res.json({"message": msg})
    console.log("User data sent")
})

orderRoute.post("/add", authCheck, async (req,res) => {
    const msg = await addOrderController(req)
    res.json({"message": msg})
    console.log("Order added")
})

orderRoute.patch("/updatestatus", async (req,res) => {
    const msg = await updateStatusController(req)
    res.json({"message": msg})
    console.log("Status Updated")
})

orderRoute.patch("/updatecollected", async (req,res) => {
    const msg = await updateCollectedController(req)
    res.json({"message": msg})
    console.log("Status Updated")
})
