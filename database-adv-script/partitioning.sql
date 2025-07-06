-- Step 1: Create partitioned table without foreign key constraints
CREATE TABLE partitioned_bookings (
    booking_id BINARY(16) NOT NULL,
    user_id BINARY(16) NOT NULL,
    property_id BINARY(16) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status ENUM('pending','confirmed','canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2020 VALUES LESS THAN (2021),
    PARTITION p2021 VALUES LESS THAN (2022),
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION pmax VALUES LESS THAN MAXVALUE
);

-- Step 2: Migrate data
INSERT INTO partitioned_bookings 
SELECT * FROM bookings;

-- Step 3: Verify data integrity manually
SELECT COUNT(*) FROM bookings;
SELECT COUNT(*) FROM partitioned_bookings;

-- Step 4: Create application-level foreign key checks
DELIMITER //
CREATE TRIGGER check_user_exists
BEFORE INSERT ON partitioned_bookings
FOR EACH ROW
BEGIN
    DECLARE user_exists INT;
    SELECT COUNT(*) INTO user_exists FROM users WHERE user_id = NEW.user_id;
    IF user_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'User does not exist';
    END IF;
END//

CREATE TRIGGER check_property_exists
BEFORE INSERT ON partitioned_bookings
FOR EACH ROW
BEGIN
    DECLARE property_exists INT;
    SELECT COUNT(*) INTO property_exists FROM properties WHERE property_id = NEW.property_id;
    IF property_exists = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Property does not exist';
    END IF;
END//
DELIMITER ;

-- Step 5: Replace original table (after thorough testing)
RENAME TABLE bookings TO bookings_old, partitioned_bookings TO bookings;
