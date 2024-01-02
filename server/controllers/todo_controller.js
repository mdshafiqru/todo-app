const { isMongoID } = require("../common/app_helper");
const Todo = require("../models/todo");

const createTodo = async (req, res) => {
    let {title, description, deadline} = req.body;
    
    try {

        console.log(req.body);
        await Todo.create({title, description, deadline});
    
        return res.status(200).json({message: "Todo Created"});
        
    } catch (error) {
        return res.status(500).json({message: error.message});
    }
}

const editTodo = async (req, res) => {
    
    try {
        let {id, title, description} = req.body;

        if(!isMongoID(id)){
            return res.status(400).json({message: "Invalid todo ID"});
        }

        const todo =  await Todo.findOne({_id: id});

        if(!todo){
            return res.status(400).json({message: "Todo not found"});
        }

        todo.title = title,
        todo.description = description,

        await todo.save();

        return res.status(200).json({message: "Todo Updated"});
        
    } catch (error) {
        return res.status(500).json({message: error.message});
    }
}

const getTodos = async (req, res) => {
    
    try {
        const todos =  await Todo.find();
    
        return res.status(200).json(todos);
        
    } catch (error) {
        return res.status(500).json({message: error.message});
    }
}
const deleteTodo = async (req, res) => {
    
    try {
        const id = req.params.id;

        if(!isMongoID(id)){
            return res.status(400).json({message: "Invalid todo ID"});
        }

        const todo =  await Todo.findOne({_id: id});

        if(todo){
            await Todo.deleteOne({_id: id});
            return res.status(200).json({message: "Todo Deleted Successfully"});
        } else {
            return res.status(400).json({message: "Todo Not Found"});
        }
    
    } catch (error) {
        return res.status(500).json({message: error.message});
    }
}


module.exports = {
    createTodo,
    getTodos,
    deleteTodo,
    editTodo,
}