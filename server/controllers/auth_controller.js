
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const User = require('../models/user');



const login = async (req, res) => {
    let {email} = req.body;
    
    try {
        const user = await User.findOne({email});
    
        if(!user){
            return res.status(400).json({message:"No user found with this email number", success: false});
        }

        let passwordValid = bcrypt.compareSync(password, user.password);

        if(passwordValid){

            let token = jwt.sign({userId: user.id}, process.env.JWT_SECRET, {expiresIn : '365d'});
            user.password = undefined;

            return res.status(200).json({user, token});

        } else {
            return res.status(400).json({message : "Wrong Password", success: false});
        }
        
    } catch (error) {
        return res.status(500).json({message: error.message, success: false});
    }
}


const register = async (req, res) => {
    let {name, email, profilePic} = req.body;

    try {
        let user = await User.findOne({email});

        if(!user){
            user = await User.create({name, email, profilePic });
        } 

        // let token = jwt.sign({userId: user._id}, process.env.JWT_SECRET, {expiresIn : '365d'});
        let token = "";

        user.updatedAt = undefined;
        user.__v = undefined;

        return res.status(200).json({user, token});

        

    } catch (error) {
        
        return res.status(500).json({message: error.message, success: false});
    }
}

const user = async (req, res) => {
    
    try {
        const user = await User.findOne({ _id: req.userId });
       
        if(user){

            user.updatedAt = undefined;
            user.__v = undefined;
            
            return res.status(200).json({user});
        
        }
        else {
            return res.status(401).json({message: "User not found", success: false});
        }

    } catch (error) {
        return res.status(500).json({message: error.message, success: false});
    }
}







module.exports = {
    user,
    login,
    register,
}