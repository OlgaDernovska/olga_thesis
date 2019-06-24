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
      type: string
      primary_key: yes
      hidden:  yes
      sql: Concat(cast(${date} as string), ${station}) ;;
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

    dimension: temperature_bucket {
      case: {
        when: {
          sql: ${daily_max_temperature} < 0 ;;
          label: "Below zero"
        }
        when: {
          sql: ${daily_max_temperature} >= 0 and ${daily_max_temperature} < 10 ;;
          label: "0 to 10 degrees"
        }
        when: {
          sql: ${daily_max_temperature} >= 10 and ${daily_max_temperature} < 20 ;;
          label: "10 to 20 degrees"
        }
        when: {
          sql: ${daily_max_temperature} >= 20 ;;
          label: "Over 20 degrees"
        }
        else: "Unknown"
      }
    }

    dimension: gdd {
      type:  number
      description: "Growing degree days for one day"
      sql: greatest((${daily_max_temperature}+${daily_min_temperature})/2-10, 0) ;;
      value_format_name: decimal_1
    }

    measure: gdd_measure {
      description: "Growing degree days sum"
      type: sum
      sql: ${daily_weather.gdd};;
      value_format_name: decimal_1
    }

    set: detail {
      fields: [hourly_irish_weather.observed_date, hourly_irish_weather.station, hourly_irish_weather.max_temperature, hourly_irish_weather.min_temperature]
    }

  }
