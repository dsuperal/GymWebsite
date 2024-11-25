var { Client } = require("pg");
require('dotenv').config();

var client = new Client({
    connectionString: process.env.DATABASE_URL,
});


client.connect((err => {
    if(err) throw err;
    console.log('Postgres Connected Succesfully');
}));


function userExists(email, callback){
    let sql = "SELECT * FROM member WHERE email = $1";
    client.query(sql, [email],(err,results) => {
        if(err){
            return callback(err);

        }
        callback(null, results.rows.length>0);
    });
}

function passwordCheck(email,password, callback){
    let sql = "SELECT * FROM member WHERE email = $1 and password = $2";
    client.query(sql, [email,password], (err,results) =>{
        if(err){
            console.log('database.js');
            return callback(err);
        }
        callback(null, results.rows.length>0);
    });
}
function getUserByEmail(email, callback) {
    let sql = "SELECT * FROM member WHERE email = $1";
    client.query(sql, [email], (err, results) => {
        if (err) {
            console.log('Error in getUserByEmail:', err);
            return callback(err); // Return error in the callback
        }

        if (results.rows.length > 0) {
            // Return the user data (all columns) if found
            return callback(null, results.rows[0]);  // Assuming you want the first result
        } else {
            return callback(null, null); // If no user is found
        }
    });
}




//functions that need direct access to database go here for example
//userExists --> check if that username is already in the database 
//passwordCheck --> makes sure password is valud
//insert user --> insert a new user into the database
//etc...

module.exports = {userExists,passwordCheck,getUserByEmail,
    databaseConnection : client
};
