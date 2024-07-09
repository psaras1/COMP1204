--ex12.sql

--Populate dates table
INSERT INTO dates SELECT DISTINCT NULL,dateRep,day,month,year FROM dataset;
--Populate countries table
INSERT INTO countries
SELECT DISTINCT NULL,countriesAndTerritories,geoId,countryterritoryCode,popData2020,continentExp
FROM dataset;
--Populate covidStats table
-- Populate covidStats table, using COALESCE to handle NULL deaths
INSERT INTO covidStats (date_id, country_id, cases, deaths)
SELECT
    dates.id,
    countries.id,
    dataset.cases,
    CASE WHEN dataset.deaths = ''
        THEN 0
        ELSE CAST(dataset.deaths AS INTEGER)
        END AS deaths
FROM dataset
    INNER JOIN dates
        ON dates.dateRep = dataset.dateRep
    INNER JOIN countries
        ON countries.countriesAndTerritories = dataset.countriesAndTerritories;