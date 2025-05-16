-- Initial query: Retrieves all bookings with user, property, and payment details
EXPLAIN SELECT *
FROM BOOKINGS, USERS, PROPERTIES, PAYMENTS
WHERE BOOKINGS.user_id = USERS.user_id
AND BOOKINGS.property_id = PROPERTIES.property_id
AND BOOKINGS.booking_id = PAYMENTS.booking_id;


-- Optimized query: Retrieves all bookings with user, property, and payment details
EXPLAIN SELECT 
  B.booking_id,
  B.start_date,
  B.end_date,
  B.total_price,
  B.status AS booking_status,
  U.first_name,
  U.last_name,
  U.email,
  P.name AS property_name,
  P.location,
  P.pricepernight,
  PY.amount,
  PY.payment_method,
  PY.payment_date
FROM BOOKINGS B
JOIN USERS U ON B.user_id = U.user_id
JOIN PROPERTIES P ON B.property_id = P.property_id
LEFT JOIN PAYMENTS PY ON B.booking_id = PY.booking_id;
