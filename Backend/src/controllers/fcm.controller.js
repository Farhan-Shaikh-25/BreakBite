import { User } from "../models/user.models.js";


// 1. Save or Update the Token
export const updateFcmToken = async (req, res) => {
    try {
        const { fcmToken } = req.body;
        const uid = req.user.uid

        if (!uid || !fcmToken) {
            return res.status(400).json({ message: "UID and Token are required" });
        }

        // Find user by Firebase UID and update their token
        const user = await User.findOneAndUpdate(
            { uid: uid }, 
            { fcmToken: fcmToken },
            { new: true }
        );

        if (!user) {
            return res.status(404).json({ message: "User not found in MongoDB" });
        }

        res.status(200).json({ message: "FCM Token synced successfully" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

// 2. Clear Token on Logout
export const clearFcmToken = async (req, res) => {
    try {
        const uid = req.user.uid

        await User.findOneAndUpdate({ uid: uid }, { fcmToken: "" });

        res.status(200).json({ message: "FCM Token cleared" });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};