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

DROP TABLE IF EXISTS CheckIn CASCADE;
DROP TABLE IF EXISTS Payment CASCADE;
DROP TABLE IF EXISTS Guest CASCADE;
DROP TABLE IF EXISTS Location CASCADE;
DROP TABLE IF EXISTS Member CASCADE;
DROP TABLE IF EXISTS MembershipPlan CASCADE;
DROP TABLE IF EXISTS Manager CASCADE;

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
   manager_id INT REFERENCES Manager(manager_id) ON DELETE SET NULL
);

CREATE TABLE MembershipPlan (
   plan_id SERIAL PRIMARY KEY, 
   plan_name VARCHAR(50) NOT NULL UNIQUE,
   monthly_fee DECIMAL(10, 2) NOT NULL CHECK (monthly_fee >= 0),
   hasGuest BOOLEAN NOT NULL DEFAULT FALSE CHECK (
       (plan_name IN ('Silver', 'Gold') AND hasGuest = TRUE) OR
       (plan_name NOT IN ('Silver', 'Gold') AND hasGuest = FALSE)
   ),  -- Allows only Silver and Gold plans to have guests
   allAmenities BOOLEAN NOT NULL DEFAULT FALSE CHECK (
       (plan_name = 'Gold' AND allAmenities = TRUE) OR
       (plan_name != 'Gold' AND allAmenities = FALSE)
   ),  -- Allows only Gold plan to have all amenities
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Member (
   Membership_ID SERIAL PRIMARY KEY, 
   First_name VARCHAR(50) NOT NULL,
   Last_name VARCHAR(50) NOT NULL,
   Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Non-binary')) NOT NULL,
   DOB DATE NOT NULL,
   Join_date DATE NOT NULL DEFAULT CURRENT_DATE, -- Defaults to current date if not specified
   Payment_status BOOLEAN NOT NULL DEFAULT TRUE, -- Default to TRUE if not specified
   Email VARCHAR(100) UNIQUE NOT NULL,
   Phone_number VARCHAR(15),
   Street VARCHAR(100),
   City VARCHAR(50),
   State VARCHAR(50),
   Zip VARCHAR(5),
   password VARCHAR(255) NOT NULL,
   CONSTRAINT age_check CHECK (DOB <= CURRENT_DATE - INTERVAL '18 years')
);

CREATE TABLE Payment (
   Payment_ID SERIAL PRIMARY KEY, 
   Member_ID INT REFERENCES Member(Membership_ID) ON DELETE CASCADE,
   Most_recent_payment DATE NOT NULL,
   Membership_status VARCHAR(50) NOT NULL CHECK (Membership_status IN ('Active', 'Inactive', 'Suspended')),
   CONSTRAINT fk_member FOREIGN KEY (Member_ID) REFERENCES Member(Membership_ID) ON DELETE CASCADE
);

CREATE TABLE CheckIn (
   checkin_id SERIAL PRIMARY KEY,
   user_id INT NOT NULL REFERENCES Member(Membership_ID) ON DELETE CASCADE, 
   location_id INT NOT NULL REFERENCES Location(location_id) ON DELETE SET NULL, 
   checkin_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
   status VARCHAR(20) DEFAULT 'checked_in' CHECK (status IN ('checked_in', 'checked_out'))
);

CREATE TABLE Guest (
   guest_id SERIAL PRIMARY KEY,
   member_id INT NOT NULL, 
   guest_name VARCHAR(100) NOT NULL,
   guest_age INT NOT NULL CHECK (guest_age >= 18) --all guests must be at least 18, 
   FOREIGN KEY (member_id) REFERENCES Member(Membership_ID) ON DELETE CASCADE 
);