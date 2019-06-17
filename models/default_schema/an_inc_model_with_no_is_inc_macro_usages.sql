{{ 
  config(
    materialized='incremental'
  ) 
}}

SELECT
  1 AS id
