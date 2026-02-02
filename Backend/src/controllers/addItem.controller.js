import { Item } from "../models/item.models.js"

export const addItemController = async (req) => {
    console.log(req)
    const itemExists = await Item.findOne({itemName: req.body.itemName})

    if(itemExists) return "Item Exists!"
    const newItem = new Item({
        itemName: req.body.itemName,
        itemPrice: req.body.itemPrice,
        category: req.body.category,
    })
    await newItem.save()
    return "Item Created Succssfully"
}