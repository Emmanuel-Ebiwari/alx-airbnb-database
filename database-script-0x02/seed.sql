-- Sample data for USERS table
INSERT INTO USERS (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
  (UUID(), 'John', 'Doe', 'john.doe@example.com', 'hashedpassword1', '1234567890', 'guest', CURRENT_TIMESTAMP),
  (UUID(), 'Jane', 'Smith', 'jane.smith@example.com', 'hashedpassword2', '0987654321', 'host', CURRENT_TIMESTAMP),
  (UUID(), 'Alice', 'Johnson', 'alice.johnson@example.com', 'hashedpassword3', '1122334455', 'admin', CURRENT_TIMESTAMP);

-- Sample data for PROPERTIES table
INSERT INTO PROPERTIES (property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
VALUES
  (UUID(), (SELECT user_id FROM USERS WHERE first_name = 'Jane' LIMIT 1), 'Cozy Cottage', 'A charming cottage in the countryside', 'Countryside, USA', 100.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (UUID(), (SELECT user_id FROM USERS WHERE first_name = 'Jane' LIMIT 1), 'Downtown Apartment', 'Modern apartment in the city center', 'New York, USA', 150.00, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Sample data for BOOKINGS table
INSERT INTO BOOKINGS (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
  (UUID(), (SELECT property_id FROM PROPERTIES WHERE name = 'Cozy Cottage' LIMIT 1), (SELECT user_id FROM USERS WHERE first_name = 'John' LIMIT 1), '2025-06-01', '2025-06-10', 1000.00, 'confirmed', CURRENT_TIMESTAMP),
  (UUID(), (SELECT property_id FROM PROPERTIES WHERE name = 'Downtown Apartment' LIMIT 1), (SELECT user_id FROM USERS WHERE first_name = 'Alice' LIMIT 1), '2025-07-01', '2025-07-05', 750.00, 'pending', CURRENT_TIMESTAMP);

-- Sample data for PAYMENTS table
INSERT INTO PAYMENTS (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
  (UUID(), (SELECT booking_id FROM BOOKINGS WHERE status = 'confirmed' LIMIT 1), 1000.00, CURRENT_TIMESTAMP, 'credit_card'),
  (UUID(), (SELECT booking_id FROM BOOKINGS WHERE status = 'pending' LIMIT 1), 750.00, CURRENT_TIMESTAMP, 'paypal');

-- Sample data for REVIEWS table
INSERT INTO REVIEWS (review_id, property_id, user_id, rating, comment, created_at)
VALUES
  (UUID(), (SELECT property_id FROM PROPERTIES WHERE name = 'Cozy Cottage' LIMIT 1), (SELECT user_id FROM USERS WHERE first_name = 'Alice' LIMIT 1), 5, 'Amazing stay! Highly recommend.', CURRENT_TIMESTAMP),
  (UUID(), (SELECT property_id FROM PROPERTIES WHERE name = 'Downtown Apartment' LIMIT 1), (SELECT user_id FROM USERS WHERE first_name = 'John' LIMIT 1), 4, 'Great apartment, but a bit noisy at night.', CURRENT_TIMESTAMP);

-- Sample data for MESSAGES table
INSERT INTO MESSAGES (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
  (UUID(), (SELECT user_id FROM USERS WHERE first_name = 'John' LIMIT 1), (SELECT user_id FROM USERS WHERE first_name = 'Jane' LIMIT 1), 'Hi Jane, I’m interested in booking your Cozy Cottage.', CURRENT_TIMESTAMP),
  (UUID(), (SELECT user_id FROM USERS WHERE first_name = 'Alice' LIMIT 1), (SELECT user_id FROM USERS WHERE first_name = 'Jane' LIMIT 1), 'I have some questions about the Downtown Apartment.', CURRENT_TIMESTAMP);
