# Airbnb ER Diagram Documentation

## Objective

Create an Entity-Relationship (ER) diagram based on the provided Airbnb-style database specification.

---

## Entities and Attributes

### 1. User

* **user\_id**: Primary Key, UUID, Indexed
* **first\_name**: VARCHAR, NOT NULL
* **last\_name**: VARCHAR, NOT NULL
* **email**: VARCHAR, UNIQUE, NOT NULL
* **password\_hash**: VARCHAR, NOT NULL
* **phone\_number**: VARCHAR, NULL
* **role**: ENUM (guest, host, admin), NOT NULL
* **created\_at**: TIMESTAMP, DEFAULT CURRENT\_TIMESTAMP

### 2. Property

* **property\_id**: Primary Key, UUID, Indexed
* **host\_id**: Foreign Key → User(user\_id)
* **name**: VARCHAR, NOT NULL
* **description**: TEXT, NOT NULL
* **location**: VARCHAR, NOT NULL
* **pricepernight**: DECIMAL, NOT NULL
* **created\_at**: TIMESTAMP, DEFAULT CURRENT\_TIMESTAMP
* **updated\_at**: TIMESTAMP, ON UPDATE CURRENT\_TIMESTAMP

### 3. Booking

* **booking\_id**: Primary Key, UUID, Indexed
* **property\_id**: Foreign Key → Property(property\_id)
* **user\_id**: Foreign Key → User(user\_id)
* **start\_date**: DATE, NOT NULL
* **end\_date**: DATE, NOT NULL
* **total\_price**: DECIMAL, NOT NULL
* **status**: ENUM (pending, confirmed, canceled), NOT NULL
* **created\_at**: TIMESTAMP, DEFAULT CURRENT\_TIMESTAMP

### 4. Payment

* **payment\_id**: Primary Key, UUID, Indexed
* **booking\_id**: Foreign Key → Booking(booking\_id)
* **amount**: DECIMAL, NOT NULL
* **payment\_date**: TIMESTAMP, DEFAULT CURRENT\_TIMESTAMP
* **payment\_method**: ENUM (credit\_card, paypal, stripe), NOT NULL

### 5. Review

* **review\_id**: Primary Key, UUID, Indexed
* **property\_id**: Foreign Key → Property(property\_id)
* **user\_id**: Foreign Key → User(user\_id)
* **rating**: INTEGER, CHECK (1 <= rating <= 5), NOT NULL
* **comment**: TEXT, NOT NULL
* **created\_at**: TIMESTAMP, DEFAULT CURRENT\_TIMESTAMP

### 6. Message

* **message\_id**: Primary Key, UUID, Indexed
* **sender\_id**: Foreign Key → User(user\_id)
* **recipient\_id**: Foreign Key → User(user\_id)
* **message\_body**: TEXT, NOT NULL
* **sent\_at**: TIMESTAMP, DEFAULT CURRENT\_TIMESTAMP

---

## Relationships Between Entities

### User to Property

* **One-to-Many**
* A user (host) can list multiple properties.
* Each property is hosted by exactly one user.

### User to Booking

* **One-to-Many**
* A user (guest) can make many bookings.
* Each booking is associated with one user.

### Property to Booking

* **One-to-Many**
* A property can be booked many times.
* Each booking references one property.

### Booking to Payment

* **One-to-One**
* Each booking has exactly one associated payment.
* Each payment refers to one booking.

### Property to Review

* **One-to-Many**
* Each property can have many reviews.
* Each review is linked to one property.

### User to Review

* **One-to-Many**
* A user can write many reviews.
* Each review is written by one user.

### User to Message

* **One-to-Many (Two Roles)**
* A user can send and receive many messages.
* Each message has a sender and a recipient, both of whom are users.

---

## Diagram Notes

* Primary keys are underlined in the ERD.
* Crow's Foot Notation is used to indicate cardinalities.
* All foreign keys create referential integrity links between the relevant entities.
* Indexed attributes include primary keys and selected search-heavy fields like `email`, `property_id`, and `booking_id`.

---

## ERD Diagram

![ERD Diagram](Chepkosgei-Anastansia/alx-airbnb-database/ERD/img/ERD.drawio.png)
