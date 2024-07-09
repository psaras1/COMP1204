-- The date against a cumulative running total of the number of deaths by day and cases by day for the united kingdom
-- (with date, cumulative UK deaths and cumulative UK cases as columns)

-- ex18.sql

-- Calculate the cumulative running total of deaths and cases by day for the United Kingdom
SELECT dateRep AS date,
       SUM(deaths) OVER (ROWS UNBOUNDED PRECEDING) AS cumulativeDeaths_UK,
       SUM(cases) OVER (ROWS UNBOUNDED PRECEDING) AS cumulativeCases_UK
FROM covidStats
    INNER JOIN countries ON country_id = countries.id
    INNER JOIN dates ON date_id = dates.id
WHERE countriesAndTerritories = 'Cyprus'
ORDER BY dateRep;



