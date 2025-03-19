const mongoose = require("mongoose");
require("dotenv").config();

const DATABASE_URL = process.env.DATABASE_URL || "your_mongodb_connection_string";

const connectDB = async () => {
    try {
        if (mongoose.connection.readyState === 1) {
            console.log(" Already connected to MongoDB.");
            return;
        }

        await mongoose.connect(DATABASE_URL, {
            useNewUrlParser: true,
            useUnifiedTopology: true,
        });

        console.log(" MongoDB Connected Successfully!");
    } catch (error) {
        console.error(" MongoDB Connection Error:", error.message);
        process.exit(1);
    }
};

const disconnectDB = async () => {
    try {
        if (mongoose.connection.readyState !== 0) {
            await mongoose.disconnect();
            console.log(" MongoDB Disconnected Successfully.");
        }
    } catch (error) {
        console.error(" Error disconnecting MongoDB:", error.message);
    }
};

mongoose.connection.on("connected", () => {
    console.log("MongoDB Connection Established.");
});

mongoose.connection.on("error", (err) => {
    console.error(" MongoDB Connection Error:", err);
});

mongoose.connection.on("disconnected", () => {
    console.log(" MongoDB Disconnected.");
});

module.exports = { connectDB, disconnectDB };
