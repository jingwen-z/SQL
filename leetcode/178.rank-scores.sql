-- Medium

-- Write a SQL query to rank scores. If there is a tie between two scores, both
-- should have the same ranking. Note that after a tie, the next ranking number
-- should be the next consecutive integer value. In other words, there should be
-- no "holes" between ranks.
--
--+----+-------+
--| Id | Score |
--+----+-------+
--| 1  | 3.50  |
--| 2  | 3.65  |
--| 3  | 4.00  |
--| 4  | 3.85  |
--| 5  | 4.00  |
--| 6  | 3.65  |
--+----+-------+
-- For example, given the above Scores table, your query should generate the
-- following report (order by highest score):
--
--+-------+------+
--| Score | Rank |
--+-------+------+
--| 4.00  | 1    |
--| 4.00  | 1    |
--| 3.85  | 2    |
--| 3.65  | 3    |
--| 3.65  | 3    |
--| 3.50  | 4    |
--+-------+------+

SELECT full_records.Score
    , COUNT(DISTINCT dist_records.Score) AS Rank
FROM Scores AS full_records, (
    SELECT DISTINCT Score
    FROM Scores
) AS dist_records
WHERE dist_records.Score >= full_records.Score
GROUP BY full_records.Score, full_records.Id
ORDER BY full_records.Score DESC