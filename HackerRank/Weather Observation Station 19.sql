-- Medium

-- Consider P1(a,c) and P2(b,d) to be two points on a 2D plane where (a,b) are the respective minimum and maximum values of Northern Latitude (LAT_N) and
-- (c,d) are the respective minimum and maximum values of Western Longitude (LONG_W) in STATION.
-- Query the Euclidean Distance between points
-- P1 and P2 and format your answer to display decimal digits.
-- https://www.hackerrank.com/challenges/weather-observation-station-19/

SELECT ROUND(
    SQRT(
        POWER(b-a, 2) + POWER(d-c, 2)
    ), 4)
FROM (
    SELECT MIN(LAT_N) AS a, MAX(LAT_N) AS b, MIN(LONG_W) AS c, MAX(LONG_W) AS d
    FROM STATION
) AS abcd