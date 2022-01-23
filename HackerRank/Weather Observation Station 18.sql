-- Medium

-- Consider P1(a,b) and P2(c,d) to be two points on a 2D plane.
-- a happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
-- b happens to equal the minimum value in Western Longitude (LONG_W in STATION).
-- c happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
-- d happens to equal the maximum value in Western Longitude (LONG_W in STATION).
-- Query the Manhattan Distance between points P1 and P2 and round it to a scale of 4 decimal places.
-- https://www.hackerrank.com/challenges/weather-observation-station-18/problem?isFullScreen=true

SELECT ROUND(ABS(a-c) + ABS(b-d), 4)
FROM (
    SELECT MIN(LAT_N) AS a, MIN(LONG_W) AS b, MAX(LAT_N) AS c, MAX(LONG_W) AS d
    FROM STATION
) AS abcd