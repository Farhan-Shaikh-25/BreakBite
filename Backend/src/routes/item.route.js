import express from 'express'
import { addItemController } from '../controllers/addItem.controller.js'
import { getItemController } from '../controllers/getItem.controller.js'
import { adminCheck } from '../middlewares/adminCheck.js'
import { authCheck } from '../middlewares/authCheck.js'

export const itemRoute = express.Router()

itemRoute.get('/', authCheck, async (req,res) => {
    const msg = await getItemController()
    console.log("Item Sent Successfully")
    res.json({"message": msg})
})

itemRoute.post('/add', adminCheck, async (req,res) => {
    const msg = await addItemController(req)
    console.log("Item Added Successfully")
    res.json({"message": msg})
})