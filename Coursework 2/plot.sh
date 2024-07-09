#!/bin/bash

# Fetch the top 10 countries' IDs with the most deaths
IDS=$(sqlite3 coronavirus.db "SELECT country_id
                              FROM covidStats
                                  INNER JOIN countries ON country_id=countries.id
                              GROUP BY country_id
                              ORDER BY SUM(deaths) DESC
                              LIMIT 10;" | tr '\n' ' ')

# Fetch the names of the top 10 countries
NAMES=$(sqlite3 coronavirus.db "SELECT countriesAndTerritories
                                FROM covidStats
                                    INNER JOIN countries ON country_id=countries.id
                                GROUP BY country_id
                                ORDER BY SUM(deaths) DESC
                                LIMIT 10;" | tr '\n' ' ' |  tr '_' '-')

# Use gnuplot to generate the plot
gnuplot -persist <<-EOFMarker
  # Set plot settings
  set key top left autotitle columnheader
  set key reverse Left
  set title 'Cumulative COVID-19 Deaths Top 10'
  set ylabel 'Deaths'
  set xlabel 'Date'
  set grid
  set xdata time
  set datafile separator "|"
  set format x '%d/%m/%Y'
  set timefmt "%d/%m/%Y"
  set xtics mirror rotate by -45
  set rmargin at screen 0.94
  set term png
  set terminal png size 1024,768
  set output "graph.png"

  # Set variables for country names and IDs
  titles = "$NAMES"
  ids = "$IDS"

  # Define function to retrieve country name from the titles variable
  ttl(n) = sprintf("%s", word(titles, n))

  # Plot data for each of the top 10 countries
  plot for [i=1:10] \
  '< sqlite3 coronavirus.db "SELECT dateRep,SUM(deaths) OVER (ROWS UNBOUNDED PRECEDING) FROM covidStats INNER JOIN countries ON country_id=countries.id INNER JOIN dates ON date_id=dates.id WHERE country_id='.word(ids, i).' ORDER BY year,month,day;"'\
   using 1:2 \
   title ttl(i) \
   w \
   l \
   lw 2
EOFMarker
