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
