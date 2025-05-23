ALTER TABLE bookings RENAME TO bookings_backup;

CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    property_id INTEGER NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    status VARCHAR(50)
) PARTITION BY RANGE (start_date);

CREATE TABLE bookings_2024_01 PARTITION OF bookings
    FOR VALUES FROM ('2024-01-01') TO ('2024-02-01');

CREATE TABLE bookings_2024_02 PARTITION OF bookings
    FOR VALUES FROM ('2024-02-01') TO ('2024-03-01');

CREATE TABLE bookings_2024_03 PARTITION OF bookings
    FOR VALUES FROM ('2024-03-01') TO ('2024-04-01');


CREATE INDEX idx_bk_2024_01_user_id ON bookings_2024_01(user_id);
CREATE INDEX idx_bk_2024_02_user_id ON bookings_2024_02(user_id);
CREATE INDEX idx_bk_2024_03_user_id ON bookings_2024_03(user_id);


EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE start_date BETWEEN '2024-02-10' AND '2024-02-20';
