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
        if(users.length == 0){
            res.status(401).json("No Users Data  Found");
        }

        res.status(200).json(users);
    } catch (error) {
        console.error("Fetch users error:", error);
        res.status(500).json({ message: "Server error" });
    }
});

router.get("/detail", async (req, res) => {
    try {
        const email = req.query.email;
        console.log("Requested Email:", email);

        if (!email) {
            return res.status(400).json({ message: "Email is required" });
        }
        
        const user = await User.findOne({ email },{"password":0});
        // const user = await User.findOne({ email },['name','email','gender','phonenumber','dob']);
        if(user.length==0){
            res.status(401).json("no data found");
        } 

        return res.json({ message: "User details retrieved successfully", user });

    } catch (error) {
        console.error("Error fetching user details:", error);
        return res.status(500).json({ message: "Internal Server Error" });
    }
});
router.post("/adduser", async (req, res) => {
    try { 
        
        const newUser = new User({
            name: "Rohan",
            email: "rohan@gmail.com",
            password: "12345678",
            gender: "male",
            dob: "28-08-2005",
            phonenumber: "9876544410"
        });
        await newUser.save();

        
        res.status(201).json({ message: "User added successfully!", user: newUser });
    } catch (error) {
        
        res.status(500).json({ message: "Internal Server Error" });
    }
});
    

module.exports = router;
