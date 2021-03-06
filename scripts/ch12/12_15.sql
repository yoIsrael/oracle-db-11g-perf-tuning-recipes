DECLARE
  plan_name1 PLS_INTEGER;
BEGIN
  plan_name1 := DBMS_SPM.DROP_SQL_PLAN_BASELINE(
                           plan_name => 'SQL_PLAN_bm39aw8a5xv1x519fc7bf');
END;
/

DECLARE
  sql_handle1 PLS_INTEGER;
BEGIN
  sql_handle1 := DBMS_SPM.DROP_SQL_PLAN_BASELINE(
                           sql_handle => 'SQL_b98d2ae2145eec3d');
END;
/

SET SERVEROUT ON SIZE 1000000
DECLARE
  sql_handle1 PLS_INTEGER;
  CURSOR c1 IS
    SELECT sql_handle
    FROM dba_sql_plan_baselines;
BEGIN
  FOR r1 IN c1 LOOP
    sql_handle1 := DBMS_SPM.DROP_SQL_PLAN_BASELINE(sql_handle => r1.sql_handle);
    DBMS_OUTPUT.PUT_LINE('PB dropped for SH: ' || r1.sql_handle);
  END LOOP;
END;
/
