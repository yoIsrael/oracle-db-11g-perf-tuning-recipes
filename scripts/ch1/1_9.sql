DECLARE
  my_task_id   number;
  obj_id       number;
  my_task_name varchar2(100);
  my_task_desc varchar2(500);
BEGIN
  my_task_name := 'F_REGS Advice';
  my_task_desc := 'Manual Segment Advisor Run';
---------
-- Step 1
---------
  dbms_advisor.create_task (
  advisor_name => 'Segment Advisor',
  task_id      => my_task_id,
  task_name    => my_task_name,
  task_desc    => my_task_desc);
---------
-- Step 2
---------
  dbms_advisor.create_object (
  task_name   => my_task_name,
  object_type => 'TABLE',
  attr1       => 'MV_MAINT',
  attr2       => 'F_REGS',
  attr3       => NULL,
  attr4       => NULL,
  attr5       => NULL,
  object_id   => obj_id);
---------
-- Step 3
---------
  dbms_advisor.set_task_parameter(
  task_name => my_task_name,
  parameter => 'recommend_all',
  value     => 'TRUE');
---------
-- Step 4
---------
  dbms_advisor.execute_task(my_task_name);
END;
/ 

SELECT
 'Segment Advice --------------------------'|| chr(10) ||
 'TABLESPACE_NAME  : ' || tablespace_name   || chr(10) ||
 'SEGMENT_OWNER    : ' || segment_owner     || chr(10) ||
 'SEGMENT_NAME     : ' || segment_name      || chr(10) ||
 'ALLOCATED_SPACE  : ' || allocated_space   || chr(10) ||
 'RECLAIMABLE_SPACE: ' || reclaimable_space || chr(10) ||
 'RECOMMENDATIONS  : ' || recommendations   || chr(10) ||
 'SOLUTION 1       : ' || c1                || chr(10) ||
 'SOLUTION 2       : ' || c2                || chr(10) ||
 'SOLUTION 3       : ' || c3 Advice
FROM
TABLE(dbms_space.asa_recommendations('TRUE', 'TRUE', 'FALSE'));

SELECT
 'Task Name        : ' || f.task_name  || chr(10) ||
 'Segment Name     : ' || o.attr2      || chr(10) ||
 'Segment Type     : ' || o.type       || chr(10) ||
 'Partition Name   : ' || o.attr3      || chr(10) ||
 'Message          : ' || f.message    || chr(10) ||
 'More Info        : ' || f.more_info TASK_ADVICE
FROM dba_advisor_findings f
    ,dba_advisor_objects  o
WHERE o.task_id = f.task_id
AND o.object_id = f.object_id
AND f.task_name like 'F_REGS Advice'
ORDER BY f.task_name;
