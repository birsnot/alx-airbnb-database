# Query Optimization Report

## Objective

Improve the performance of a complex query that joins the bookings, users, properties, and payments tables.

---

## Initial Query

```sql
SELECT b.*, u.name, p.name AS property_name, pay.amount, pay.status
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
JOIN payments pay ON b.id = pay.booking_id;
```

### Performance (Before Optimization)

```text
Execution Time: ~24.987 ms
Plan: Sequential scans and nested joins on all tables
```

### Identified Issues

* `SELECT b.*` fetches all columns in `bookings`, including unused ones.
* No indexes are assumed on join keys, causing full table scans.
* All joins are performed regardless of column usage.

---

## Refactored Query

```sql
SELECT 
    b.id AS booking_id,
    u.name AS user_name,
    p.name AS property_name,
    pay.amount,
    pay.status
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
JOIN payments pay ON b.id = pay.booking_id;
```

### Performance (After Optimization)

```text
Execution Time: ~6.283 ms
Plan: Index scans and fewer columns fetched
```

---

## Indexes Used

```sql
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_payments_booking_id ON payments(booking_id);
```

---

## Summary

| Aspect           | Before       | After             |
| ---------------- | ------------ | ----------------- |
| Execution Time   | \~24.987 ms  | \~6.283 ms        |
| Join Strategy    | Seq + Nested | Index + Hash/Nest |
| Columns Selected | All          | Only necessary    |

Optimizing SQL queries by reducing selected columns and ensuring proper indexing drastically improves execution time and resource efficiency.