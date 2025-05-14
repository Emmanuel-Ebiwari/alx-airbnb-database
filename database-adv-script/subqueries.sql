SELECT *
FROM PROPERTIES
WHERE property_id IN (
    SELECT property_id
    FROM REVIEWS
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
);

SELECT *
FROM USERS
WHERE (
    SELECT COUNT(*)
    FROM BOOKINGS
    WHERE USERS.user_id = BOOKINGS.user_id
) > 3;
