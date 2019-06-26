connection: "lookerdata_publicdata_standard_sql"

# include all the views
include: "*.view"

datagroup: default_datagroup {
  sql_trigger: SELECT MAX(id) FROM hourly_irish_weather;;
  max_cache_age: "240 hours"
}

explore: hourly_irish_weather {
  join: daily_weather {
    type: left_outer
    sql_on: ${hourly_irish_weather.observed_date} = ${daily_weather.date} and ${hourly_irish_weather.station} = ${daily_weather.station};;
    relationship: many_to_one
  }
  join: existing_observations_by_station {
    type: left_outer
    sql_on:  ${hourly_irish_weather.station} = ${existing_observations_by_station.station};;
    relationship: many_to_one
  }
}


explore: seven_years {}
