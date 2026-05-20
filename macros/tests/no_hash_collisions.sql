{% test no_hash_collisions(model,column_name,hashed_fields) %}
WITH
all_tuples as 
( select distinct {{column_name}} as HASH, {{hashed_fields}} from {{model}})
,validation_errors
as (select HASH, COUNT(*) from all_tuples
group by HASH
HAVING COUNT(*)> 1
)
SELECT * FROM validation_errors
{%- endtest %}
