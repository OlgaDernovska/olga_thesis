connection: "lookerdata_publicdata_standard_sql"

# include all the views
include: "*.view"

datagroup: olga_thesis_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "24 hours"
}

persist_with: olga_thesis_default_datagroup

explore: hourly_irish_weather {
  join: warm_period_weather {
    type: left_outer
    sql_on: (${hourly_irish_weather.observed_date} = ${warm_period_weather.date}) and (${hourly_irish_weather.station} = ${warm_period_weather.station});;
    relationship: many_to_one
  }
}

#explore: warm_period_weather{}

explore: seven_years {}
