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


## Aggregations and Window Functions

This file contains SQL queries that demonstrate the use of aggregation and window functions to analyze booking data in the Airbnb system.

### 1. Total Bookings Per User

This query calculates the total number of bookings made by each user using the `COUNT` function with `GROUP BY`.

```sql
SELECT user_id, COUNT(*) AS total_bookings
FROM bookings
GROUP BY user_id;
```

### 2. Rank Properties by Booking Count

This query ranks properties based on how many bookings they have received. It uses a subquery to first count bookings per property, then applies two window functions:

* `RANK()` to assign ranks, allowing ties
* `ROW_NUMBER()` to assign a unique order

```sql
SELECT property_id,
       total_bookings,
       RANK() OVER (ORDER BY total_bookings DESC) AS booking_rank,
       ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS booking_row_number
FROM (
    SELECT property_id, COUNT(*) AS total_bookings
    FROM bookings
    GROUP BY property_id
) AS booking_counts;
```

### File

* `aggregations_and_window_functions.sql`: contains the queries.