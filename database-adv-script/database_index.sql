-- Improve JOIN performance between BOOKINGS and USERS by indexing BOOKINGS.user_id
CREATE INDEX idx_bookings_user_id ON BOOKINGS(user_id);

/*
EXPLAIN ANALYZE
SELECT USERS.user_id, USERS.first_name, USERS.last_name, BOOKINGS.booking_id
FROM BOOKINGS
JOIN USERS ON BOOKINGS.user_id = USERS.user_id;
*/

-- Optimize filtering and subqueries on USERS.first_name
CREATE INDEX idx_users_first_name ON USERS(first_name);

/*
EXPLAIN ANALYZE
SELECT *
FROM PROPERTIES
WHERE host_id = (
  SELECT user_id FROM USERS WHERE first_name = 'Jane' LIMIT 1
);

EXPLAIN ANALYZE
SELECT U.first_name, P.name, B.start_date
FROM BOOKINGS B
JOIN USERS U ON B.user_id = U.user_id
JOIN PROPERTIES P ON B.property_id = P.property_id
WHERE U.first_name = 'John';
*/

-- Speed up filtering and joins involving PROPERTIES.host_id
CREATE INDEX idx_properties_host_id ON PROPERTIES(host_id);

/*
EXPLAIN ANALYZE
SELECT *
FROM PROPERTIES
WHERE host_id = (
  SELECT user_id FROM USERS WHERE first_name = 'Jane' LIMIT 1
);

EXPLAIN ANALYZE
SELECT P.name, B.start_date, B.end_date
FROM BOOKINGS B
JOIN PROPERTIES P ON B.property_id = P.property_id;
*/
