EXPLAIN ANALYZE
SELECT *
FROM users
WHERE name = 'Nardos';

EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE user_id = 5;

EXPLAIN ANALYZE
SELECT *
FROM bookings
JOIN users ON bookings.user_id = users.id;

EXPLAIN ANALYZE
SELECT *
FROM properties
WHERE location = 'Addis Ababa';

EXPLAIN ANALYZE
SELECT *
FROM properties
ORDER BY price DESC;

CREATE INDEX idx_users_name ON users(name);

CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);

CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_properties_price ON properties(price);

EXPLAIN ANALYZE
SELECT *
FROM users
WHERE name = 'Nardos';

EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE user_id = 5;

EXPLAIN ANALYZE
SELECT *
FROM bookings
JOIN users ON bookings.user_id = users.id;

EXPLAIN ANALYZE
SELECT *
FROM properties
WHERE location = 'Addis Ababa';

EXPLAIN ANALYZE
SELECT *
FROM properties
ORDER BY price DESC;