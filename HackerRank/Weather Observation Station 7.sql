-- Easy

-- Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
-- https://www.hackerrank.com/challenges/weather-observation-station-6/problem?h_r=next-challenge&h_v=zen

SELECT DISTINCT CITY
FROM STATION
WHERE CITY LIKE 'a%'
OR CITY LIKE 'e%'
OR CITY LIKE 'i%'
OR CITY LIKE 'o%'
OR CITY LIKE 'u%'