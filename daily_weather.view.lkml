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
      datagroup_trigger: default_datagroup
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
      link: {
        label: "Where is this station?"
        url: "/explore/olga_thesis/hourly_irish_weather?fields=hourly_irish_weather.station,hourly_irish_weather.station_location,hourly_irish_weather.county&f[hourly_irish_weather.station]={{ value }}&sorts=hourly_irish_weather.station&limit=1&column_limit=50&query_timezone=America%2FLos_Angeles&vis=%7B%22map_plot_mode%22%3A%22points%22%2C%22heatmap_gridlines%22%3Afalse%2C%22heatmap_gridlines_empty%22%3Afalse%2C%22heatmap_opacity%22%3A0.5%2C%22show_region_field%22%3Atrue%2C%22draw_map_labels_above_data%22%3Atrue%2C%22map_tile_provider%22%3A%22outdoors%22%2C%22map_position%22%3A%22custom%22%2C%22map_latitude%22%3A54.181726602390945%2C%22map_longitude%22%3A-8.470458984375002%2C%22map_zoom%22%3A6%2C%22map_scale_indicator%22%3A%22off%22%2C%22map_pannable%22%3Afalse%2C%22map_zoomable%22%3Afalse%2C%22map_marker_type%22%3A%22icon%22%2C%22map_marker_icon_name%22%3A%22default%22%2C%22map_marker_radius_mode%22%3A%22proportional_value%22%2C%22map_marker_units%22%3A%22meters%22%2C%22map_marker_proportional_scale_type%22%3A%22linear%22%2C%22map_marker_color_mode%22%3A%22fixed%22%2C%22show_view_names%22%3Afalse%2C%22show_legend%22%3Atrue%2C%22quantize_map_value_colors%22%3Afalse%2C%22reverse_map_value_colors%22%3Afalse%2C%22type%22%3A%22looker_map%22%2C%22series_types%22%3A%7B%7D%7D"
        }
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

    measure: gdd_total {
      description: "Growing degree days sum"
      type: sum
      sql: ${daily_weather.gdd};;
      value_format_name: decimal_1
    }

    set: detail {
      fields: [hourly_irish_weather.observed_date, hourly_irish_weather.station, hourly_irish_weather.max_temperature, hourly_irish_weather.min_temperature]
    }

  }
