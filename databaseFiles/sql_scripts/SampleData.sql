-- Clear the contents of each table first
TRUNCATE TABLE Guest CASCADE;
TRUNCATE TABLE CheckIn CASCADE;
TRUNCATE TABLE Payment CASCADE;
TRUNCATE TABLE Location CASCADE;
TRUNCATE TABLE Member CASCADE;
TRUNCATE TABLE MembershipPlan CASCADE;
TRUNCATE TABLE Manager CASCADE;

INSERT INTO Manager (first_name, last_name, phone_number)
VALUES 
    ('Sarah', 'Brown', '555-1235'),
    ('Tom', 'White', '555-2346'),
    ('Emily', 'Clark', '555-3457');

INSERT INTO Location (street, city, state, zip, capacity, manager_id)
VALUES 
    ('101 Fitness Way', 'San Antonio', 'TX', '78201', 100, 1),  -- Manager ID 1
    ('202 Wellness Ave', 'Austin', 'TX', '78701', 150, 2),     -- Manager ID 2
    ('303 Strength Blvd', 'Houston', 'TX', '77001', 200, 3);    -- Manager ID 3

INSERT INTO MembershipPlan (plan_name, monthly_fee, hasGuest, allAmenities)
VALUES 
    ('Gold', 25.00, TRUE, TRUE),
    ('Silver', 20.00, TRUE, FALSE),
    ('Bronze', 15.00, FALSE, FALSE);

INSERT INTO Member (First_name, Last_name, Gender, DOB, Join_date, Payment_status, Email, Phone_number, Street, City, State, Zip, password)
VALUES 
    ('John', 'Doe', 'Male', '1990-02-15', '2023-01-10', TRUE, 'john.doe@example.com', '555-1234', '123 Elm St', 'San Antonio', 'TX', '78201', 'password123'),
    ('Jane', 'Smith', 'Female', '1988-11-20', '2022-12-05', TRUE, 'jane.smith@example.com', '555-5678', '456 Oak St', 'Austin', 'TX', '78701', 'securepass456'),
    ('Alex', 'Johnson', 'Non-binary', '1995-07-12', '2023-03-15', FALSE, 'alex.j@example.com', '555-9101', '789 Pine St', 'Houston', 'TX', '77001', 'nonbinarypass789');

INSERT INTO Payment (Member_ID, Most_recent_payment, Membership_status)
VALUES 
    (2, '2023-10-15', 'Active'),
    (3, '2023-09-30', 'Inactive');

INSERT INTO CheckIn (user_id, location_id, checkin_time, status)
VALUES 
    (1, 1, '2023-11-12 08:00:00', 'checked_in'),
    (2, 2, '2023-11-12 09:00:00', 'checked_in'),
    (3, 3, '2023-11-12 10:00:00', 'checked_in');

INSERT INTO Guest (member_id, guest_name, guest_age)
VALUES 
    (1, 'Alice Doe', 25),
    (2, 'Bob Smith', 30),
    (3, 'Charlie Johnson', 28);

SELECT * FROM Member;
