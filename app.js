var express = require("express");
var app = express();
var port = 8000;
const indexRouter = require('./index');
const bodyParser = require("body-parser");



app.use(express.static('images'));

app.use(bodyParser.json());

app.use(bodyParser.urlencoded({extended : true}));

app.set("view engine", "ejs");
app.set('views', __dirname + '/views');


app.use(express.static('databseFiles'));
app.use(express.static('images'));


app.use('/', indexRouter);

app.listen(port, () =>{
    console.log(`Example app listening on port ${port}!`);
});



