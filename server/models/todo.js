const mongoose = require('mongoose');

const todoSchema = mongoose.Schema({
    title: {
        type: String, 
        required: [true, 'title is required'],
        trim: true
    },

    description: {
        type: String, 
        trim: true,
    },

    deadline: {
        type: String, 
    },

    
}, { timestamps: true });

const Todo = new mongoose.model("Todo", todoSchema);

module.exports = Todo;