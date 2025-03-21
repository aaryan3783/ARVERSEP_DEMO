const express = require("express");
const router = express.Router();
const Admin = require("../models/admins");

router.post("/login", async (req, res) => {
    const email = req.body.email;    

    const admin = await Admin.find({email}); 
    if (admin.length == 0) {
        return res.status(404).json({ message: "No users found in the database" });
    }
    res.status(200).json({"message":"Success"}); 
});

module.exports = router;
