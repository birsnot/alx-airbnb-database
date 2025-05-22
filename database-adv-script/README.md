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

## Usage

Run these queries in a PostgreSQL-compatible environment to test and explore different types of joins.

## Requirements

* Basic knowledge of SQL syntax and relational databases
* Tables: `users`, `bookings`, `properties`, `reviews`
