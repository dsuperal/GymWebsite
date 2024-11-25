const express = require("express");
//const{functionname1, functionname2} = require('./database')
var connection = require('./database').databaseConnection; //that is importing the client


function handleSignup(req, res) {
    const {
        first_name,
        last_name,
        gender,
        dob,
        join_date,
        payment_status,
        email,
        phone_number,
        street,
        city,
        state,
        zip,
        password,
    } = req.body;  // Get data from the form submission

    // Basic validation: Check if all required fields are provided
    if (
        !first_name || 
        !last_name || 
        !gender || 
        !dob || 
        !join_date || 
        !payment_status || 
        !email || 
        !phone_number || 
        !street || 
        !city || 
        !state || 
        !zip || 
        !password
    ) {
        return res.status(400).send('All fields are required!');
    }

    // Convert 'payment_status' to a boolean value (true or false)
    const paymentStatus = payment_status === 'paid';

    // SQL query to insert the new member into the database (without the membership_id)
    const query = `
        INSERT INTO Member (
            First_name, Last_name, Gender, DOB, 
            Join_date, Payment_status, Email, Phone_number, 
            Street, City, State, Zip, password
        ) 
        VALUES (
            $1, $2, $3, $4, 
            $5, $6, $7, $8, 
            $9, $10, $11, $12, $13
       )
    `;

    // Data to insert (without membership_id)
    const values = [
        first_name,
        last_name,
        gender,
        dob,
        join_date,
        paymentStatus,
        email,
        phone_number,
        street,
        city,
        state,
        zip,
        password,
    ];

    // Execute the query
    connection.query(query, values)
        .then((result) => {
            const em = req.email;
            // If the insert was successful, send a success response
            admin = false;
            req.session.user = {em,admin};
            return res.redirect("/payhistory");
            //res.status(201).send('Member registered successfully!');
        })
        .catch((err) => {
            // Handle any errors
            console.error('Error inserting member:', err);
            return res.redirect("/signup");
            //res.status(500).send('Error registering member!');
        });
}






module.exports = {handleSignup}; //any functions made here for the html pages go here
