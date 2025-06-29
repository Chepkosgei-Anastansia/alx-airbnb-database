# AirBnB Database Normalization to 3NF

## Objective
Apply normalization principles to ensure the database is in the third normal form (3NF).  

---

## Step 1: Review of Entities and Attributes  

### **User**
- `user_id` (PK)
- `first_name`
- `last_name`
- `email` (UNIQUE)
- `password_hash`
- `phone_number`
- `role` (ENUM: guest, host, admin)
- `created_at`

---

### **Property**
- `property_id` (PK)
- `host_id` (FK → User.user_id)
- `name`
- `description`
- `location`
- `pricepernight`
- `created_at`
- `updated_at`

---

### **Booking**
- `booking_id` (PK)
- `property_id` (FK → Property.property_id)
- `user_id` (FK → User.user_id)
- `start_date`
- `end_date`
- `total_price`
- `status` (ENUM: pending, confirmed, canceled)
- `created_at`

---

### **Payment**
- `payment_id` (PK)
- `booking_id` (FK → Booking.booking_id)
- `amount`
- `payment_date`
- `payment_method` (ENUM: credit_card, paypal, stripe)

---

### **Review**
- `review_id` (PK)
- `property_id` (FK → Property.property_id)
- `user_id` (FK → User.user_id)
- `rating` (1-5)
- `comment`
- `created_at`

---

### **Message**
- `message_id` (PK)
- `sender_id` (FK → User.user_id)
- `recipient_id` (FK → User.user_id)
- `message_body`
- `sent_at`

---

## Step 2: Check for Normalization

### First Normal Form (1NF)
- All attributes are atomic (no multi-valued or repeating groups).
- Example: `phone_number` is single value per row (no multiple numbers in one field).  
---

### Second Normal Form (2NF)
- No partial dependency on part of a composite primary key.
- All tables have single-column primary keys.
- All non-key attributes depend on the entire key.  
---

### Third Normal Form (3NF)
- No transitive dependencies (non-key fields depending on other non-key fields).

#### Check examples:
- In `User`: no field depends on anything except `user_id`.
- In `Property`: `host_id` is a foreign key, but all fields depend only on `property_id`.
- In `Booking`: all fields depend on `booking_id`.
- In `Payment`: all fields depend on `payment_id`.
- In `Review`: all fields depend on `review_id`.
- In `Message`: all fields depend on `message_id`.

**Conclusion:** All entities are in 3NF.

---

