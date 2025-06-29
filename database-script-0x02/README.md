# Seeding the Airbnb Database

## Objective

This README provides guidance on how to seed the Airbnb-style database with sample data for development or testing purposes.

---

## What is Seeding?

Seeding is the process of populating your database with sample data. It helps:

* Test application features
* Verify relationships and constraints
* Provide a working demo environment

---

## Entities Seeded

This seed script includes sample entries for:

* `users`: 3 sample users (hosts and guests)
* `properties`: 3 properties listed by hosts
* `bookings`: 3 bookings by guests
* `payments`: 3 payments linked to bookings
* `reviews`: 3 reviews by users
* `messages`: 3 conversations between users

---

## How to Seed the Data

1. Ensure the database schema has been created by running `schema.sql`.
2. Run the `seed.sql` file using your SQL tool or terminal:

```bash
psql -U your_username -d your_database -f seed.sql
```

Or for MySQL:

```bash
mysql -u your_username -p your_database < seed.sql
```

---

## Notes

* UUIDs are pre-defined for simplicity. Adjust if using auto-generated values.
* Timestamps use default values where applicable.
* Email and role values reflect realistic usage scenarios.

---

## Files

* `seed.sql`: Contains all INSERT statements.
* `schema.sql`: Database table definitions.

---

## Next Steps

* Add more entries to simulate real-world activity.
* Consider random data generators or CSV imports for bulk data.
* Add edge cases (cancellations, overbookings, etc.) for robust testing.
---

