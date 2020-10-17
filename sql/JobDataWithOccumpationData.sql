select job.job_id,
       job_filename,
       job.job_data -> 'company' ->> 'diceId'                                                                         as dice_id,
       pst_grp_name,
       pst_grp_desc,
       job_status_id                                                                                                  as "JobIsActive",
--        job.job_data,
       job.modified_date_time,
       job.job_data -> 'contact' ->> 'email'                                                                          as job_owner,
--        position_id,
       job.job_data ->> 'title'                                                                                       as job_title,
       jpis.job_category.classification_by_filter,
       tech_job,
       ds_is_tech,
       (select occupation_code
        from jpis.bg_taxonomy
        where job_category.bg_taxonomy_id = bg_taxonomy.bg_taxonomy_id)                                               as occupation_code,
       (select occupation
        from jpis.bg_taxonomy
        where job_category.bg_taxonomy_id = bg_taxonomy.bg_taxonomy_id)                                               as occupation,
       (select occupation_group
        from jpis.bg_taxonomy
        where job_category.bg_taxonomy_id = bg_taxonomy.bg_taxonomy_id)                                               as occupation_group,
       (select career_area
        from jpis.bg_taxonomy
        where job_category.bg_taxonomy_id = bg_taxonomy.bg_taxonomy_id)                                               as career_area,
--        occupation_code,
--        occupation,
--        occupation_group,
--        career_area,
       (select count(*)
        from applied_job,
             application
        where application.applied_job_id = applied_job.applied_job_id
          and job_id = job_filename
          and date_applied > current_date - interval '60' day)                                                        as "60_day_job_applies",
       concat('www.dice.com/jobs/detail/', job_filename)                                                              as "job_detail_url"
from jobsvc.job job,
     prvdr.pst_grp,
     jobsvc.job_administration jobadmin,
     jobsvc.job_source,
     jpis.job_category
--         ,
--      jpis.bg_taxonomy
where 1 = 1
-- and job_status_id = 1
--   and job_filename in
  and cast(job.company_id as integer) = pst_grp_id
  and jobadmin.job_id = job.job_id
  and modified_date_time > (current_date - interval '60' day)
  and pst_grp_cat_id = 2 -- classified
  and pst_grp_typ_id = 6 -- retail
  and jobadmin.job_source_id = job_source.job_source_id
  and jpis.job_category.job_id = job.job_filename
--   and pst_grp_name = 'RTX1dbdb6'
--   and job_category.bg_taxonomy_id = bg_taxonomy.bg_taxonomy_id
ORDER BY modified_date_time desc, dice_id, position_id;
