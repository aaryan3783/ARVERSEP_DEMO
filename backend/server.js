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
    const dashboardata = [{"TotalUsers": 21}
    ,{"ActiveUsers": 100}
    ,{"SubscribedUsers": 10}
    ,{"TotalEarning":2494}
      ];
    app.get("/dashboard", (req, res) => {
    res.status(200).json(dashboardata);
});

// Get api for show Video data
const videos = [
    {
        "id": 1,
        "name": "Inception",
        "language": "English",
        "genre": "Sci-Fi",
        "category": "Movie",
        "duration": "2h 28m",
        "thumbnail": "https://akns-images.eonline.com/eol_images/Entire_Site/20191019/rs_634x941-191119145916-634-Little-Women-CE-111919.jpg?fit=around%7C634:941&output-quality=90&crop=634:941;center,top"
        "videoUrl": "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4"
    },
    {   "id": 2,
        "name": "Aspirants",
        "language": "Hindi",
        "genre": "Sci-Fi",
        "category": "webseries",
        "duration": "6h 28m",
        "thumbnail": "https://akns-images.eonline.com/eol_images/Entire_Site/20191019/rs_634x941-191119145917-634-Jumanji-Next-Level-CE-111919.jpg?fit=around%7C634:941&output-quality=90&crop=634:941;center,top",
        "videoUrl": "https://youtu.be/0Kl1ucZuSZ8?si=oQTkEovhNYueqX8C"
    },
    
   {        "id": 3,
            "name": "PANCHYAT",
            "language": "Hindi",
            "genre": "Sci-Fi",
            "category": "webseries",
            "duration": "6h 28m",
            "thumbnail": "https://akns-images.eonline.com/eol_images/Entire_Site/20191019/rs_634x939-191119145918-634-Last-Christmas-CE-111919.jpg?fit=around%7C634:940&output-quality=90&crop=634:940;center,top",
            "videoUrl": "https://youtu.be/T0vBY9SNAWU?si=qWrfEQDzS645wgDG"
    },
    {   "id": 4,
        "name": "The Family",
        "language": "Hindi",
        "genre": "Sci-Fi",
        "category": "webseries",
        "duration": "10h 28m",
        "thumbnail": "https://akns-images.eonline.com/eol_images/Entire_Site/20191019/rs_634x939-191119145914-634-Ford-v-Ferrari-CE-111919.jpg?fit=around%7C634:940&output-quality=90&crop=634:940;center,top",
        "videoUrl": "https://youtu.be/T0vBY9SNAWU?si=qWrfEQDzS645wgDG"
},
]

app.get("/video", (req, res) => {
    res.status(200).json(videos);
});


const careers = [
    {
        "id": 1,
        "company": "CSL",
        "title": "DEVELOPER",
        "description": "WE ARE HIRING DEV",
        "deadline": "28.11.2024 - 27.02.2025",
        "category": "DEVSD"
    },
    {
        "id": 2,
        "company": "CSL",
        "title": "TESTER",
        "description": "QA",
        "deadline": "02.12.2024 - 21.03.2025",
        "category": "QA"
    },
    {
        "id": 3,
        "company": "ARVERSE",
        "title": "CONTENT CREATOR",
        "description": "We are seeking a talented content creator who is passionate about storytelling...",
        "deadline": "N/A",
        "category": "CREATOR"
    }
];

app.get("/careerss", (req, res) => {
    res.status(200).json(careers);
});


// Start the Server
const PORT = 8000;
app.listen(PORT, () => {
    console.log(` Server running on port ${PORT}`);
});
