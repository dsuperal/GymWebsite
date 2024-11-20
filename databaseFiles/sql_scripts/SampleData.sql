INSERT INTO Member (Membership_ID, First_name, Last_name, Gender, DOB, Join_date, Payment_status, Email, Phone_number, Street, City, State, Zip)
VALUES 
    (1, 'John', 'Doe', 'Male', '1990-02-15', '2023-01-10', TRUE, 'john.doe@example.com', '555-1234', '123 Elm St', 'San Antonio', 'TX', '78201'),
    (2, 'Jane', 'Smith', 'Female', '1988-11-20', '2022-12-05', TRUE, 'jane.smith@example.com', '555-5678', '456 Oak St', 'Austin', 'TX', '78701'),
    (3, 'Alex', 'Johnson', 'Non-binary', '1995-07-12', '2023-03-15', FALSE, 'alex.j@example.com', '555-9101', '789 Pine St', 'Houston', 'TX', '77001');

INSERT INTO MembershipPlans (plan_id, plan_name, monthly_fee, benefits)
VALUES 
    (1, 'Gold', 25.00, 'Access to all facilities, 5 personal training sessions, premium locker room access'),
    (2, 'Silver', 20.00, 'Access to all facilities, 2 personal training sessions'),
    (3, 'Bronze', 15.00, 'Access to all facilities');

INSERT INTO Manager (manager_id, first_name, last_name, phone_number)
VALUES 
    (4, 'Sarah', 'Brown', '555-1235'),
    (2, 'Tom', 'White', '555-2346'),
    (3, 'Emily', 'Clark', '555-3457');

INSERT INTO Location (location_id, street, city, state, zip, capacity, manager_id)
VALUES 
    (1, '101 Fitness Way', 'San Antonio', 'TX', '78201', 100, 1),
    (2, '202 Wellness Ave', 'Austin', 'TX', '78701', 150, 2),
    (3, '303 Strength Blvd', 'Houston', 'TX', '77001', 200, 3);

INSERT INTO Payments (Payment_ID, Member_ID, Most_recent_payment, Membership_status)
VALUES 
    (1, 1, '2023-11-01', 'Active'),
    (2, 2, '2023-10-15', 'Active'),
    (3, 3, '2023-09-30', 'Inactive');

INSERT INTO CheckIn (checkin_id, user_id, location_id, checkin_time, status)
VALUES 
    (1, 1, 1, '2023-11-12 08:00:00', 'checked_in'),
    (2, 2, 2, '2023-11-12 09:00:00', 'checked_in'),
    (3, 3, 3, '2023-11-12 10:00:00', 'checked_in');

INSERT INTO Guests (guest_id, member_id, guest_name, guest_age)
VALUES 
    (1, 1, 'Alice Doe', 25),
    (2, 2, 'Bob Smith', 30),
    (3, 3, 'Charlie Johnson', 28);
