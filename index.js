var express = require('express');
var router = express.Router();
var {memberLogin} = require('./databaseFiles/login');
var {handleSignup} = require('./databaseFiles/signup'); 

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
router.post('/signup', handleSignup);

module.exports = router;
