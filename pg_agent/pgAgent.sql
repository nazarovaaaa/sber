DO $$
DECLARE
    jid integer;
    scid integer;
BEGIN
-- Creating a new job
INSERT INTO pgagent.pga_job(
    jobjclid, jobname, jobdesc, jobhostagent, jobenabled
) VALUES (
    1::integer, 'Job1'::text, 'It''s my Job1'::text, 'localhost'::text, true
) RETURNING jobid INTO jid;

-- Steps
-- Inserting a step (jobid: NULL)
INSERT INTO pgagent.pga_jobstep (
    jstjobid, jstname, jstenabled, jstkind,
    jstconnstr, jstdbname, jstonerror,
    jstcode, jstdesc
) VALUES (
    jid, 'step1'::text, true, 's'::character(1),
    ''::text, 'postgres'::name, 'f'::character(1),
    'BEGIN
SELECT current_date,current_time;
END;'::text, 'It''s my step1'::text
) ;

-- Schedules
-- Inserting a schedule
INSERT INTO pgagent.pga_schedule(
    jscjobid, jscname, jscdesc, jscenabled,
    jscstart, jscend,    jscminutes, jschours, jscweekdays, jscmonthdays, jscmonths
) VALUES (
    jid, 'schedule1'::text, 'it''s my schedule1'::text, true,
    '2022-06-21 22:25:00 +03:00'::timestamp with time zone, '2022-06-22 22:25:00 +03:00'::timestamp with time zone,
    -- Minutes
    ARRAY[false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]::boolean[],
    -- Hours
    ARRAY[false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,true,false]::boolean[],
    -- Week days
    ARRAY[true,true,true,true,true,true,true]::boolean[],
    -- Month days
    ARRAY[true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true]::boolean[],
    -- Months
    ARRAY[true,true,true,true,true,true,true,true,true,true,true,true]::boolean[]
) RETURNING jscid INTO scid;
END
$$;