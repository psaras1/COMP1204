--The number of cases and deaths by date,
-- in increasing date order, for each country
-- (with country name, date, number of cases and number of deaths as columns)


SELECT dateRep AS date,countriesAndTerritories AS countryName,cases,deaths
FROM covidStats
    INNER JOIN countries ON country_id=countries.id
    INNER JOIN dates ON date_id=dates.id
ORDER BY year,month,day, countryName;