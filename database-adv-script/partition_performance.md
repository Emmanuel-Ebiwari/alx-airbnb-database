# Partitioning Optimization Report

## Objective

Optimize query performance on the `BOOKINGS` table by implementing partitioning based on the `start_date` column.

## Partitioning Strategy

The `BOOKINGS` table was partitioned using the `RANGE` method on the `start_date` column. Partitions were created for the following yearly ranges:

- Before 2022
- 2022
- 2023
- 2024
- 2025
- 2026 and beyond

This setup allows MySQL to apply **partition pruning**, reducing the number of rows scanned when filtering by date ranges.

## Test Query

The query below was used to evaluate performance on the partitioned table:

EXPLAIN ANALYZE  
SELECT \*  
FROM BOOKINGS  
WHERE start_date BETWEEN '2023-01-01' AND '2023-12-31';

## Observed Improvements

### Before Partitioning

- Full table scan was performed.
- All rows were evaluated even when only a specific date range was queried.
- Resulted in higher I/O and CPU usage on large datasets.

### After Partitioning

- Only the relevant partition (for 2023) was scanned due to **partition pruning**.
- Significant reduction in the number of rows scanned.
- Improved query execution time and resource usage.

## Conclusion

Partitioning the `BOOKINGS` table by `start_date` led to measurable performance improvements for date-based queries. This approach is especially effective when dealing with large historical datasets or running frequent range-based reports.
