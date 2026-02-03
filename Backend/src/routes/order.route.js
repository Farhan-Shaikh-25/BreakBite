import express from 'express'
import { getOrderController } from '../controllers/getOrder.controller.js'

export const orderRoute = express.Router()

orderRoute.get("/", async (req,res) => {
    const msg = await getOrderController()
    res.json({"message": msg})
})