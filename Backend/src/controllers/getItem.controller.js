import { Item } from "../models/item.models.js"

export const getItemController = async () => {
    const items = await Item.find()
    return items
}