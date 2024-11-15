const { Pool,Client } = require('pg');

const connectionString = 'postgresql://postgres:Esteban10@localhost:5432/test';

const client = new Client({
    connectionString: connectionString,
});

//client.connect();  // Connect only once

/*
// Query 1
client.query('SELECT * FROM Form', (err, res) => {
    console.log(err, res);
    
    // Additional Query
    const qr = "INSERT INTO Form VALUES('DaisyN', '123@gmail.com', 87246)";
    client.query(qr, (err, res) => {
        console.log(err, res);
        
        // End the connection after all queries are done
        client.end();
 //   });
});  */


//can only use client once