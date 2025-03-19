const express = require("express");
const router = express.Router();
const User = require("../models/user"); // Import User model (adjust path if needed)

// Login Route: Check if user exists
router.post("/login", async (req, res) => {
    try {
        const { email, password } = req.body;

        // Check if user exists
        const user = await User.findOne({ email });

        if (!user) {
            return res.status(404).json({ message: "User not found" });
        }

        // Compare passwords (Without Hashing)
        if (password !== user.password) {
            return res.status(401).json({ message: "Invalid credentials" });
        }

        res.status(200).json({ message: "Login successful", user });
    } catch (error) {
        console.error("Login error:", error);
        res.status(500).json({ message: "Server error" });
    }
});

// Get all user emails
router.get("/", async (req, res) => {
    try {
        const users = await User.find({}, "email"); // Retrieve only emails
        res.status(200).json(users);
    } catch (error) {
        console.error("Fetch users error:", error);
        res.status(500).json({ message: "Server error" });
    }
});


module.exports = router;
