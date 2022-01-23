-- Medium

-- The total score of a hacker is the sum of their maximum scores for all of the challenges.
-- Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score.
-- If more than one hacker achieved the same total score, then sort the result by ascending hacker_id.
-- Exclude all hackers with a total score of 0 from your result.
-- https://www.hackerrank.com/challenges/contest-leaderboard/

SELECT total_score_hacker.hacker_id, name, total_score
FROM Hackers
INNER JOIN (
    SELECT hacker_id, SUM(max_score) AS total_score
    FROM (
        SELECT hacker_id, challenge_id, MAX(score) AS max_score
        FROM Submissions
        GROUP BY hacker_id, challenge_id
    ) AS max_score_hacker_challenge
    GROUP BY hacker_id
    HAVING total_score > 0
) AS total_score_hacker
ON Hackers.hacker_id = total_score_hacker.hacker_id
ORDER BY total_score DESC, total_score_hacker.hacker_id