view: wine_produced {
  sql_table_name: olga_thesis.wine_produced ;;

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: county {
      type: string
      sql: ${TABLE}.county ;;
      map_layer_name: county_layer
    }

    set: detail {
      fields: [county]
    }
  }
