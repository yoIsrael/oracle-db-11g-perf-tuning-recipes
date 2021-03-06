SELECT
 a.name
,b.comp_data
FROM dba_sql_profiles          a
    ,dbmshsxp_sql_profile_attr b
WHERE a.name = b.profile_name;

SELECT
  extractvalue(value(a), '.') sqlprofile_hints
FROM sqlobj$     o
    ,sqlobj$data d
    ,table(xmlsequence(extract(xmltype(d.comp_data),'/outline_data/hint'))) a
WHERE o.name     = '&&profile_name'
AND   o. plan_id = d.plan_id
AND   o.signature = d.signature
AND   o.category = d.category
AND   o.obj_type = d.obj_type;

