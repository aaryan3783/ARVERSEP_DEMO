const express = require("express");
const Career = require("../models/career");
const router = express.Router();

// Get all career opportunities
router.get("/", async (req, res) => {
    try {
        const careers = await Career.find();
        
        res.status(200).json(careers);
    } catch (error) {
        res.status(500).json({ message: "Error fetching careers", error });  
    }

});

module.exports = router;
