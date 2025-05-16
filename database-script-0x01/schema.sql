-- Create USERS table
CREATE TABLE USERS (
    user_id CHAR(36) PRIMARY KEY,          -- Primary key for Users
    first_name VARCHAR(255) NOT NULL,  -- First name, cannot be null
    last_name VARCHAR(255) NOT NULL,   -- Last name, cannot be null
    email VARCHAR(255) UNIQUE NOT NULL, -- Email, must be unique and not null
    password_hash VARCHAR(255) NOT NULL, -- Password hash, cannot be null
    phone_number VARCHAR(255),         -- Phone number, can be null
    role ENUM('guest', 'host', 'admin') NOT NULL, -- Role, must be one of these values
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Automatically set timestamp when created
);

-- Create PROPERTIES table
CREATE TABLE PROPERTIES (
    property_id CHAR(36) PRIMARY KEY,      -- Primary key for Properties
    host_id CHAR(36) NOT NULL,             -- Foreign key to USERS (host)
    name VARCHAR(255) NOT NULL,        -- Property name, cannot be null
    description TEXT NOT NULL,         -- Description, cannot be null
    location VARCHAR(255) NOT NULL,    -- Location, cannot be null
    pricepernight DECIMAL(10, 2) NOT NULL, -- Price per night, cannot be null
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Automatically set timestamp when created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Automatically updates on record change
    FOREIGN KEY (host_id) REFERENCES USERS(user_id) -- Foreign key constraint to USERS table
);

-- Create BOOKINGS table
CREATE TABLE BOOKINGS (
    booking_id CHAR(36) PRIMARY KEY,         -- Primary key for Bookings
    property_id CHAR(36) NOT NULL,            -- Foreign key to PROPERTIES
    user_id CHAR(36) NOT NULL,                -- Foreign key to USERS
    start_date DATE NOT NULL,             -- Start date of the booking, cannot be null
    end_date DATE NOT NULL,               -- End date of the booking, cannot be null
    total_price DECIMAL(10, 2) NOT NULL,  -- Total price for the booking, cannot be null
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL, -- Status of the booking
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Automatically set timestamp when created
    FOREIGN KEY (property_id) REFERENCES PROPERTIES(property_id), -- Foreign key constraint to PROPERTIES table
    FOREIGN KEY (user_id) REFERENCES USERS(user_id) -- Foreign key constraint to USERS table
);

-- Create PAYMENTS table
CREATE TABLE PAYMENTS (
    payment_id CHAR(36) PRIMARY KEY,         -- Primary key for Payments
    booking_id CHAR(36) NOT NULL,            -- Foreign key to BOOKINGS table
    amount DECIMAL(10, 2) NOT NULL,       -- Amount of the payment, cannot be null
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Automatically set timestamp when payment is made
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL, -- Payment method, must be one of these
    FOREIGN KEY (booking_id) REFERENCES BOOKINGS(booking_id) -- Foreign key constraint to BOOKINGS table
);

-- Create REVIEWS table
CREATE TABLE REVIEWS (
    review_id CHAR(36) PRIMARY KEY,         -- Primary key for Reviews
    property_id CHAR(36) NOT NULL,           -- Foreign key to PROPERTIES
    user_id CHAR(36) NOT NULL,               -- Foreign key to USERS
    rating INTEGER CHECK (rating >= 1 AND rating <= 5) NOT NULL, -- Rating, between 1 and 5
    comment TEXT NOT NULL,               -- Review comment, cannot be null
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Automatically set timestamp when created
    FOREIGN KEY (property_id) REFERENCES PROPERTIES(property_id), -- Foreign key constraint to PROPERTIES table
    FOREIGN KEY (user_id) REFERENCES USERS(user_id) -- Foreign key constraint to USERS table
);

-- Create MESSAGES table
CREATE TABLE MESSAGES (
    message_id CHAR(36) PRIMARY KEY,         -- Primary key for Messages
    sender_id CHAR(36) NOT NULL,             -- Foreign key to USERS (sender)
    recipient_id CHAR(36) NOT NULL,          -- Foreign key to USERS (recipient)
    message_body TEXT NOT NULL,          -- Body of the message, cannot be null
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Automatically set timestamp when message is sent
    FOREIGN KEY (sender_id) REFERENCES USERS(user_id), -- Foreign key constraint to USERS table
    FOREIGN KEY (recipient_id) REFERENCES USERS(user_id) -- Foreign key constraint to USERS table
);

-- Indexes for optimal performance
-- Indexes on foreign keys for faster lookups and joins
CREATE INDEX idx_property_id ON BOOKINGS(property_id);
CREATE INDEX idx_user_id ON BOOKINGS(user_id);
CREATE INDEX idx_host_id ON PROPERTIES(host_id);
CREATE INDEX idx_booking_id ON PAYMENTS(booking_id);
CREATE INDEX idx_property_id_reviews ON REVIEWS(property_id);
CREATE INDEX idx_user_id_reviews ON REVIEWS(user_id);
CREATE INDEX idx_sender_id_messages ON MESSAGES(sender_id);
CREATE INDEX idx_recipient_id_messages ON MESSAGES(recipient_id);
