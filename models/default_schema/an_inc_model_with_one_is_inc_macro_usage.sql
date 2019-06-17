{{ 
  config(
    materialized='incremental'
  ) 
}}

SELECT
  1 AS id
{% if is_incremental() %}
WHERE
  1=1
{% endif %}
