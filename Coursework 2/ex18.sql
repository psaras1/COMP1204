--A descending list of the the top 10 countries by name, by percentage (to 2DP)
-- total deaths out of total cases in that country
-- (with country name and % deaths of country cases as columns)

SELECT countriesAndTerritories AS countryName,
       ROUND((CAST(SUM(deaths) AS REAL) / NULLIF(SUM(cases), 0)) * 100, 2)
           AS percentDeaths
FROM covidStats
    INNER JOIN countries ON country_id = countries.id
GROUP BY countryName
ORDER BY percentDeaths DESC
LIMIT 10;
