const express = require("express");
const bodyParser = require("body-parser");
const pool = require("./databaseFiles/database");

const app = express();
const port = 9000;

// Middleware
app.use(express.static(__dirname));
app.use(bodyParser.urlencoded({ extended: false }));

// Serve the form
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

// Handle form submission
app.post("/", async (req, res) => {
    const {
        membership_id,
        first_name,
        last_name,
        gender,
        dob,
        join_date,
        payment_status, // This is coming as "paid" or "unpaid"
        email,
        phone_number,
        street,
        city,
        state,
        zip,
    } = req.body;

    // Convert payment status to boolean
    const paymentStatus = payment_status.toLowerCase() === 'paid' ? true : false;

    try {
        const query = `
            INSERT INTO public.member 
            (membership_id, first_name, last_name, gender, dob, join_date, payment_status, email, phone_number, street, city, state, zip)
            VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13)
            RETURNING *;
        `;

        const values = [
            membership_id,
            first_name,
            last_name,
            gender,
            dob,
            join_date,
            paymentStatus, // Now it's true or false
            email,
            phone_number,
            street,
            city,
            state,
            zip,
        ];

        const result = await pool.query(query, values);
        console.log("Data Inserted:", result.rows);

        res.status(200).send("Form submitted successfully!");
    } catch (err) {
        console.error("Error inserting data:", err.stack);
        res.status(500).send("Error saving data.");
    }
});

// Start the server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
