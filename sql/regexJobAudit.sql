 select date_trunc('day', date_created) -
       (CAST(EXTRACT(day FROM date_created) AS integer) % 1) * interval '1 day' AS trunc_day,
       sum(dojaudit.count)                                                      as totalScrubbed,
       count(distinct (dice_id, position_id))                                   as uniqueJobCount,
       'Email Address'                                                          as "Scrub Type"
from (select *
      from prvdr.doj_blatancy_audit dba,
           prvdr.doj_blatancy_audit_details dbad
      where dba.id = dbad.doj_blatancy_audit_id
        and dbad.original_text like '%@%'
        and dba.date_created >= now() - interval '32 days') as dojaudit
GROUP BY trunc_day
union
select date_trunc('day', date_created) -
       (CAST(EXTRACT(day FROM date_created) AS integer) % 1) * interval '1 day' AS trunc_day,
       sum(dojaudit.count)                                                      as totalScrubbed,
       count(distinct (dice_id, position_id))                                   as uniqueJobCount,
       'Phone Number'                                                           as "Scrub Type"
from (select *
      from prvdr.doj_blatancy_audit dba,
           prvdr.doj_blatancy_audit_details dbad
      where dba.id = dbad.doj_blatancy_audit_id
        and dbad.original_text like '%-%'
        and dba.date_created >= now() - interval '32 days') as dojaudit
GROUP BY trunc_day
ORDER BY trunc_day desc
;
