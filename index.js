var express = require('express');
var router = express.Router();
const {memberLogin} = require('./databaseFiles/login');
var connection = require('./databaseFiles/database').databaseConnection;
var fs = require("fs");


//get home page 

router.get('/', (req,res) =>{
    res.render('home');
})

router.get('/login', (req,res) =>{
    res.render('login',{ error: null });
})
router.post('/login', memberLogin);


module.exports = router;
