-- Fetch properties with average rating > 4.0 using a un-correlated subquery.
SELECT *
FROM PROPERTIES
WHERE property_id IN (
    SELECT property_id
    FROM REVIEWS
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
);

-- Fetch users with more than 3 bookings using a correlated subquery.
SELECT *
FROM USERS
WHERE (
    SELECT COUNT(*)
    FROM BOOKINGS
    WHERE USERS.user_id = BOOKINGS.user_id
) > 3;
