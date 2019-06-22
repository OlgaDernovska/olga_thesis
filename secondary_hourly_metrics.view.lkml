view: secondary_hourly_metrics {
  dimension: date {
    type: date
    sql: ${TABLE}.hourly_irish_weather_observed_date ;;
  }

  dimension: station {
    type: string
    sql: ${TABLE}.hourly_irish_weather_station ;;
  }

  dimension: gdd {
    type:  number
    sql:  ;;
  }
  dimension: daily_max_temperature {
    type: number
    sql: ${TABLE}.hourly_irish_weather_max_temperature ;;
  }

  dimension: daily_min_temperature {
    type: number
    sql: ${TABLE}.hourly_irish_weather_min_temperature ;;
  }
}
