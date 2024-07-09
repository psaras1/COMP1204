--The number of cases by date, in increasing date order,
--for the United Kingdom
-- (with the date reported and number of cases as columns)

SELECT dateRep,cases
FROM covidStats
    INNER JOIN countries ON country_id=countries.id
    INNER JOIN dates ON date_id=dates.id
WHERE countries.countriesAndTerritories= 'United_Kingdom'
ORDER BY year,month,day;
