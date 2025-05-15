-- Calculate the total number of bookings made by each user.
SELECT
USERS.user_id,
USERS.first_name,
USERS.last_name,
COUNT(BOOKINGS.user_id) AS booking_count
FROM USERS
LEFT JOIN BOOKINGS ON USERS.user_id = BOOKINGS.user_id
GROUP BY USERS.user_id, USERS.first_name, USERS.last_name;

-- Rank properties based on the total number of bookings they have received.
SELECT *
FROM PROPERTIES
INNER JOIN (
    SELECT property_id, booking_count,
           RANK() OVER (ORDER BY booking_count DESC) AS rank
    FROM (
        SELECT property_id, COUNT(*) AS booking_count
        FROM BOOKINGS
        GROUP BY property_id
    ) AS booking_counts
) AS ranked_bookings
ON PROPERTIES.property_id = ranked_bookings.property_id;


