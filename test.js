const express = require("express");
const app = express();
const port = 9000;
const bodyParser = require("body-parser");
const { Pool } = require("pg");

require('dotenv').config();///

app.use(express.static(__dirname));

// Middleware to parse URL-encoded data
app.use(bodyParser.urlencoded({ extended: false }));

// Serve the form HTML
app.get("/", (req, res) => {
    res.sendFile(__dirname + "/pages/form.html");
});

// Database connection pool
const pool = new Pool({
    connectionString: process.env.DATABASE_URL,
});

app.post("/", async (req, res) => {
    const { name, mail, phone } = req.body;

    try {
        // Use a pooled client
        await pool.query('INSERT INTO Form (name, mail, mobile) VALUES ($1, $2, $3)', [name, mail, phone]);
        console.log("Data Saved");
    } catch (err) {
        console.error("Error saving data:", err);
    }

    res.sendFile(__dirname + "/pages/form.html");
});

// Start the server
app.listen(port, () => {
    console.log(`Example app listening on port ${port}!`);
});
