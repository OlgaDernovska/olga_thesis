view: existing_observations_by_station {
  derived_table: {
    sql: SELECT station,
        min(hourly_irish_weather_observed_year) as start_time,
        max(hourly_irish_weather_observed_year) as end_time

      FROM
        (SELECT
          hourly_irish_weather.station  AS station,
          EXTRACT(YEAR FROM hourly_irish_weather.date ) AS hourly_irish_weather_observed_year,
          MAX(hourly_irish_weather.temp ) AS hourly_irish_weather_max_temperature
        FROM olga_thesis.hourly_irish_weather  AS hourly_irish_weather

        GROUP BY 1,2
        ORDER BY 1 )

        WHERE hourly_irish_weather_max_temperature is not null
        group by 1
        order by 1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: station {
    primary_key: yes
    type: string
    sql: ${TABLE}.station ;;
  }

  dimension: start_time {
    type: number
    sql: ${TABLE}.start_time ;;
    value_format_name: id
  }

  dimension: end_time {
    type: number
    sql: ${TABLE}.end_time ;;
    value_format_name: id
  }

  set: detail {
    fields: [station, start_time, end_time]
  }
}