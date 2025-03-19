const mongoose = require ("mongoose");
const adminSchema = new mongoose.Schema({
    email:{type:String},
    password:{type :String},  
})

const Admin = mongoose.model("admin",adminSchema);
module.exports = Admin ;
