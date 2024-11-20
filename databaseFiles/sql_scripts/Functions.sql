CREATE OR REPLACE FUNCTION delete_member_and_related(member_id INT)
RETURNS VOID AS $$
BEGIN
	DELETE FROM Guests WHERE Guests.member_id = delete_member_and_related.member_id;

    DELETE FROM CheckIn WHERE CheckIn.user_id = delete_member_and_related.member_id;

    DELETE FROM Payments WHERE Payments.member_id = delete_member_and_related.member_id;

    DELETE FROM Member WHERE Member.membership_id = delete_member_and_related.member_id;
END;
$$ LANGUAGE plpgsql;

Select * from member;
select * from checkIn;
Select * from payments;
SELECT delete_member_and_related(1); -- Replace 1 with the actual member_id to delete

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
        Payments.payment_id,
        Payments.most_recent_payment,
        Payments.membership_status
    FROM
        Payments
    WHERE
        Payments.member_id = get_payment_history.member_id
    ORDER BY
        Payments.most_recent_payment DESC;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_payment_history(2); -- Replace 1 with the actual member_id

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


