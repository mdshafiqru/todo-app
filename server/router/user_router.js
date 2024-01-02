
// internal imports-
// middleware imports
const user = require('../middlewares/user');
// const avatarUpload = require('../middlewares/common/avatar_upload');

// validators middlware inports
const authValidator = require('../middlewares/validators/auth_validator');

//controllers inports

const authController = require('../controllers/auth_controller');
const todoController = require('../controllers/todo_controller');


module.exports = (express) => {
    const router = express.Router();

    // auth
    router.post('/login', authValidator.login, authController.login);
    router.post('/register', authValidator.register, authController.register);
    router.post('/create-todo', todoController.createTodo);
    router.get('/get-todos', todoController.getTodos);
    router.delete('/delete-todo/id=:id', todoController.deleteTodo);
    router.put('/edit-todo', todoController.editTodo);
    
    return router;
}




