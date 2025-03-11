const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");

const app = express();
app.use(cors());
app.use(bodyParser.json());

// Temporary in-memory storage
const users = [{ email: "admin@example.com", password: "Admin@123" },{ email: "aaryan3783@gmail.com", password: "12345678" }];

// **GET API** - Fetch all users
app.get("/users", (req, res) => {
    res.status(200).json(users);
});

// **POST API** - Register a new user
app.post("/register", (req, res) => {
    const { email, password } = req.body;

    if (!email || !password) {
        return res.status(400).json({ message: "Email and password are required" });
    }

    const existingUser = users.find(user => user.email === email);
    if (existingUser) {
        return res.status(400).json({ message: "User already exists" });
    }

    users.push({ email, password });
    res.status(201).json({ message: "User registered successfully" });
});

// **POST API** - User login
app.post("/login", (req, res) => {
    const { email, password } = req.body;

    const user = users.find(user => user.email === email && user.password === password);
    if (!user) {
        return res.status(401).json({ message: "Invalid email or password" });
    }

    res.status(200).json({ message: "User verified", status: "success" });
});

// **GET API** - for show data in dashboard
    const dashboarddata = [
        { "id1" : 1, "name" :"Ritesh" , "email " :"ritesh@example.com", password: "Admin@123" , },
        { "id2" : 2, "name" :"rahul" , "email " :"rahul@gmail.com", password: "Admin@123575" , },
        { "id3" : 3, "name" :"Raju" , "email " :"raju@gmail.com", password: "Admin@1234uf4f" , },
        { "id4" : 4, "name" :"Ram" , "email " :"ram@gmail.com", password: "Admin@1234f4fdgg" , }

        ];
    app.get("/dashboard", (req, res) => {
    res.status(200).json(dashboarddata);
});



// Start the Server
const PORT = 5000;
app.listen(PORT, () => {
    console.log(` Server running on port ${PORT}`);
});
