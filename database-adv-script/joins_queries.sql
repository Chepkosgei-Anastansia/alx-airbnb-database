-- Write a query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings.
SELECT 
    b.booking_id,
    BIN_TO_UUID(b.booking_id) AS booking_uuid,
    BIN_TO_UUID(u.user_id) AS user_uuid,
    u.first_name,
    u.last_name,
    u.email,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status
FROM 
    bookings b
INNER JOIN 
    users u ON b.user_id = u.user_id;


-- Write a query using aLEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.
SELECT 
    p.property_id,
    BIN_TO_UUID(p.property_id) AS property_uuid,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    r.review_id,
    BIN_TO_UUID(r.review_id) AS review_uuid,
    BIN_TO_UUID(r.user_id) AS reviewer_uuid,
    u.first_name AS reviewer_first_name,
    u.last_name AS reviewer_last_name,
    r.rating,
    r.comment,
    r.created_at AS review_date
FROM 
    properties p
LEFT JOIN 
    reviews r ON p.property_id = r.property_id
LEFT JOIN
    users u ON r.user_id = u.user_id
ORDER BY 
    p.name, r.created_at DESC;


-- Write a query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
SELECT 
    BIN_TO_UUID(u.user_id) AS user_uuid,
    u.first_name,
    u.last_name,
    u.email,
    BIN_TO_UUID(b.booking_id) AS booking_uuid,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    CASE 
        WHEN b.booking_id IS NULL THEN 'No bookings'
        WHEN u.user_id IS NULL THEN 'Orphaned booking'
        ELSE 'Has booking'
    END AS booking_status
FROM 
    users u
LEFT JOIN 
    bookings b ON u.user_id = b.user_id

UNION

SELECT 
    BIN_TO_UUID(u.user_id) AS user_uuid,
    u.first_name,
    u.last_name,
    u.email,
    BIN_TO_UUID(b.booking_id) AS booking_uuid,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    CASE 
        WHEN b.booking_id IS NULL THEN 'No bookings'
        WHEN u.user_id IS NULL THEN 'Orphaned booking'
        ELSE 'Has booking'
    END AS booking_status
FROM 
    users u
RIGHT JOIN 
    bookings b ON u.user_id = b.user_id
WHERE 
    u.user_id IS NULL
ORDER BY 
    booking_status, last_name, first_name;
