const express = require('express');
const { userExists ,passwordCheck} = require('./database');
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
       
    })

    passwordCheck(email,password,(err,validPassword) => {
        console.log('Mark 3');
        console.log(validPassword);

        if(err){
            console.log('Mark 4');
            return res.status(500).send('Error checking user existence');    
        }
         console.log('Mark 5');

        if(validPassword){
            
            console.log(email,'is logged in')
            admin = false;
            req.session.user = {email,admin};
            return res.redirect("/payhistory");
        }
        console.log('Mark 6');
    })

   

}

module.exports = {memberLogin};