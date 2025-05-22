SELECT property_id
FROM (
    SELECT property_id, AVG(rating) AS average_rating
    FROM reviews
    GROUP BY property_id
) AS avg_ratings
WHERE average_rating > 4.0;



SELECT name
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.id
) > 3;
