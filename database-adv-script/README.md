# SQL Join Queries – Airbnb Database

This directory contains advanced SQL JOIN queries used to retrieve related data from multiple tables in the Airbnb database system.

## Files

- `joins_queries.sql` – Contains SQL statements using various types of JOINs to demonstrate different relationships and data retrieval scenarios.

## JOIN Queries Included

### 1. INNER JOIN
Retrieves all bookings and the respective users who made those bookings.

```sql
SELECT *
FROM bookings b
INNER JOIN users u ON b.user_id = u.id;
```

### 2. LEFT JOIN

Retrieves all properties and their reviews, including properties that have no reviews.

```sql
SELECT *
FROM properties p
LEFT JOIN reviews r ON r.property_id = p.id;
```

### 3. FULL OUTER JOIN

Retrieves all users and all bookings, even if the user has no booking or a booking is not linked to a user.

```sql
SELECT *
FROM users u
FULL OUTER JOIN bookings b ON b.user_id = u.id;
```

## Subqueries

This task demonstrates the use of both **non-correlated** and **correlated** subqueries in SQL.

### Non-Correlated Subquery

**Objective**: Find all properties where the average rating is greater than 4.0.

```sql
SELECT property_id
FROM (
    SELECT property_id, AVG(rating) AS average_rating
    FROM reviews
    GROUP BY property_id
) AS avg_ratings
WHERE average_rating > 4.0;
```

* The inner query calculates the average rating per property.
* The outer query filters those properties with an average rating above 4.0.
* Since the inner query runs independently, this is a **non-correlated** subquery.

---

### Correlated Subquery

**Objective**: Find all users who have made more than 3 bookings.

```sql
SELECT name
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.id
) > 3;
```

* The inner query depends on the current user from the outer query (`u.id`).
* It is evaluated once for each row in the `users` table.
* This makes it a **correlated subquery**.

---

These queries are saved in `subqueries.sql` inside this directory.