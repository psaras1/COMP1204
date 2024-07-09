-- The worldwide total number of cases and deaths \
-- (with total cases and total deaths as columns)

SELECT
    SUM(cases) AS total_cases,
    SUM(deaths) AS total_deaths
FROM covidStats;