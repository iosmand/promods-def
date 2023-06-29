#!/bin/bash

# Set the path to the fuel data file
fuel_data_file="fuel.csv"
sed -i "s/Czech Republic/czech/" "fuel.csv"
sed -i "s/Bosnia & Herz./bosnia/" "fuel.csv"
sed -i "s/Liechtenstein/liecht/" "fuel.csv"
sed -i "s/N. Macedonia/macedonia/" "fuel.csv"
# Loop through each country data file
for country_file in *.sui; do
    # Extract the country name from the file name
    country=$(echo "$country_file" | cut -d. -f1)

    # Check if the country exists in the fuel data file (case-insensitive)
    fuel_price=$(grep -i "^$country," "$fuel_data_file" | cut -d, -f2)

    # Check if the fuel price is empty
    if [[ -n $fuel_price ]]; then
        # Update the fuel price in the country data file
        sed -i "s/fuel_price: .*/fuel_price: $fuel_price/" "$country_file"
        echo "Fuel price updated for $country."
    else
        echo "No fuel data found for $country. Skipping update."
    fi
done

echo "All fuel prices updated successfully."
