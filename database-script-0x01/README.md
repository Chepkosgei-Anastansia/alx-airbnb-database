# Airbnb-Clone Database Schema

## Objective
This project defines a relational database schema for an Airbnb-clone application. It applies normalization principles to ensure the schema is in Third Normal Form (3NF), defines entities with constraints, and includes indexes for performance.

---

## Entities and Relationships

### Users
- Hosts, guests, and admins.
- Identified by `user_id` (UUID).
- Indexed on `email` for fast lookup.

### Properties
- Each property is listed by a host (`host_id`).
- Contains details like location, price, description.

### Bookings
- Created by guests.
- Linked to a `property_id` and `user_id`.
- Includes status (pending, confirmed, canceled).

### Payments
- Each booking has one associated payment.
- Tracks amount, payment method, and date.

### Reviews
- Users can leave reviews for properties.
- Includes a rating and a comment.

### Messages
- Users can message each other.
- Messages include sender and recipient references.

---

## SQL Features Used
- `UUID` as primary keys  
- `ENUM` for roles, booking status, and payment method  
- `CHECK` constraint for review ratings (1–5)  
- Foreign key constraints to enforce relationships  
- Indexes on foreign keys and frequently queried fields  

---

## Normalization to 3NF

### 1NF (First Normal Form)
- All columns hold atomic, indivisible values

### 2NF (Second Normal Form)
- All non-key attributes are fully dependent on the entire primary key

### 3NF (Third Normal Form)
- No transitive dependencies between non-key attributes  
- All non-key fields depend only on the primary key

---

## Files
- `schema.sql`: Contains SQL `CREATE TABLE` scripts with constraints and indexes  
- `normalization.md`: Detailed explanation of normalization process  
- `README.md`: This documentation  

---

## Future Enhancements
- Add a `property_images` table  
- Add `favorites` and `availability_calendar`  
- Introduce soft-delete or audit trails (`is_deleted`, `deleted_at` fields)  

---
