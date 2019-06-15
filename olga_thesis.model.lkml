connection: "lookerdata_publicdata_standard_sql"

# include all the views
include: "*.view"

datagroup: olga_thesis_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: olga_thesis_default_datagroup

explore: hourly_irish_weather {}
