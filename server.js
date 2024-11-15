const express = require("express");
const bodyParser = require("body-parser");
const { Pool } = require("pg");

const app = express();
const port = 9000;

// PostgreSQL Pool Setup
const pool = new Pool({
    connectionString: "postgresql://postgres:Strawberrymysql.0824@localhost:5432/postgres",
});

// Middleware
app.use(express.static(__dirname));
app.use(bodyParser.urlencoded({ extended: false }));

// Serve the Home Page
app.get("/", (req, res) => {
    res.sendFile(__dirname + "/pages/home.html");
});

// Serve the Login Page
app.get("/login", (req, res) => {
    res.sendFile(__dirname + "/pages/login.html");
});

// Serve the Registration Form
app.get("/signup", (req, res) => {
    res.sendFile(__dirname + "/pages/form.html");
});

// Handle Form Submission for Registration
app.post("/", async (req, res) => {
    const { f_name, mail, phone } = req.body;

    try {
        const query = `INSERT INTO public."Registration Form" ("Name", "Mail Id", "Phone Number") VALUES ($1, $2, $3) RETURNING *`;
        const result = await pool.query(query, [f_name, mail, phone]);
        console.log("Data Inserted:", result.rows);

        // Respond to client
        res.sendFile(__dirname + "/pages/form.html");
    } catch (err) {
        console.error("Error inserting data:", err.stack);
        res.status(500).send("Error saving data.");
    }
});

// Start the Server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
