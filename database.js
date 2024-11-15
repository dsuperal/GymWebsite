const { Client } = require('pg');

const connectionString = 'postgresql://postgres:Strawberrymysql.0824@localhost:5432/postgres';

const client = new Client({
    connectionString: connectionString,
});

client.connect()  // Connect once

// Query 1: SELECT
client.query('SELECT * FROM public."Registration Form"', (err, res) => {
    if (err) {
        console.error('Error in SELECT query', err.stack);
    } else {
        console.log('SELECT query result:', res.rows);
    }

    // Query 2: INSERT
    const qr = "INSERT INTO public.\"Registration Form\" (\"Name\", \"Mail Id\", \"Phone Number\") VALUES ('Daisy', 123, 87246)";
    client.query(qr, (err, res) => {
        if (err) {
            console.error('Error in INSERT query', err.stack);
        } else {
            console.log('INSERT query result:', res.rows);
        }

        // End the connection after all queries are done
        client.end();
    });
});
