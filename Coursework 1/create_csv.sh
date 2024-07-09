#!/bin/bash
#Script that extracts information from a KML file and generates a CSV file
    
#Checks if 2 arguements were passed, if not exits
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input.kml> <output.csv>"
    exit 1
fi
    
#Assigns the 2 arguements to input_file and output_file respectively
input_file="$1"
output_file="$2"
    
#Adds field headers to the output CSV file
echo "Timestamp,Latitude,Longitude,MinSeaLevelPressure,MaxIntensity" > "$output_file"

#Awk extracts all measurements enclosed in specified tags and adds units of measurement accordingly    
#At the end, if all required fields have values, they get appended to the specified output csv file
awk -F '[<>]' '
    /<dtg>/ { timestamp = $3 } 
    /<lat>/ { latitude = $3 " N" } 
    /<lon>/ { longitude = $3 " W" } 
    /<minSeaLevelPres>/ {min_pressure = $3 " mb" } 
    /<intensity>/ { max_intensity = $3 " knots" } 
    /<\/Placemark>/ {
    
    if (timestamp && latitude && longitude && min_pressure && max_intensity) {
        print timestamp "," latitude "," longitude "," min_pressure "," max_intensity
    }
        timestamp = ""
        latitude = ""
        longitude = ""
        min_pressure = ""
        max_intensity = ""
    }
    

' "$input_file" >> "$output_file"

#Prints confirmation uppon succesful creation of the csv file
echo "CSV file generated: $output_file"
