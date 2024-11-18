-- Database: FitGals

-- DROP DATABASE IF EXISTS "FitGals";

CREATE DATABASE "FitGals"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

CREATE TABLE Member (
   Membership_ID SERIAL PRIMARY KEY,
   First_name VARCHAR(50),
   Last_name VARCHAR(50),
   Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Non-binary')),
   DOB DATE,
   Join_date DATE,
   Payment_status BOOLEAN,
   Email VARCHAR(100),
   Phone_number VARCHAR(15),
   Street VARCHAR(100),
   City VARCHAR(50),
   State VARCHAR(50),
   Zip VARCHAR(5)
);
CREATE TABLE Manager (
   manager_id SERIAL PRIMARY KEY,
   first_name VARCHAR(50) NOT NULL,
   last_name VARCHAR(50) NOT NULL,
   phone_number VARCHAR(15) NOT NULL UNIQUE
);
CREATE TABLE Location (
   location_id SERIAL PRIMARY KEY,
   street VARCHAR(100) NOT NULL,
   city VARCHAR(50) NOT NULL,
   state VARCHAR(50) NOT NULL,
   zip VARCHAR(10) NOT NULL,
   capacity INT NOT NULL,
   manager_id INT REFERENCES Manager(manager_id) -- FK reference to Manager table
);
CREATE TABLE CheckIn (
   checkin_id SERIAL PRIMARY KEY,
   user_id INT REFERENCES Member(membership_id),
   location_id INT REFERENCES Location(location_id),
   checkin_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   status VARCHAR(20) DEFAULT 'checked_in'
);

CREATE TABLE MembershipPlans (
   plan_id SERIAL PRIMARY KEY,
   plan_name VARCHAR(50) NOT NULL UNIQUE, -- 'Platinum', 'Gold', 'Silver'
   monthly_fee DECIMAL(10, 2) NOT NULL,
   benefits TEXT,
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




-- Create Payments table first
CREATE TABLE Payments (
   Payment_ID SERIAL PRIMARY KEY,,
   Member_ID INT,
   Most_recent_payment DATE,
   Membership_status VARCHAR(50),
   FOREIGN KEY (Member_ID) REFERENCES Member(Membership_ID)
);



CREATE TABLE Guests (
   guest_id SERIAL PRIMARY KEY,,  -- guest_id is now the primary key
   member_id INT REFERENCES Member(Membership_ID),
   guest_name VARCHAR(100) NOT NULL,
   guest_age INT
);

ALTER TABLE Guests
    DROP CONSTRAINT guests_member_id_fkey,
    ADD CONSTRAINT guests_member_id_fkey FOREIGN KEY (member_id) REFERENCES Member(membership_id) ON DELETE CASCADE;

ALTER TABLE CheckIn
    DROP CONSTRAINT IF EXISTS checkin_user_id_fkey,
    ADD CONSTRAINT checkin_user_id_fkey FOREIGN KEY (user_id) REFERENCES Member(membership_id) ON DELETE CASCADE;

ALTER TABLE Payments
    DROP CONSTRAINT IF EXISTS payments_member_id_fkey,
    ADD CONSTRAINT payments_member_id_fkey FOREIGN KEY (member_id) REFERENCES Member(membership_id) ON DELETE CASCADE;


