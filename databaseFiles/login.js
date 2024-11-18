const express = require('express');
const { userExists } = require('./database');
var connection = require('./database').databaseConnection;

function memberLogin(req,res){
    const {email,password} = req.body;//username will be sent in requent :name for now
    if(!email){
        return res.render('login',{error:'username field are requred'});
    }
    console.log(email);

    userExists(email, (err, exists) => {
        console.log('Mark1');
        if(err){
            console.log('Mark2');
            return res.status(500).send('Error checking user existence');
        }
        if(!exists){
            return res.render("login",{error:'User does not exists'});
        }
       
        return res.render("payhistory");
        
    })

}

module.exports = {memberLogin};