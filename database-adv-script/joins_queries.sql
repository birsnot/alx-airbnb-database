SELECT *
FROM bookings b
INNER JOIN users u ON b.user_id = u.id;


SELECT *
FROM properties p
LEFT JOIN reviews r ON r.property_id = p.id
ORDER BY r.rating;


SELECT *
FROM users u
FULL OUTER JOIN bookings b ON b.user_id = u.id;