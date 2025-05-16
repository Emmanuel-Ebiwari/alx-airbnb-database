-- Index to optimize JOIN on BOOKINGS.user_id
CREATE INDEX idx_bookings_user_id ON BOOKINGS(user_id);

-- Index to optimize filtering USERS by first_name
CREATE INDEX idx_users_first_name ON USERS(first_name);

-- Index to optimize JOIN on PROPERTIES.host_id
CREATE INDEX idx_properties_host_id ON PROPERTIES(host_id);