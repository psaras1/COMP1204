--The total number of cases and deaths as a percentage (to 2DP) of the population,
-- for each country (with country name, % cases of population, % deaths of population as columns)

SELECT
    countriesAndTerritories AS countryName,
    ROUND(SUM((cases * 100.0) / popData2020), 2)
        AS percent_cases_of_population,
    ROUND(SUM((deaths * 100.0) / popData2020), 2)
        AS percent_deaths_of_population
FROM
    covidStats
INNER JOIN
    countries ON country_id = countries.id
GROUP BY
    country_id;

