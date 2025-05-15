-- This script demonstrates various types of SQL joins using the provided database schema.

-- INNER JOIN: Retrieves records that have matching values in both tables.
SELECT *
FROM BOOKINGS
INNER JOIN USERS ON BOOKINGS.user_id = USERS.user_id;

-- LEFT JOIN: Retrieves all records from the left table (BOOKINGS) and the matched records from the right table (USERS).
SELECT *
FROM PROPERTIES
LEFT JOIN REVIEWS ON PROPERTIES.property_id = REVIEWS.property_id
ORDER BY PROPERTIES.property_id;

-- FULL OUTER JOIN: Retrieves all records when there is a match in either left (USERS) or right (BOOKINGS) table records.
SELECT *
FROM USERS
FULL OUTER JOIN BOOKINGS ON USERS.user_id = BOOKINGS.user_id;