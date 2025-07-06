-- Write a query to find all properties where the average rating is greater than 4.0 using a subquery.
SELECT 
    p.property_id,
    BIN_TO_UUID(p.property_id) AS property_uuid,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    ROUND(avg_rating, 2) AS average_rating,
    review_count
FROM 
    properties p
JOIN (
    SELECT 
        property_id,
        AVG(rating) AS avg_rating,
        COUNT(*) AS review_count
    FROM 
        reviews
    GROUP BY 
        property_id
    HAVING 
        AVG(rating) > 4.0
) AS property_ratings ON p.property_id = property_ratings.property_id
ORDER BY 
    average_rating DESC;


-- Write a correlated subquery to find users who have made more than 3 bookings.
SELECT 
    u.user_id,
    BIN_TO_UUID(u.user_id) AS user_uuid,
    u.first_name,
    u.last_name,
    u.email,
    (SELECT COUNT(*) 
     FROM bookings b 
     WHERE b.user_id = u.user_id) AS booking_count
FROM 
    users u
WHERE 
    (SELECT COUNT(*) 
     FROM bookings b 
     WHERE b.user_id = u.user_id) > 3
ORDER BY 
    booking_count DESC;
