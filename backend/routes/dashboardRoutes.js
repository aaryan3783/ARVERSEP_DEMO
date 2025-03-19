const express = require("express");
const router = express.Router();
const mongoose = require("mongoose");

// Define Schema and use correct collection name
const dashboardSchema = new mongoose.Schema({}, { strict: false });
const Dashboard = mongoose.model("dashboard", dashboardSchema, "dashboard"); // Explicitly set "dashboard"

router.get("/", async (req, res) => {
    try {
        const data = await Dashboard.find(); // Fetch all documents
        if (!data || data.length === 0) {
            return res.status(404).json({ message: "No dashboard data found" });
        }
        res.status(200).json(data);
    } catch (error) {
        console.error(" Error fetching dashboard data:", error);
        res.status(500).json({ message: "Server error" });
    }
});

module.exports = router;
