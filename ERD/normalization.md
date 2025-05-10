# Normalization Report

This report outlines the steps taken to apply normalization to the Airbnb-style database schema.

## First Normal Form (1NF)

In 1NF, we ensure that all data is stored in its simplest form, meaning that each attribute contains only **atomic** values — no arrays or multiple values in a single field.

✅ **The schema is in 1NF**, meaning all tables have atomic values and no repeating groups.

## Second Normal Form (2NF)

For 2NF, we make sure that all non-key attributes depend entirely on the primary key. This means that if we have a composite key (i.e., a primary key made up of multiple fields), every non-key attribute must depend on the whole key, not just part of it.

✅ **The schema is in 2NF**, as every non-key attribute is fully dependent on the primary key, and there are no partial dependencies.

## Third Normal Form (3NF)

3NF takes things a step further by removing **transitive dependencies**. This means that non-key attributes should only depend on the primary key and not on other non-key attributes.

- **USERS**: All attributes are directly dependent on the `user_id` (the primary key).
- **PROPERTIES**: Fields like `name`, `location`, and `pricepernight` all depend on the `property_id` (the primary key).
- **BOOKINGS**: All fields depend on the `booking_id`.
- **PAYMENTS**, **REVIEWS**, **MESSAGES**: There are no transitive dependencies in these tables.

✅ **The schema is in 3NF**, as we've ensured that there are no transitive dependencies.

## Conclusion

After reviewing the database schema, we can confirm that it meets the requirements of 3NF. No major changes were needed.
