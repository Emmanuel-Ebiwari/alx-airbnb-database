# Database Performance Monitoring Report

## Objective

Continuously monitor and refine database performance by analyzing query execution plans and making schema adjustments.

---

## Monitoring Strategy

To assess the performance of frequently used queries, two tools were utilized:

- `EXPLAIN ANALYZE`: Used to break down the execution plan and understand how MySQL processes queries, especially around joins and filtering.
- `SHOW PROFILE`: Used to capture the actual time spent in each phase of query execution to help detect inefficiencies.

---

## Monitored Query and Findings

### Query: Count of payments per user

```sql
-- Enable profiling
SET PROFILING = 1;

-- Execute query
SELECT B.user_id, COUNT(*) AS total_payments
FROM BOOKINGS B
JOIN PAYMENTS PY ON B.booking_id = PY.booking_id
GROUP BY B.user_id;

-- Show profile of the last query
SHOW PROFILE FOR QUERY 1;
```

### SHOW PROFILE Output:

| Status         | Duration (s) |
| -------------- | ------------ |
| starting       | 0.000470     |
| query end      | 0.000037     |
| closing tables | 0.000021     |
| freeing items  | 0.000263     |
| cleaning up    | 0.000109     |

The profiling breakdown indicates a lightweight query execution, with the majority of time spent on startup and resource cleanup. Very little time was consumed by actual data processing.

### EXPLAIN ANALYZE Output (Summary):

Running `EXPLAIN ANALYZE` on the same query revealed that the join between `BOOKINGS` and `PAYMENTS` was efficiently handled using index lookups. The optimizer used nested loop joins, and row counts were accurate, suggesting statistics are up to date.

```sql
EXPLAIN ANALYZE
SELECT B.user_id, COUNT(*) AS total_payments
FROM BOOKINGS B
JOIN PAYMENTS PY ON B.booking_id = PY.booking_id
GROUP BY B.user_id;
```

This confirmed that indexing on `booking_id` helped reduce unnecessary full-table scans. However, considering future growth, indexing is still recommended proactively.

### Action Taken:

To prevent future slowdowns as the dataset grows, the following index was added:

```sql
CREATE INDEX idx_payments_booking_id ON PAYMENTS (booking_id);
```

This is expected to support the efficiency of the join in long-term usage, especially under higher load or larger datasets.

---

## Observed Improvements (Projected)

| Tool            | Observation Summary                                                  |
| --------------- | -------------------------------------------------------------------- |
| SHOW PROFILE    | Very short execution time, with most time spent in setup/cleanup     |
| EXPLAIN ANALYZE | Efficient plan detected, using nested loop joins and proper indexing |

Although the current data volume is small and performance was already fast, the analysis helped ensure the schema is prepared to scale efficiently.

---

## Conclusion

Using both `SHOW PROFILE` and `EXPLAIN ANALYZE`, we validated that our query design and indexing are effective for now. Time spent was minimal, indicating good performance, but indexing was introduced proactively to ensure scalability. This kind of monitoring, even when things “seem fine,” is useful for maintaining long-term efficiency.
