view: hourly_irish_weather {
  sql_table_name: olga_thesis.hourly_irish_weather ;;

  dimension: cloud_amount {
    description: "Cloud amount, okta (1/8 of the sky)"
    type: number
    view_label: "Secondary Hourly Metrics"
    sql: ${TABLE}.clamt ;;
  }

  dimension: cloud_ceiling_height {
    description: "Cloud ceiling height, 100s of feet (if no clouds, value is 999)"
    type: number
    view_label: "Secondary Hourly Metrics"
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

  dimension: is_warm_period {
    type: yesno
    sql: ${observed_month_num} in (4, 5, 6, 7, 8, 9, 10) ;;
  }

  dimension: dew_point {
    description: "Dew Point Air Temperature, °C"
    type: number
    view_label: "Secondary Hourly Metrics"
    sql: ${TABLE}.dewpt ;;
  }

  dimension: id {
    type: number
    hidden: yes
    sql: ${TABLE}.int64_field_0 ;;
  }

  dimension: latitude {
    type: number
    hidden: yes
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    hidden: yes
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
    view_label: "Secondary Hourly Metrics"
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
    view_label: "Secondary Hourly Metrics"
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
    view_label: "Secondary Hourly Metrics"
    sql: ${TABLE}.vappr ;;
  }

  dimension: visibility {
    description: "Visibility, m"
    type: number
    view_label: "Secondary Hourly Metrics"
    sql: ${TABLE}.vis ;;
  }

  dimension: w_code {
    description: "Synop code past weather"
    type: number
    view_label: "Secondary Hourly Metrics"
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
    view_label: "Secondary Hourly Metrics"
    sql: ${TABLE}.wetb ;;
  }

  dimension: ww_code {
    description: "Synop code present weather"
    type: number
    view_label: "Secondary Hourly Metrics"
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
    sql: ${daily_weather.daily_max_temperature} ;;
    value_format_name: decimal_1
  }

  measure: gdd {
    description: "Growing degree days sum"
    type: sum
    sql: ${daily_weather.gdd};;
    value_format_name: decimal_1
  }


#   {% condition warm_weather_period_filter %} (EXTRACT(MONTH FROM hourly_irish_weather.date ) >= 4 AND EXTRACT(MONTH FROM hourly_irish_weather.date ) <= 10) {% endcondition %}


}
