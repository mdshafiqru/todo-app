const mongoose = require('mongoose');

const userSchema = mongoose.Schema({
    name: {
        type: String, 
        required: [true, 'name is required'],
        trim: true
    },

    email: {
        type: String, 
        trim: true,
        lowercase: true,
    },

    profilePic: {
        type: String, 
    },
}, { timestamps: true });

const User = new mongoose.model("User", userSchema);

module.exports = User;