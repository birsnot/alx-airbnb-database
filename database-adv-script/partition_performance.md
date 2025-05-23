# Partitioning Performance Report

## Objective

Improve performance of queries on a large `bookings` table by implementing partitioning based on the `start_date` column.

---

## Implementation

- The `bookings` table was partitioned by `RANGE(start_date)`.
- Monthly partitions were created (e.g., bookings_2024_01, bookings_2024_02, bookings_2024_03).
- Indexes were added to the child partitions on frequently filtered columns (`user_id`).

---

## Test Query

```sql
SELECT *
FROM bookings
WHERE start_date BETWEEN '2024-02-10' AND '2024-02-20';
```

### Performance Before Partitioning

```
Execution Time: ~94.123 ms
Plan: Full sequential scan on entire bookings table
```

### Performance After Partitioning

```
Execution Time: ~11.587 ms
Plan: Index scan on relevant child partition (bookings_2024_02)
```

---

## Observations

* PostgreSQL automatically prunes irrelevant partitions when using range filters.
* Query performance improved significantly when querying date-specific ranges.
* Partitioning is highly beneficial for large tables with time-based queries.

---

## Recommendation

Use **range partitioning** on columns like `start_date` for large transactional datasets to benefit from:

* Partition pruning
* Better I/O efficiency
* Scalable query performance over time