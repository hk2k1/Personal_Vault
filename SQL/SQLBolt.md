### Normal and Joins

```sql
SELECT column, another_column, …
FROM mytable
INNER/LEFT/RIGHT/FULL JOIN another_table
ON mytable.id = another_table.matching_id
WHERE _condition(s)_ LIKE "% or _" (NOT) BETWEEN/IN/IS NULL
ORDER BY column, … ASC/DESC
LIMIT num_limit OFFSET num_offset;
```

### Aggregate
| **COUNT(*****)**, **COUNT(**column**)** | A common function used to counts the number of rows in the group if no column name is specified. Otherwise, count the number of rows in the group with non-NULL values in the specified column. |
| --------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **MIN(**column**)**                     | Finds the smallest numerical value in the specified column for all rows in the group.                                                                                                           |
| **MAX(**column**)**                     | Finds the largest numerical value in the specified column for all rows in the group.                                                                                                            |
| **AVG(**column)                         | Finds the average numerical value in the specified column for all rows in the group.                                                                                                            |
| **SUM(**column**)**                     | Finds the sum of all numerical values in the specified column for the rows in the group.                                                                                                        |
| LENGTH(column)                          | length                                                                                                                                                                                          |
| MOD(column,2)                           | modulus                                                                                                                                                                                         |
```sql
SELECT DISTINCT column, AGG_FUNC(_column_or_expression_), … FROM mytable
JOIN another_table
ON mytable.column = another_table.column
WHERE _constraint_expression_
GROUP BY column
HAVING _constraint_expression_
ORDER BY _column_ ASC/DESC
LIMIT _count_ OFFSET _COUNT_;
```

### Insert, Update Delete
```sql
INSERT INTO mytable 
VALUES (value_or_expr, another_value_or_expr, …), (value_or_expr_2, another_value_or_expr_2, …), …;
```

```sql
UPDATE mytable
SET column = value_or_expr, 
    other_column = another_value_or_expr, 
    …
WHERE condition;
```

```sql
DELETE FROM mytable
WHERE condition;
```

### Create table
```mysql
CREATE TABLE IF NOT EXISTS mytable (
    column DataType TableConstraint DEFAULT default_value,
    another_column DataType TableConstraint DEFAULT default_value,
    …
);
```

### Altering table
```mysql
ALTER TABLE mytable
ADD column DataType OptionalTableConstraint 
    DEFAULT default_value;
```

### Drop Table
```mysql
DROP TABLE IF EXISTS mytable;
```

![[Screenshot 2024-05-26 at 3.10.11 AM.png]]


---

### Subqueries
```sql
SELECT *
FROM employees
WHERE salary > 
   (SELECT AVG(revenue_generated)
    FROM employees AS dept_employees
    WHERE dept_employees.department = employees.department);
```

```sql
SELECT *, …
FROM mytable
WHERE column
    IN/NOT IN (SELECT another_column
               FROM another_table);
```

Hard Examples
```sql
SELECT 
    MONTH(record_date) AS month,
    MAX(CASE WHEN data_type = 'max' THEN data_value ELSE NULL END) AS max,
    MIN(CASE WHEN data_type = 'min' THEN data_value ELSE NULL END) AS min,
    ROUND(AVG(CASE WHEN data_type = 'avg' THEN data_value ELSE NULL END)) AS avg
FROM 
    temperature_records
GROUP BY 
    MONTH(record_date)
ORDER BY 
    month;
```

Union Two Queries
```mysql
WITH Shortest AS (
    SELECT CITY, LENGTH(CITY) AS LEN
    FROM STATION
    ORDER BY LEN ASC, CITY ASC
    FETCH FIRST 1 ROW ONLY
),
Longest AS (
    SELECT CITY, LENGTH(CITY) AS LEN
    FROM STATION
    ORDER BY LEN DESC, CITY ASC
    FETCH FIRST 1 ROW ONLY
)
SELECT * FROM Shortest
UNION
SELECT * FROM Longest;
```

```mysql
SELECT city
FROM station
WHERE city REGEXP '^[aeiouAEIOU]';

SELECT DISTINCT CITY
FROM STATION
WHERE SUBSTRING(CITY, 1,1) IN ('a', 'e', 'i', 'o', 'u')
ORDER BY CITY
```
---

## Time Complexity
- `O(1)`- Primary key
- `O(log n)` - Indexed Column
- `O(n)` - non-indexed
- `O(nlogn)` - ORDER BY or GROUP By
- `O(n^2)` or `O(n^3)` - JOINS
- `O(2^n)` - recursive query
- `O(n!)` - multiple tables

---
>[!tip] Resources
>- [Understanding Algorithmic Time Efficiency in SQL Queries | by Luke SJ Howard | Learning Data | Medium](https://medium.com/learning-data/understanding-algorithmic-time-efficiency-in-sql-queries-616176a85d02)
