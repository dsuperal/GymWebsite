Select * from member;
Select * from guests;

Delete from member where membership_id = 1;

--Retrieving payment history
CREATE OR REPLACE FUNCTION get_payment_history(member_id INT)
RETURNS TABLE (
    payment_id INT,
    most_recent_payment DATE,
    membership_status VARCHAR(50)
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        Payment.payment_id,
        Payment.most_recent_payment,
        Payment.membership_status
    FROM
        Payment
    WHERE
        Payment.member_id = get_payment_history.member_id
    ORDER BY
        Payment.most_recent_payment DESC;
END;
$$ LANGUAGE plpgsql;

Select * from payment;

SELECT * FROM get_payment_history(3); -- Replace 1 with the actual member_id

--Advanced function
CREATE OR REPLACE FUNCTION man_o_meter()
RETURNS TABLE (
    location_id INT,
    street VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    zip VARCHAR(10),
    capacity INT,
    male_percentage NUMERIC(5, 2)
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        loc.location_id,
        loc.street,
        loc.city,
        loc.state,
        loc.zip,
        loc.capacity,
        COALESCE((COUNT(CASE WHEN m.gender = 'Male' THEN 1 END) * 100.0 / loc.capacity), 0) AS male_percentage
    FROM 
        Location loc
    LEFT JOIN 
        CheckIn ci ON loc.location_id = ci.location_id
    LEFT JOIN 
        Member m ON ci.user_id = m.membership_id
    GROUP BY 
        loc.location_id
    ORDER BY 
        male_percentage ASC
    LIMIT 1;
END;
$$ LANGUAGE plpgsql;

--Use of above fxn
SELECT * FROM man_o_meter(); --outputs gym w least men

-- function that automatically checks out member after 1 hour and 30 minutes
CREATE OR REPLACE FUNCTION update_checkin_status()
RETURNS TRIGGER AS $$
BEGIN
   -- Check if 1 hour and 30 minutes have passed since checkin_time
   IF (CURRENT_TIMESTAMP - NEW.checkin_time) >= INTERVAL '1 hour 30 minutes' THEN
      -- Update the status to 'checked_out'
      NEW.status := 'checked_out';
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Trigger for above function
CREATE TRIGGER checkin_status_trigger
AFTER INSERT OR UPDATE ON CheckIn
FOR EACH ROW
EXECUTE FUNCTION update_checkin_status();


--Insert statements
INSERT INTO Manager (first_name, last_name, phone_number)
VALUES (?, ?, ?);

INSERT INTO Location (street, city, state, zip, capacity, manager_id)
VALUES (?, ?, ?, ?, ?, ?);

INSERT INTO MembershipPlans (plan_name, monthly_fee, benefits)
VALUES (?, ?, ?);

INSERT INTO Member (first_name, last_name, gender, dob, join_date, payment_status, email, phone_number, street, city, state, zip, password)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);

INSERT INTO Payments (member_id, most_recent_payment, membership_status)
VALUES (?, ?, ?);

INSERT INTO CheckIn (user_id, location_id, checkin_time, status)
VALUES (?, ?, ?, ?);

INSERT INTO Guests (member_id, guest_name, guest_age)
VALUES (?, ?, ?);

