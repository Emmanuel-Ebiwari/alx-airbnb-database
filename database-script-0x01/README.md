# Airbnb Database Schema

This project contains the database schema for an Airbnb-style application. It includes tables for Users, Properties, Bookings, Payments, Reviews, and Messages.

## Setup

To set up the database schema, you can run the provided SQL `CREATE TABLE` statements in your database (e.g., MySQL, PostgreSQL). The schema follows third normal form (3NF) and uses foreign keys and indexes to maintain data integrity and improve performance.

## Tables

The database includes the following tables:

- **USERS**: Information about the users (ID, name, email, etc.).
- **PROPERTIES**: Information about properties listed by users (name, description, price, etc.).
- **BOOKINGS**: Information about property bookings, related to users and properties.
- **PAYMENTS**: Payment details related to bookings.
- **REVIEWS**: Reviews left by users for properties.
- **MESSAGES**: Messages exchanged between users.

## Constraints

- **Primary Keys**: Each table has a primary key to uniquely identify each record.
- **Foreign Keys**: Tables are connected with foreign keys (e.g., `host_id` in `PROPERTIES` references `user_id` in `USERS`).
- **Indexes**: Indexes are set up on frequently queried fields (e.g., foreign keys) to improve query performance.

## Normalization

The schema is in **Third Normal Form (3NF)**, which eliminates redundancy and ensures data integrity.

## Usage

1. Run the SQL script in your database.
2. Feel free to modify or extend the schema as needed.
