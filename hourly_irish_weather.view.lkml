view: hourly_irish_weather {
  sql_table_name: olga_thesis.hourly_irish_weather ;;

  dimension: cloud_amount {
    description: "Cloud amount, okta (1/8 of the sky)"
    type: number
    sql: ${TABLE}.clamt ;;
  }

  dimension: cloud_ceiling_height {
    description: "Cloud ceiling height, 100s of feet (if no clouds, value is 999)"
    type: number
    sql: ${TABLE}.clht ;;
  }

  dimension: county {
    type: string
    sql: ${TABLE}.county ;;
  }

  dimension_group: observed {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      day_of_week,
      hour_of_day,
      month,
      month_num,
      month_name,
      quarter,
      year
    ]
    sql: ${TABLE}.date ;;
  }

  dimension: dew_point {
    description: "Dew Point Air Temperature, °C"
    type: number
    sql: ${TABLE}.dewpt ;;
  }

  dimension: id {
    type: number
    sql: ${TABLE}.int64_field_0 ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: station_location {
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }

  dimension: sea_pressure {
    description: "Mean sea-level pressure, hPa"
    type: number
    sql: ${TABLE}.msl ;;
  }

  dimension: rain {
    description: "Precipitation amount, mm"
    type: number
    sql: ${TABLE}.rain ;;
  }

  dimension: relative_humidity {
    description: "Relative humidity, %"
    type: number
    sql: ${TABLE}.rhum ;;
  }

  dimension: station {
    description: "Name of the weather station"
    type: string
    sql: ${TABLE}.station ;;
  }

  dimension: sun {
    description: "Sunshine duration, hours"
    type: number
    sql: ${TABLE}.sun ;;
  }

  dimension: temperature {
    description: "Air temperature, °C"
    type: number
    sql: ${TABLE}.temp ;;
  }

  dimension: vapour_pressure {
    description: "Vapour Pressure, hPa"
    type: number
    sql: ${TABLE}.vappr ;;
  }

  dimension: visibility {
    description: "Visibility, m"
    type: number
    sql: ${TABLE}.vis ;;
  }

  dimension: w_code {
    description: "Synop code past weather"
    type: number
    sql: ${TABLE}.w ;;
  }

  dimension: wind_direction {
    description: "Predominant hourly wind direction, degrees"
    type: number
    sql: ${TABLE}.wddir ;;
  }

  dimension: wind_speed {
    description: "Mean hourly wind speed, kt"
    type: number
    sql: ${TABLE}.wdsp ;;
  }

  dimension: wet_bulb {
    description: "Wet bulb air temperature, °C"
    type: number
    sql: ${TABLE}.wetb ;;
  }

  dimension: ww_code {
    description: "Synop code present weather"
    type: number
    sql: ${TABLE}.ww ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: max_temperature {
    type: max
    sql: ${temperature} ;;
    drill_fields: [observed_time, station, county, temperature]
  }

  measure: min_temperature {
    type:  min
    sql: ${temperature} ;;
    drill_fields: [observed_time, station, county, temperature]
  }

  measure: average_temperature {
    type:  average
    sql: ${temperature} ;;
    drill_fields: [observed_time, station, county, temperature]
    value_format_name: decimal_1
  }

  measure: total_sun {
    description: "Total sunshine duration, hours"
    type:  sum
    sql:  ${sun} ;;
    drill_fields: [observed_time, station, county, sun]
    value_format_name: decimal_1
  }

  measure: total_rain {
    description: "Total percipitation amount, mm"
    type:  sum
    sql:  ${rain} ;;
    drill_fields: [observed_time, station, county, rain]
    value_format_name: decimal_1
  }

  measure: avg_max_temp {
    description: "Average of daily maximum temperatures"
    type:  average
    sql: ${warm_period_weather.daily_max_temperature} ;;
    value_format_name: decimal_1
  }

  measure: gdd {
    description: "Growing degree days"
    type: sum
    sql: GREATEST(((${warm_period_weather.daily_max_temperature} + ${warm_period_weather.daily_min_temperature}) / 2 - 10), 0) ;;
    value_format_name: decimal_1
  }

  #measure: gdd {
  #  type:  sum
  #  sql:  (warm_period_weather.daily_max_temperature + warm_period_weather.daily_min_temperature) / 2 - 10 ;;
  #  sql: (${daily_max_temperature} + ${daily_min_temperature}) / 2 - 10 ;;
  #}

}
