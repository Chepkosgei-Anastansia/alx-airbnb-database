 # SQL Joins Mastery: Complex Query Implementation

## INNER JOIN Implementation
**Objective:** Retrieve all bookings with their associated user details  
**Characteristics:**
- Only returns matched records from both tables
- Ideal for finding complete booking-user pairs
- Excludes both orphaned bookings and users without bookings
- Most efficient join type for this use case

**Performance Tip:**  
Ensure indexes exist on the join columns (`user_id` in both tables)

## LEFT JOIN Implementation
**Objective:** Retrieve all properties with their reviews (including unreviewed properties)  
**Characteristics:**
- Returns all properties regardless of review status
- Review information appears as NULL for unreviewed properties
- Preserves complete property inventory
- Essential for comprehensive reporting

**Performance Tip:**  
Add a composite index on `property_id` and `rating` in reviews table

## FULL OUTER JOIN Simulation
**Objective:** Retrieve all users and all bookings (including unmatched records)  
**Implementation Notes:**
- MySQL requires UNION of LEFT and RIGHT joins
- Returns:
  - All users (even without bookings)
  - All bookings (even without users)
  - Complete relationship mapping
- Critical for data integrity analysis

**Performance Consideration:**  
This is the most resource-intensive operation - use judiciously

## Join Type Comparison

| Join Type       | Matched Records | Left Unmatched | Right Unmatched | Use Case                          |
|----------------|----------------|----------------|----------------|----------------------------------|
| INNER JOIN     | ✓             | ✗             | ✗             | Complete relationships only       |
| LEFT JOIN      | ✓             | ✓             | ✗             | Preserve primary table records    |
| FULL OUTER     | ✓             | ✓             | ✓             | Complete relationship analysis   |

## Best Practices
1. Always:
   - Verify join conditions
   - Consider indexing strategy
   - Analyze query execution plans

2. Remember:
   - INNER JOINs optimize performance
   - LEFT JOINs ensure data completeness
   - FULL OUTER reveals data quality issues

4. For production:
   - Monitor join performance
   - Consider query caching
   - Review join strategies periodically

# Subquery Analysis: Property Ratings and User Bookings

## Property Rating Analysis (Non-Correlated Subquery)

This query identifies high-quality properties by finding those with an average rating above 4.0. The non-correlated subquery first calculates average ratings for all properties before filtering in the outer query.

**Key Characteristics:**

- Independent subquery executes first  
- Returns all properties meeting the quality threshold  
- Efficient for filtering based on aggregate calculations  
- Returns properties even without user details  

**Performance Consideration:**  
The subquery's `GROUP BY` operation benefits from an index on the `property_id` and `rating` columns in the reviews table.

---

## Frequent Bookers Identification (Correlated Subquery)

This analysis pinpoints active users who have made more than 3 bookings using a correlated subquery that:

- Checks each user against their booking count  
- Executes once for every user record  
- Maintains relationship between outer and inner queries  

**Key Characteristics:**

- Subquery references outer query's `user_id`  
- Executes row-by-row  
- Precisely targets users meeting the activity threshold  
- More resource-intensive but highly accurate  

**Performance Consideration:**  
This benefits significantly from an index on the `user_id` column in the bookings table.

---

## Comparative Insights

| Aspect                | Non-Correlated Subquery | Correlated Subquery |
|-----------------------|-------------------------|---------------------|
| Execution Pattern     | Runs once independently | Runs per outer row  |
| Best Use Case         | Aggregate filtering     | Row-specific checks |
| Performance Profile   | Generally faster        | Potentially slower  |
| Result Completeness   | May miss some relations | Precise relations   |

---

These subquery techniques provide complementary approaches for different analytical requirements in database queries.


# Aggregations and Window Functions Analysis

## Bookings Count per User Analysis

This query calculates the total number of bookings made by each user. It:

- Combines user and booking data  
- Counts bookings per user while including users with zero bookings  
- Presents results in descending order by booking count  
- Shows user details alongside their booking activity  

---

## Property Ranking by Popularity

This analysis ranks properties based on booking frequency using three different window functions:

### Ranking Methods Compared

1. **Standard Rank**  
   - Shows competitive position with gaps for ties  
   - Example: 1st, 2nd, 2nd, 4th place  

2. **Dense Rank**  
   - Provides consecutive rankings without gaps  
   - Example: 1st, 2nd, 2nd, 3rd place  

3. **Row Number**  
   - Assigns unique sequential positions  
   - Example: 1, 2, 3, 4  

The query also displays:

- Property identification details  
- Total booking counts  
- Geographic location information  

---

## Performance Optimization Notes

For optimal performance with these analytical queries:

- Essential indexes should be created on foreign key columns  
- Date-range filtering recommended for large datasets  
- Materialized views can be valuable for frequently accessed reports  

---

## Typical Output Structure

**User booking analysis shows:**

- User identification  
- Personal details  
- Total bookings count  

**Property ranking displays:**

- Property identification  
- Name and location  
- Booking volume  
- Calculated rank positions  

---

These analyses provide valuable insights into customer behavior and property performance, enabling data-driven business decisions.
