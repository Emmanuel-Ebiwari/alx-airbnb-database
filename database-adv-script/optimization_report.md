# SQL Query Optimization Report

## Overview

This report analyzes and compares two versions of a SQL query retrieving booking and payment information from an Airbnb-style database schema. The goal was to optimize the query for performance by rewriting it to make better use of SQL best practices, particularly around joins and index usage.

---

## 1. Initial (Non-Optimized) Query

```sql
SELECT *
FROM PAYMENTS, BOOKINGS, PROPERTIES, USERS
WHERE PAYMENTS.booking_id = BOOKINGS.booking_id
  AND BOOKINGS.property_id = PROPERTIES.property_id
  AND BOOKINGS.user_id = USERS.user_id;
```

### Issues Identified:

- \*\*SELECT \*\*\*: Fetches all columns unnecessarily, which can be inefficient.
- **Implicit joins**: Using comma-separated joins with `WHERE` clauses is discouraged in favor of `JOIN` syntax.
- **No filtering**: The query returns all data with no `WHERE` clause to narrow results.
- **Poor index usage**: `EXPLAIN` shows full table scans (type = `ALL`) for most tables.

### EXPLAIN Output:

| table      | type   | key     | rows | Extra                                      |
| ---------- | ------ | ------- | ---- | ------------------------------------------ |
| PAYMENTS   | ALL    | NULL    | 2    |                                            |
| BOOKINGS   | ALL    | NULL    | 2    | Using where; Using join buffer (hash join) |
| PROPERTIES | eq_ref | PRIMARY | 1    |                                            |
| USERS      | eq_ref | PRIMARY | 1    |                                            |

---

## 2. Refactored (Optimized) Query

```sql
SELECT
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
FROM PROPERTIES P
JOIN BOOKINGS B ON B.property_id = P.property_id
JOIN USERS U ON B.user_id = U.user_id
LEFT JOIN PAYMENTS PY ON B.booking_id = PY.booking_id;
```

### Improvements Made:

- **Explicit `JOIN` syntax**: More readable and maintainable.
- **Targeted fields**: Only selects needed columns.
- **JOIN order**: Begins from `PROPERTIES` to align with possible filtering strategies.

### Remaining Issues:

- **Indexes still not used**: `EXPLAIN` output still shows full scans due to small data size and lack of filtering.

### Refactored EXPLAIN Output:

| table      | type   | key     | rows | Extra                                      |
| ---------- | ------ | ------- | ---- | ------------------------------------------ |
| PROPERTIES | ALL    | NULL    | 2    |                                            |
| BOOKINGS   | ALL    | NULL    | 2    | Using where; Using join buffer (hash join) |
| USERS      | eq_ref | PRIMARY | 1    |                                            |
| PAYMENTS   | ALL    | NULL    | 2    | Using where; Using join buffer (hash join) |

---

## 3. Observations

- Due to the **small dataset size**, MySQL's query planner prefers full scans over index use.
- With larger datasets or added filtering conditions (e.g. date ranges, user filters), index usage would likely become more beneficial.
- Adding `FORCE INDEX` clauses can sometimes help test index performance under controlled scenarios.

---

## 4. Recommendations

- Always use **explicit joins** and **avoid `SELECT *`**.
- Add **WHERE clauses** to narrow down results and encourage index use.
- Use `EXPLAIN` and `EXPLAIN ANALYZE` during development to observe performance behavior.
- Ensure **appropriate indexes** exist and are actually being used.

---

## 5. Conclusion

While the optimized query is more structured and adheres to best practices, real performance gains are typically realized with larger datasets and specific filters. This exercise demonstrates good habits in query structuring and using performance diagnostics tools.
