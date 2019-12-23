-- Easy

-- There is a table courses with columns: student and class
--
-- Please list out all classes which have more than or equal to 5 students.
--
-- For example, the table:
--
--+---------+------------+
--| student | class      |
--+---------+------------+
--| A       | Math       |
--| B       | English    |
--| C       | Math       |
--| D       | Biology    |
--| E       | Math       |
--| F       | Computer   |
--| G       | Math       |
--| H       | Math       |
--| I       | Math       |
--+---------+------------+
--
-- Should output:
--
--+---------+
--| class   |
--+---------+
--| Math    |
--+---------+
--
-- Note:
-- The students should not be counted duplicate in each course.

SELECT gt_5students_cls.class
FROM (
    SELECT class, COUNT(DISTINCT student) AS nb_students
    FROM courses
    GROUP BY class
    HAVING nb_students >= 5
) AS gt_5students_cls
