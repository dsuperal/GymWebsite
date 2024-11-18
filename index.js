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

router.get('/signup', (req,res) =>{
    res.render('signup',{ error: null });
})
module.exports = router;
