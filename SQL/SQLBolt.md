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