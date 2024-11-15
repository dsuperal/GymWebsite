const bodyParser = require("body-parser");
const express = require("express");
const app = express();
const port = 8000;

app.use(express.static(__dirname));

app.get("/form",(req,res) => {
    res.sendFile(__dirname + "/pages/form.html");
});

app.use(bodyParser.urlencoded({extended:false}))
app.get('/submit',function(req,res){
    console.log('Data Saved')

})

app.listen(port, () =>{
    console.log(`Example app listening on port ${port}!`);
});

