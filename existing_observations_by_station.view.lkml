view: existing_observations_by_station {
  derived_table: {
    sql: SELECT station,
        min(hourly_irish_weather_observed_year) as start_time,
        max(hourly_irish_weather_observed_year) as end_time

      FROM
        (SELECT
          hourly_irish_weather.station  AS station,
          EXTRACT(YEAR FROM hourly_irish_weather.date ) AS hourly_irish_weather_observed_year,
          avg({% parameter parameter_field %}) AS hourly_irish_weather_max_temperature
        FROM olga_thesis.hourly_irish_weather  AS hourly_irish_weather

        GROUP BY 1,2
        ORDER BY 1 )

      WHERE hourly_irish_weather_max_temperature is not null
      group by 1
      order by 1
      ;;
    datagroup_trigger: default_datagroup

  }

  parameter: parameter_field {
    type: unquoted
    allowed_value: {
      label: "Temperature"
      value: "hourly_irish_weather.temp"
    }
    allowed_value: {
      label: "Rain"
      value: "hourly_irish_weather.rain"
    }
    allowed_value: {
      label: "Sun"
      value: "hourly_irish_weather.sun"
    }
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: station {
    primary_key: yes
    type: string
    sql: ${TABLE}.station ;;
    link: {
      label: "Where is this station?"
      url: "/explore/olga_thesis/hourly_irish_weather?fields=hourly_irish_weather.station,hourly_irish_weather.station_location,hourly_irish_weather.county&f[hourly_irish_weather.station]={{ value }}&sorts=hourly_irish_weather.station&limit=1&column_limit=50&query_timezone=America%2FLos_Angeles&vis=%7B%22map_plot_mode%22%3A%22points%22%2C%22heatmap_gridlines%22%3Afalse%2C%22heatmap_gridlines_empty%22%3Afalse%2C%22heatmap_opacity%22%3A0.5%2C%22show_region_field%22%3Atrue%2C%22draw_map_labels_above_data%22%3Atrue%2C%22map_tile_provider%22%3A%22outdoors%22%2C%22map_position%22%3A%22custom%22%2C%22map_latitude%22%3A54.181726602390945%2C%22map_longitude%22%3A-8.470458984375002%2C%22map_zoom%22%3A6%2C%22map_scale_indicator%22%3A%22off%22%2C%22map_pannable%22%3Afalse%2C%22map_zoomable%22%3Afalse%2C%22map_marker_type%22%3A%22icon%22%2C%22map_marker_icon_name%22%3A%22default%22%2C%22map_marker_radius_mode%22%3A%22proportional_value%22%2C%22map_marker_units%22%3A%22meters%22%2C%22map_marker_proportional_scale_type%22%3A%22linear%22%2C%22map_marker_color_mode%22%3A%22fixed%22%2C%22show_view_names%22%3Afalse%2C%22show_legend%22%3Atrue%2C%22quantize_map_value_colors%22%3Afalse%2C%22reverse_map_value_colors%22%3Afalse%2C%22type%22%3A%22looker_map%22%2C%22series_types%22%3A%7B%7D%7D"

#       url: "/looks/1361?f[hourly_irish_weather.station]={{ value }} "
    }
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
