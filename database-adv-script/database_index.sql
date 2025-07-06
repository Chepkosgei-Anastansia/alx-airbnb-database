-- Users Table Indexes
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);

-- Bookings Table Indexes
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_dates ON bookings(start_date, end_date);
CREATE INDEX idx_bookings_status ON bookings(status);

-- Properties Table Indexes
CREATE INDEX idx_properties_host_id ON properties(host_id);
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_properties_price ON properties(pricepernight);
CREATE INDEX idx_properties_location_price ON properties(location, pricepernight);



-- Query to analyze performance before and after Indexing
EXPLAIN ANALYZE
SELECT * FROM bookings 
WHERE user_id = UUID_TO_BIN('22222222-2222-2222-2222-222222222222') 
AND status = 'confirmed';



-- Output before Indexing
Filter: (bookings.`status` = 'confirmed')  (cost=0.6 rows=1) (actual time=0.104..0.123 rows=2 loops=1)
    -> Index lookup on bookings using user_id (user_id=uuid_to_bin('22222222-2222-2222-2222-222222222222')), 
    with index condition: (bookings.user_id = <cache>(uuid_to_bin('22222222-2222-2222-2222-222222222222')))  
    (cost=0.6 rows=3) (actual time=0.0983..0.113 rows=3 loops=1)



-- Output after indexing
 Filter: (bookings.`status` = 'confirmed')  (cost=0.708 rows=2.08) (actual time=0.068..0.0783 rows=2 loops=1)
    -> Index lookup on bookings using idx_bookings_user_id (user_id=uuid_to_bin('22222222-2222-2222-2222-222222222222')),
     with index condition: (bookings.user_id = <cache>(uuid_to_bin('22222222-2222-2222-2222-222222222222')))  
     (cost=0.708 rows=3) (actual time=0.0638..0.0717 rows=3 loops=1)
 |
