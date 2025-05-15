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
SELECT 
  P.property_id,
  P.name,
  ranked.booking_count,
  ranked.booking_rank,
  ranked.booking_row_number
FROM PROPERTIES P
JOIN (
  SELECT 
    property_id,
    COUNT(*) AS booking_count,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS booking_rank,
    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS booking_row_number
  FROM BOOKINGS
  GROUP BY property_id
) AS ranked ON P.property_id = ranked.property_id;

