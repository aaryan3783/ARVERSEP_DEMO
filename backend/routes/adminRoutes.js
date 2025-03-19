const express = require("express");
const Career = require("../models/career");
const router = express.Router();

// Get all career opportunities
router.get("/", async (req, res) => {
    try {
        const careers = await Career.find();

        if (careers.length === 0) {  // Check if no careers exist
            return res.status(404).json({ message: "No career opportunities found in the database" });
        }

        res.status(200).json(careers);
    } catch (error) {
        res.status(500).json({ message: "Error fetching careers", error });
    }
});

module.exports = router;
