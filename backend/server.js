require("dotenv").config(); // Load environment variables
const express = require("express");
const cors = require("cors");
const { connectDB } = require("./config/database");
const adminRoutes = require("./routes/adminRoutes");

const app = express();
//

// Middleware
app.use(cors());
app.use(express.json()); // Replaces body-parser

// ** Connect to Database **
connectDB().then(() => {
    console.log(" Database Connected");
}).catch((error) => {
    console.error(" Database Connection Failed:", error);
    process.exit(1); // Stop the server if DB connection fails
});
// Routes
const userRoutes = require("./routes/userRoutes");
const videoRoutes = require("./routes/videoRoutes");
const careerRoutes = require("./routes/careerRoutes");
const dashboardRoutes = require("./routes/dashboardRoutes");

app.use("/user", userRoutes);
app.use("/videos", videoRoutes);
app.use("/careers", careerRoutes);
app.use("/dashboard", dashboardRoutes);
app.use("/admin", adminRoutes);

// Default Route (To Handle Undefined Routes)
app.use((req, res) => {
    res.status(404).json({ error: "Route Not Found" });
});
// Start Server
const PORT = process.env.PORT || 8000;
app.listen(PORT, () => {
    console.log(` Server running on port ${PORT}`);
});
