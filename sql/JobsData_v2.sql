select job.job_id,
       job_filename,
       job_status_id,
--        job.job_data,
       job.modified_date_time,
       job.job_data -> 'paid'                                 as "PaidJob",
--        job_category.bg_taxonomy_id,
       job.job_data -> 'company' ->> 'diceId'                 as dice_id,
       position_id,
       job.job_data ->> 'title'                               as job_title,
       job_data -> 'locations' -> 0 ->> 'city'                as "job_city",
       job_data -> 'locations' -> 0 ->> 'region'              as "job_state",
       job_data -> 'locations' -> 0 ->> 'country'              as "job_country",
       job_data -> 'contact' -> 'location' ->> 'city' as "poster_city",
       job_data -> 'contact' -> 'location' ->> 'region' as "poster_state",
       job_data -> 'contact' -> 'location' ->> 'country' as "poster_country",
       job_source.job_source_text                             as job_source,
       job.job_data -> 'apply' ->> 'type'                     as job_apply_type,
       (select sum(view_count)
        from job_imp_daily_cnt
        where job_id = job_filename
          and day_date > current_date - interval '1' day)     as "1_day_job_impressions",
       (select count(*)
        from applied_job,
             application
        where application.applied_job_id = applied_job.applied_job_id
          and job_id = job_filename
          and date_applied > current_date - interval '1' day) as "1_day_job_applies",
       concat('www.dice.com/jobs/detail/', job_filename)      as "job_detail_url",
       job_data -> 'employment' ->> 'remote'                  as remote_job,
       jpis.job_category.classification_by_filter,
       tech_job,
       ds_is_tech,
       occupation_code,
       occupation,
       occupation_group,
       career_area
from jobsvc.job job,
     jobsvc.job_administration jobadmin,
     jobsvc.job_source,
     jpis.job_category,
     jpis.bg_taxonomy
where 1=1
and job_status_id = 1
--   and lower(job_data -> 'locations' -> 0 ->> 'city') = 'remote'
--   and job_data -> 'employment' ->> 'remote' = 'true'
  and job_data -> 'locations' -> 0 ->> 'country' is null
--   and job_filename = 'e06cd7a9100233ffe9ea721cef208918'
--   and tech_job is FALSE
--   and ds_is_tech is FALSE
  and jobadmin.job_id = job.job_id
  and jobadmin.job_source_id = job_source.job_source_id
  and jpis.job_category.job_id = job.job_filename
  and job_category.bg_taxonomy_id = bg_taxonomy.bg_taxonomy_id
ORDER BY modified_date_time desc, dice_id, position_id;


