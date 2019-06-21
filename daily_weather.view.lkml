view: daily_weather {

    derived_table: {
      sql: SELECT
        CAST(hourly_irish_weather.date  AS DATE) AS hourly_irish_weather_observed_date,
        hourly_irish_weather.station  AS hourly_irish_weather_station,
        MAX(hourly_irish_weather.temp ) AS hourly_irish_weather_max_temperature,
        MIN(hourly_irish_weather.temp ) AS hourly_irish_weather_min_temperature
      FROM olga_thesis.hourly_irish_weather  AS hourly_irish_weather

      GROUP BY 1, 2
      ORDER BY 1 DESC
       ;;
    }

    dimension: prim_key {
      type: number
      primary_key: yes
      hidden:  yes
      sql: Concat(${date}, ${station}) ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: date {
      type: date
      sql: ${TABLE}.hourly_irish_weather_observed_date ;;
    }

    dimension: station {
      type: string
      sql: ${TABLE}.hourly_irish_weather_station ;;
    }

    dimension: daily_max_temperature {
      type: number
      sql: ${TABLE}.hourly_irish_weather_max_temperature ;;
    }

    dimension: daily_min_temperature {
      type: number
      sql: ${TABLE}.hourly_irish_weather_min_temperature ;;
    }

    set: detail {
      fields: [hourly_irish_weather.observed_date, hourly_irish_weather.station, hourly_irish_weather.max_temperature, hourly_irish_weather.min_temperature]
    }

  }
