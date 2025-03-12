const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const mongoose = require("mongoose");

// ** MongoDB Connection **
mongoose.connect("mongodb://127.0.0.1:27017/riteshdb", )
    .then(() => console.log("MongoDB Connected Successfully!"))
    .catch(err => console.error("MongoDB Connection Error:", err));

const app = express();
app.use(cors());
app.use(bodyParser.json());

// ** Schema & Models **

// User Schema
const userSchema = new mongoose.Schema({
    email: String,
    password: String
});
const User = mongoose.model("User", userSchema);

// Video Schema
const videoSchema = new mongoose.Schema({
    id: Number,
    name: String,
    language: String,
    genre: String,
    category: String,
    duration: String,
    thumbnail: String,
    videoUrl: String
});
const Video = mongoose.model("Video", videoSchema);

// Career Schema
const careerSchema = new mongoose.Schema({
    id: Number,
    company: String,
    title: String,
    description: String,
    deadline: String,
    category: String
});
const Career = mongoose.model("Career", careerSchema);

// Dashboard Schema
const dashboardSchema = new mongoose.Schema({
    TotalUsers: Number,
    ActiveUsers: Number,
    SubscribedUsers: Number,
    TotalEarning: Number
});
const Dashboard = mongoose.model("Dashboard", dashboardSchema);

// ** APIs **

// ** GET Users **
app.get("/users", async (req, res) => {
    try {
        const users = await User.find();
        res.status(200).json(users);
    } catch (error) {
        res.status(500).json({ message: "Error fetching users", error });
    }
});

// ** POST Register a User **
app.post("/register", async (req, res) => {
    const { email, password } = req.body;
    
    if (!email || !password) {
        return res.status(400).json({ message: "Email and password are required" });
    }

    const existingUser = await User.findOne({ email });
    if (existingUser) {
        return res.status(400).json({ message: "User already exists" });
    }

    const newUser = new User({ email, password });
    await newUser.save();
    res.status(201).json({ message: "User registered successfully" });
});

// ** POST Login User **
app.post("/login", async (req, res) => {
    const { email, password } = req.body;
    const user = await User.findOne({ email, password });

    if (!user) {
        return res.status(401).json({ message: "Invalid email or password" });
    }

    res.status(200).json({ message: "User verified", status: "success" });
});

// ** GET Dashboard Data **
app.get("/dashboard", async (req, res) => {
    try {
        const dashboardData = await Dashboard.findOne();
        res.status(200).json(dashboardData);
    } catch (error) {
        res.status(500).json({ message: "Error fetching dashboard data", error });
    }
});

// ** GET Videos **
app.get("/video", async (req, res) => {
    try {
        const videos = await Video.find();
        res.status(200).json(videos);
    } catch (error) {
        res.status(500).json({ message: "Error fetching videos", error });
    }
});

// ** GET Careers **
app.get("/careers", async (req, res) => {
    try {
        const careers = await Career.find();
        res.status(200).json(careers);
    } catch (error) {
        res.status(500).json({ message: "Error fetching careers", error });
    }
});

// ** GET Profile Data **
app.get("/profile", (req, res) => {
    const email = req.query.email;
    console.log("Requested Profile Email:", email);
    res.status(200).json({ message: "Profile endpoint hit!" });
});


// ** POST Register a User (Signup) **
app.post("/signup", (req, res) => {
    const { email, password } = req.body;

    if (!email || !password) {
        res.status(400).json({ message: "Email and password are required" });
    } else {
        User.findOne({ email }).then((existingUser) => {
            if (existingUser) {
                res.status(400).json({ message: "User already exists" });
            } else {
                const newUser = new User({ email, password });
                newUser.save().then(() => {
                    res.status(201).json({ message: "Signup successful!" });
                }).catch((error) => {
                    res.status(500).json({ message: "Error saving user", error });
                });
            }
        }).catch((error) => {
            res.status(500).json({ message: "Database error", error });
        });
    }
});





// ** Server Start **
const PORT = 8000;
app.listen(PORT, () => {
    console.log(` Server running on port ${PORT}`);
});
