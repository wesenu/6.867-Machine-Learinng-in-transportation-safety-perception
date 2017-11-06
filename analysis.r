install.packages("NISTunits", dependencies = TRUE);
library(NISTunits);

# loading file
safety_data = read.csv("safety_data.csv");

# Based on
# https://stackoverflow.com/a/365853/3128369
haversine <- function(data, lat1, lon1, lat2, lon2){
  earthRadiusKm = 6371;
  
  dLat = NISTdegTOradian(data[[lat2]]-data[[lat1]]);
  dLon = NISTdegTOradian(data[[lon2]]-data[[lon1]]);
  
  lat1 = NISTdegTOradian(data[[lat1]]);
  lat2 = NISTdegTOradian(data[[lat2]]);
  
  a = sin(dLat/2) * sin(dLat/2) +
    sin(dLon/2) * sin(dLon/2) * cos(lat1) * cos(lat2); 
  c = 2 * atan2(sqrt(a), sqrt(1-a)); 
  distance = earthRadiusKm * c;
  return (distance);
}

safety_data[["haversine"]] = haversine(safety_data, "cetram_lat", "cetram_long", "latitude", "longitude")

# Making a basic plot of some potentially relevant variables

plot_data <- data.frame(
  point_security = safety_data[["pointsecurity"]],
  haversine = safety_data[["haversine"]],
  gender = safety_data[["gender"]],
  age = safety_data[["age"]],
  companions = safety_data[["companions"]],  
  education = safety_data[["educational_attainment"]]
  
                        );
plot(plot_data)


