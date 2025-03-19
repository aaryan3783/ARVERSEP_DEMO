const mongoose = require("mongoose");

const careerSchema = new mongoose.Schema({
    title: { type: String, required: true },
    description: { type: String, required: true },
    company: { type: String, required: true },
    location: { type: String, required: true }
}, { timestamps: true });

const Career = mongoose.model("Career", careerSchema);
module.exports = Career;
