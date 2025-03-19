const mongoose = require("mongoose");

const dashboardSchema = new mongoose.Schema({
    usersCount: Number,
    totalVideos: Number,
    activeJobs: Number
}, { timestamps: true });

const Dashboard = mongoose.model("Dashboard", dashboardSchema);
module.exports = Dashboard;
