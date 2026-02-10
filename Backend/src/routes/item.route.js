import express from 'express'
import { addItemController } from '../controllers/addItem.controller.js'
import { getItemController } from '../controllers/getItem.controller.js'

export const itemRoute = express.Router()

itemRoute.get('/', async (req,res) => {
    const msg = await getItemController()
    console.log("Item Sent Successfully")
    res.json({"message": msg})
})

itemRoute.post('/add', async (req,res) => {
    const msg = await addItemController(req)
    console.log("Item Added Successfully")
    res.json({"message": msg})
})