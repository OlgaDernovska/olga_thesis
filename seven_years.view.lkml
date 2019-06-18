view: seven_years {
  derived_table: {
    sql: -- select  hourly_irish_weather_observed_year_num,
      -- count( distinct hourly_irish_weather_county)
      -- -- rank() over (partition by  hourly_irish_weather_county order by hourly_irish_weather_observed_year_num) as ro
      -- from (
      SELECT
        hourly_irish_weather.county  AS hourly_irish_weather_county,
          -- EXTRACT(year FROM hourly_irish_weather.date ) AS hourly_irish_weather_observed_year_num,
        EXTRACT(MONTH FROM hourly_irish_weather.date ) AS hourly_irish_weather_observed_month_num,
        CASE
        WHEN EXTRACT(MONTH FROM hourly_irish_weather.date ) = 1 THEN 'January'
        WHEN EXTRACT(MONTH FROM hourly_irish_weather.date ) = 2 THEN 'February'
        WHEN EXTRACT(MONTH FROM hourly_irish_weather.date ) = 3 THEN 'March'
        WHEN EXTRACT(MONTH FROM hourly_irish_weather.date ) = 4 THEN 'April'
        WHEN EXTRACT(MONTH FROM hourly_irish_weather.date ) = 5 THEN 'May'
        WHEN EXTRACT(MONTH FROM hourly_irish_weather.date ) = 6 THEN 'June'
        WHEN EXTRACT(MONTH FROM hourly_irish_weather.date ) = 7 THEN 'July'
        WHEN EXTRACT(MONTH FROM hourly_irish_weather.date ) = 8 THEN 'August'
        WHEN EXTRACT(MONTH FROM hourly_irish_weather.date ) = 9 THEN 'September'
        WHEN EXTRACT(MONTH FROM hourly_irish_weather.date ) = 10 THEN 'October'
        WHEN EXTRACT(MONTH FROM hourly_irish_weather.date ) = 11 THEN 'November'
        WHEN EXTRACT(MONTH FROM hourly_irish_weather.date ) = 12 THEN 'December'
      END
       AS hourly_irish_weather_observed_month_name,
        COALESCE(SUM(hourly_irish_weather.rain ), 0)/7 AS hourly_irish_weather_total_rain
      FROM olga_thesis.hourly_irish_weather  AS hourly_irish_weather

      WHERE EXTRACT(year FROM hourly_irish_weather.date )>=2011
      and hourly_irish_weather.station  IN ('PhoenixPark', 'Athenry', 'Shannon_Airport', 'Cork_Airport', 'JohnstownII')
      GROUP BY 1,2,3
      -- ORDER BY 3 DESC)
      -- group by 1
      -- order by 1
       ;;
      persist_for: "24000000000 hours"
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: hourly_irish_weather_county {
    type: string
    sql: ${TABLE}.hourly_irish_weather_county ;;
  }

  dimension: hourly_irish_weather_observed_month_num {
    type: number
    sql: ${TABLE}.hourly_irish_weather_observed_month_num ;;
  }

  dimension: hourly_irish_weather_observed_month_name {
    type: string
    sql: ${TABLE}.hourly_irish_weather_observed_month_name ;;
  }

  dimension: hourly_irish_weather_total_rain {
    type: number
    sql: ${TABLE}.hourly_irish_weather_total_rain ;;
  }

  set: detail {
    fields: [hourly_irish_weather_county, hourly_irish_weather_observed_month_num, hourly_irish_weather_observed_month_name, hourly_irish_weather_total_rain]
  }
}
