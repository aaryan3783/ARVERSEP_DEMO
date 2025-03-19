const mongoose = require("mongoose");

const videoSchema = new mongoose.Schema({
    name: { type: String, required: true },
    language: String,
    genre: String,
    category: String,
    duration: String,
    thumbnail: String,
    videoUrl: String
}, { timestamps: true });

const Video = mongoose.model("Video", videoSchema);
module.exports = Video;
