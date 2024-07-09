-- ex11.sql


--Create countries table
CREATE TABLE IF NOT EXISTS countries (
	id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	countriesAndTerritories TEXT NOT NULL UNIQUE,
	geoId TEXT UNIQUE,
	countryterritoryCode TEXT UNIQUE,
	popData2020 INTEGER NOT NULL,
	continentExp TEXT NOT NULL
);

--Create table dates
CREATE TABLE IF NOT EXISTS dates (
	id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
	dateRep TEXT NOT NULL UNIQUE,
	day INTEGER NOT NULL,
	month INTEGER NOT NULL,
	year INTEGER NOT NULL
);

--Create covidStats table
CREATE TABLE IF NOT EXISTS covidStats (
	date_id INTEGER,
	country_id INTEGER,
	cases INTEGER,
	deaths INTEGER,
	PRIMARY KEY (date_id, country_id),
	FOREIGN KEY (date_id) REFERENCES dates(id)
		ON DELETE CASCADE
		ON UPDATE NO ACTION,
	FOREIGN KEY (country_id) REFERENCES countries(id)
		ON DELETE CASCADE
		ON UPDATE NO ACTION
);