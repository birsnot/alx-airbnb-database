# Performance Monitoring Report

## Objective

Continuously monitor and refine database performance by analyzing query execution plans and making schema adjustments.

---

## Step 1: Analyzed Query

We examined the following frequently used query that retrieves booking and user information for properties in a specific location:

```sql
EXPLAIN ANALYZE
SELECT u.name, b.start_date, p.name AS property_name
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
WHERE p.location = 'Addis Ababa';
```

---

## Step 2: Performance Issue

### Execution Plan (Before Indexing)

* **Execution Time**: \~125 ms
* **Plan Summary**:

  * Sequential scan on `properties`
  * Hash join with `bookings`
  * No indexes used on `location`, `user_id`, or `property_id`

This query was slow due to lack of filtering indexes, especially on `properties.location` and foreign keys in join conditions.

---

## Step 3: Schema Adjustments

We added the following indexes:

```sql
-- Index on properties.location for faster filtering
CREATE INDEX idx_properties_location ON properties(location);

-- Index on bookings.property_id for faster joins
CREATE INDEX idx_bookings_property_id ON bookings(property_id);

-- Index on bookings.user_id for faster joins
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
```

---

## Step 4: Re-Test Query

### Execution Plan (After Indexing)

* **Execution Time**: \~27 ms
* **Plan Summary**:

  * Index scan on `properties`
  * Efficient nested loop joins using indexes

---

## Step 5: Observations and Recommendations

### Observations:

* Query time improved by \~78%.
* Indexes significantly reduce scan and join cost for large datasets.

### Recommendations:

* Regularly monitor high-usage queries using `EXPLAIN ANALYZE`.
* Add indexes to columns commonly used in `WHERE`, `JOIN`, or `ORDER BY`.
* Consider partial indexes or covering indexes for large production datasets.

---

## Conclusion

Using query profiling and schema adjustments (indexes), we successfully optimized a critical query. Regular performance monitoring and indexing should be part of ongoing database maintenance.
