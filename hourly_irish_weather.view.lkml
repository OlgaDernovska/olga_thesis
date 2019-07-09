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

  dimension: county_layer {
    type: string
    sql: ${TABLE}.county ;;
    map_layer_name: county_layer
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
    link: {
      label: "Where is this station?"
      url: "/explore/olga_thesis/hourly_irish_weather?fields=hourly_irish_weather.station,hourly_irish_weather.station_location,hourly_irish_weather.county&f[hourly_irish_weather.station]={{ value }}&sorts=hourly_irish_weather.station&limit=1&column_limit=50&query_timezone=America%2FLos_Angeles&vis=%7B%22map_plot_mode%22%3A%22points%22%2C%22heatmap_gridlines%22%3Afalse%2C%22heatmap_gridlines_empty%22%3Afalse%2C%22heatmap_opacity%22%3A0.5%2C%22show_region_field%22%3Atrue%2C%22draw_map_labels_above_data%22%3Atrue%2C%22map_tile_provider%22%3A%22outdoors%22%2C%22map_position%22%3A%22custom%22%2C%22map_latitude%22%3A54.181726602390945%2C%22map_longitude%22%3A-8.470458984375002%2C%22map_zoom%22%3A6%2C%22map_scale_indicator%22%3A%22off%22%2C%22map_pannable%22%3Afalse%2C%22map_zoomable%22%3Afalse%2C%22map_marker_type%22%3A%22icon%22%2C%22map_marker_icon_name%22%3A%22default%22%2C%22map_marker_radius_mode%22%3A%22proportional_value%22%2C%22map_marker_units%22%3A%22meters%22%2C%22map_marker_proportional_scale_type%22%3A%22linear%22%2C%22map_marker_color_mode%22%3A%22fixed%22%2C%22show_view_names%22%3Afalse%2C%22show_legend%22%3Atrue%2C%22quantize_map_value_colors%22%3Afalse%2C%22reverse_map_value_colors%22%3Afalse%2C%22type%22%3A%22looker_map%22%2C%22series_types%22%3A%7B%7D%7D"
#       url: "/looks/1361?f[hourly_irish_weather.station]={{ value }} "
      }
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
#   measure: dynamic_arrow {
#     sql: 1 ;;
#   html:
#   {% if degree > 0 and degree < 90 %}
#   <img src="https://www.wpclipart.com/signs_symbol/arrows/arrows_color/arrow_outline_yellow_up.png" height={{ count._value }} width= {{ count._value }}  style="image-orientation: 90deg;"></img> ;;
#   ..
#   }

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

  measure: the_warmest_day {
    description: "The day with the max highest temperature"
    type: max
    sql: ${daily_weather.daily_max_temperature} ;;
    value_format_name: decimal_1
    drill_fields: [daily_weather.station, daily_weather.date]
  }

  measure: the_coldest_day {
    description: "The day with the min highest temperature"
    type: min
    sql: ${daily_weather.daily_max_temperature} ;;
    value_format_name: decimal_1
    drill_fields: [daily_weather.station, daily_weather.date]
  }

  measure: the_coldest_night{
    description: "The day with the lowest temperature"
    type: min
    sql: ${daily_weather.daily_min_temperature} ;;
    value_format_name: decimal_1
    drill_fields: [daily_weather.station, daily_weather.date]
  }

  dimension: weather_image {
    group_label: "Thesis dashboard"
    type: string
    sql: 1;;
    html: <img src="https://s3-us-east-2.amazonaws.com/s3.arts-inspiredlearning.org/wp-content/uploads/20190308110002/Weather-Banner.png" alt="Irish Weather" width="1680px"/> ;;
  }

  dimension: summer_weather_image {
    group_label: "Thesis dashboard"
    type: string
    sql: 1;;
    html: <img src="https://upload.wikimedia.org/wikipedia/commons/b/b7/Ireland_banner-Dunguaire_Castle_and_the_lake_in_summer.jpg" alt="Discovering Irish Weather" width="1680px"/> ;;
  }

  dimension: winery_image{
    group_label: "Thesis dashboard"
    type: string
    sql: 1;;
    html: <img src="https://png.pngtree.com/thumb_back/fw800/back_pic/04/28/59/07583e4230ac2da.jpg" alt="Winery in Ireland" width="1680px"/> ;;

  }

#     html: <a href="/looks/1364">One look</a>;;
#     html:<a href="/explore/olga_thesis/hourly_irish_weather?fields=hourly_irish_weather.the_warmest_day,hourly_irish_weather.the_coldest_day,hourly_irish_weather.the_coldest_night,st_patricks_day,hourly_irish_weather.station,hourly_irish_weather.county,hourly_irish_weather.observed_year&f[hourly_irish_weather.station]=PhoenixPark&f[hourly_irish_weather.observed_year]=2017&sorts=hourly_irish_weather.observed_year+desc&limit=500&column_limit=50&vis=%7B%22type%22%3A%22looker_single_record%22%2C%22series_types%22%3A%7B%7D%7D&filter_config=%7B%22hourly_irish_weather.station%22%3A%5B%7B%22type%22%3A%22%3D%22%2C%22values%22%3A%5B%7B%22constant%22%3A%22PhoenixPark%22%7D%2C%7B%7D%5D%2C%22id%22%3A1%2C%22error%22%3Afalse%7D%5D%2C%22hourly_irish_weather.observed_year%22%3A%5B%7B%22type%22%3A%22year%22%2C%22values%22%3A%5B%7B%22constant%22%3A%222017%22%2C%22unit%22%3A%22yr%22%7D%2C%7B%7D%5D%2C%22id%22%3A2%2C%22error%22%3Afalse%7D%5D%7D&dynamic_fields=%5B%7B%22measure%22%3A%22st_patricks_day%22%2C%22based_on%22%3A%22daily_weather.daily_max_temperature%22%2C%22type%22%3A%22average%22%2C%22label%22%3A%22St.+Patrick%27s+Day%22%2C%22value_format%22%3Anull%2C%22value_format_name%22%3Anull%2C%22_kind_hint%22%3A%22measure%22%2C%22_type_hint%22%3A%22number%22%2C%22filter_expression%22%3A%22%24%7Bhourly_irish_weather.observed_month_num%7D+%3D+2+AND+extract_days%28%24%7Bdaily_weather.date%7D%29+%3D+17%22%7D%2C%7B%22measure%22%3A%22calculation_2%22%2C%22based_on%22%3A%22daily_weather.daily_max_temperature%22%2C%22type%22%3A%22min%22%2C%22label%22%3A%22Calculation+2%22%2C%22expression%22%3Anull%2C%22value_format%22%3Anull%2C%22value_format_name%22%3Anull%2C%22_kind_hint%22%3A%22measure%22%2C%22_type_hint%22%3A%22number%22%7D%5D&origin=share-expanded">One look into weather</a> ;;



#   {% condition warm_weather_period_filter %} (EXTRACT(MONTH FROM hourly_irish_weather.date ) >= 4 AND EXTRACT(MONTH FROM hourly_irish_weather.date ) <= 10) {% endcondition %}


}
