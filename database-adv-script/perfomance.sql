-- Write an initial query that retrieves all bookings along with the user details, property details, and payment details and save it on perfomance.sql
-- Optimized booking details query
WITH property_reviews AS (
    SELECT 
        property_id, 
        COUNT(*) AS review_count,
        AVG(rating) AS avg_rating
    FROM reviews
    GROUP BY property_id
)

SELECT 
    BIN_TO_UUID(b.booking_id) AS booking_id,
    BIN_TO_UUID(u.user_id) AS user_id,
    u.first_name,
    u.last_name,
    u.email,
    BIN_TO_UUID(p.property_id) AS property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    BIN_TO_UUID(py.payment_id) AS payment_id,
    py.amount,
    py.payment_method,
    py.payment_date,
    COALESCE(pr.review_count, 0) AS review_count,
    ROUND(COALESCE(pr.avg_rating, 0), 2) AS avg_rating
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments py ON b.booking_id = py.booking_id
LEFT JOIN property_reviews pr ON p.property_id = pr.property_id
WHERE b.start_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 6 MONTH)
ORDER BY b.start_date DESC
LIMIT 1000;
-- Analyze the query’s performance using EXPLAIN and identify any inefficiencies.
EXPLAIN ANALYZE WITH property_reviews AS (
    SELECT 
        property_id, 
        COUNT(*) AS review_count,
        AVG(rating) AS avg_rating
    FROM reviews
    GROUP BY property_id
)

SELECT 
    BIN_TO_UUID(b.booking_id) AS booking_id,
    BIN_TO_UUID(u.user_id) AS user_id,
    u.first_name,
    u.last_name,
    u.email,
    BIN_TO_UUID(p.property_id) AS property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    BIN_TO_UUID(py.payment_id) AS payment_id,
    py.amount,
    py.payment_method,
    py.payment_date,
    COALESCE(pr.review_count, 0) AS review_count,
    ROUND(COALESCE(pr.avg_rating, 0), 2) AS avg_rating
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments py ON b.booking_id = py.booking_id
LEFT JOIN property_reviews pr ON p.property_id = pr.property_id
WHERE b.start_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 6 MONTH)
ORDER BY b.start_date DESC
LIMIT 1000;

-- Refactor the query to reduce execution time, such as reducing unnecessary joins or using indexing
Limit: 1000 row(s)  (cost=34.7 rows=130) (actual time=0.225..0.429 rows=13 loops=1)
    -> Nested loop left join  (cost=34.7 rows=130) (actual time=0.224..0.427 rows=13 loops=1)
        -> Nested loop inner join  (cost=15.2 rows=13) (actual time=0.114..0.288 rows=13 loops=1)
            -> Nested loop inner join  (cost=10.7 rows=13) (actual time=0.104..0.247 rows=13 loops=1)
                -> Nested loop left join  (cost=6.1 rows=13) (actual time=0.0936..0.193 rows=13 loops=1)
                    -> Sort: b.start_date DESC  (cost=1.55 rows=13) (actual time=0.0729..0.0801 rows=13 loops=1)
                        -> Filter: (b.start_date >= <cache>((curdate() - interval 6 month)))  (cost=1.55 rows=13) (actual time=0.0353..0.0471 rows=13 loops=1)
                            -> Table scan on b  (cost=1.55 rows=13) (actual time=0.0295..0.0367 rows=13 loops=1)
                    -> Index lookup on py using idx_payments_booking_id (booking_id=b.booking_id)  (cost=0.258 rows=1) (actual time=0.00709..0.00827 rows=1 loops=13)
                -> Single-row index lookup on p using PRIMARY (property_id=b.property_id)  (cost=0.258 rows=1) (actual time=0.00367..0.00372 rows=1 loops=13)
            -> Single-row index lookup on u using PRIMARY (user_id=b.user_id)  (cost=0.258 rows=1) (actual time=0.00272..0.00278 rows=1 loops=13)
        -> Index lookup on pr using <auto_key0> (property_id=b.property_id)  (cost=4.11..4.37 rows=2) (actual time=0.00951..0.00998 rows=1 loops=13)
            -> Materialize CTE property_reviews  (cost=3.85..3.85 rows=10) (actual time=0.105..0.105 rows=10 loops=1)
                -> Group aggregate: count(0), avg(reviews.rating)  (cost=2.85 rows=10) (actual time=0.0508..0.0681 rows=10 loops=1)
                    -> Index scan on reviews using idx_reviews_property_id  (cost=1.55 rows=13) (actual time=0.042..0.047 rows=13 loops=1)
