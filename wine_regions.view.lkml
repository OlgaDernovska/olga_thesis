view: wine_regions {
  sql_table_name: olga_thesis.wine_regions ;;

  dimension: regions {
    type: string
    sql: ${TABLE}.string_field_0 ;;
  }

  dimension: gdd {
    label: "GDD"
    type: string
    sql: ${TABLE}.string_field_1 ;;
  }

  dimension: mjt {
    label: "MJT"
    type: string
    sql: ${TABLE}.string_field_2 ;;
  }

  dimension: grape_varieties {
    type: string
    sql: ${TABLE}.string_field_3 ;;
  }

  dimension: wine_regions {
    type: string
    sql: ${TABLE}.string_field_4 ;;
  }

#   measure: count {
#     type: count
#     drill_fields: []
#   }
}
