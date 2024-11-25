var express = require("express");
var app = express();
const path = require('path');
const session = require('express-session');

var port = 8000;
const indexRouter = require('./index');
const bodyParser = require("body-parser");
require('dotenv').config();






app.use(express.static('images'));

app.use(bodyParser.json());

app.use(bodyParser.urlencoded({extended : true}));

//session middleware
app.use(session({
    secret: process.env.SESSION_SECRET,
    resave:false,
    saveUninitialized: true,
    cookie:{secure : false, httpOnly:true,}
}));


app.use(express.static(path.join(__dirname, 'public')));

app.set("view engine", "ejs");
app.set('views', __dirname + '/views');


app.use(express.static('databseFiles'));
app.use(express.static('/images'));


app.use('/', indexRouter);

app.listen(port, () =>{
    console.log(`Example app listening on port ${port}!`);
});



