import express from 'express'
import { addItemController } from '../controllers/addItem.controller.js'

export const itemRoute = express.Router()

itemRoute.get('/', async (req,res) => {
    const msg = await getItemController()
    res.json({"message": msg})
})

itemRoute.post('/add', async (req,res) => {
    const msg = await addItemController(req)
    res.json({"message": msg})
})