const express = require("express");
const Video = require("../models/video");

const router = express.Router();

// Get all videos
router.get("/", async (req, res) => {
    try {
        const videos = await Video.find();
        if (videos.length == 0 ){
            res.status(401).json("videos data not found");
        }
        res.status(200).json(videos);
    } catch (error) {
        res.status(500).json({ message: "Error fetching videos", error });
    }
});

module.exports = router;
