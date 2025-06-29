-- =============== USERS ===============
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES 
('11111111-1111-1111-1111-111111111111', 'Alice', 'Wanjiku', 'alice@example.com', 'hashed_pw1', '0712345678', 'host'),
('22222222-2222-2222-2222-222222222222', 'Brian', 'Otieno', 'brian@example.com', 'hashed_pw2', '0723456789', 'guest'),
('33333333-3333-3333-3333-333333333333', 'Clara', 'Mwende', 'clara@example.com', 'hashed_pw3', '0734567890', 'host');

-- =============== PROPERTIES ===============
INSERT INTO properties (property_id, host_id, name, description, location, pricepernight)
VALUES 
('aaaa1111-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 'Hillview Apartment', '2BR with balcony view', 'Nairobi, Kenya', 4000.00),
('bbbb2222-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '33333333-3333-3333-3333-333333333333', 'Beachside Cottage', 'Relaxing 3BR beach house', 'Diani, Kenya', 7000.00),
('cccc3333-cccc-cccc-cccc-cccccccccccc', '11111111-1111-1111-1111-111111111111', 'Studio Haven', 'Compact modern studio', 'Kilimani, Nairobi', 3000.00);

-- =============== BOOKINGS ===============
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES 
('book-0001-aaaa-bbbb-cccccccc0001', 'aaaa1111-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '22222222-2222-2222-2222-222222222222', '2025-07-01', '2025-07-05', 16000.00, 'confirmed'),
('book-0002-bbbb-cccc-ddddddd0002', 'bbbb2222-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '22222222-2222-2222-2222-222222222222', '2025-07-10', '2025-07-15', 35000.00, 'pending'),
('book-0003-cccc-aaaa-bbbb0000003', 'cccc3333-cccc-cccc-cccc-cccccccccccc', '22222222-2222-2222-2222-222222222222', '2025-07-20', '2025-07-22', 6000.00, 'confirmed');

-- =============== PAYMENTS ===============
INSERT INTO payments (payment_id, booking_id, amount, payment_method)
VALUES 
('pay-0001-aaaa-bbbb-cccc1111', 'book-0001-aaaa-bbbb-cccccccc0001', 16000.00, 'credit_card'),
('pay-0002-bbbb-cccc-dddd2222', 'book-0002-bbbb-cccc-ddddddd0002', 35000.00, 'paypal'),
('pay-0003-cccc-aaaa-bbbb3333', 'book-0003-cccc-aaaa-bbbb0000003', 6000.00, 'stripe');

-- =============== REVIEWS ===============
INSERT INTO reviews (review_id, property_id, user_id, rating, comment)
VALUES 
('rev-0001', 'aaaa1111-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '22222222-2222-2222-2222-222222222222', 5, 'Amazing view and host was very helpful!'),
('rev-0002', 'bbbb2222-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '22222222-2222-2222-2222-222222222222', 4, 'Nice and quiet spot, good for families.'),
('rev-0003', 'cccc3333-cccc-cccc-cccc-cccccccccccc', '22222222-2222-2222-2222-222222222222', 3, 'Affordable but a bit noisy.');

-- =============== MESSAGES ===============
INSERT INTO messages (message_id, sender_id, recipient_id, message_body)
VALUES 
('msg-0001', '22222222-2222-2222-2222-222222222222', '11111111-1111-1111-1111-111111111111', 'Hi, is Hillview Apartment available next weekend?'),
('msg-0002', '11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222', 'Yes, it is available. You can go ahead and book.'),
('msg-0003', '22222222-2222-2222-2222-222222222222', '33333333-3333-3333-3333-333333333333', 'Is your beach house pet-friendly?');
