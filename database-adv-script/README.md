````markdown
# SQL Joins Practice

## Objective

Master SQL joins by writing complex queries using different types of joins.

## Queries

### 1. INNER JOIN

Retrieve all bookings and the respective users who made those bookings.

```sql
SELECT *
FROM BOOKINGS
INNER JOIN USERS ON BOOKINGS.user_id = USERS.user_id;
```
````

### 2. LEFT JOIN

Retrieve all properties and their reviews, including properties that have no reviews.

```sql
SELECT *
FROM PROPERTIES
LEFT JOIN REVIEWS ON PROPERTIES.property_id = REVIEWS.property_id;
```

### 3. FULL OUTER JOIN

Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.

```sql
SELECT *
FROM USERS
FULL OUTER JOIN BOOKINGS ON USERS.user_id = BOOKINGS.user_id;
```

> ⚠️ MySQL does **not** support `FULL OUTER JOIN` directly.  
> You can simulate it using `UNION` with `LEFT JOIN` and `RIGHT JOIN`:

```sql
SELECT *
FROM USERS
LEFT JOIN BOOKINGS ON USERS.user_id = BOOKINGS.user_id

UNION

SELECT *
FROM USERS
RIGHT JOIN BOOKINGS ON USERS.user_id = BOOKINGS.user_id;
```
