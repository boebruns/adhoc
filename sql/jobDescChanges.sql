select job.job_id,
       job_filename,
--        job.job_data,
       job.modified_date_time,
--        jobadmin.posted_date,
       jobadmin.first_active_date,
--        jobadmin.active_date,
--        jobadmin.freshness_date,
       job.job_data -> 'company' ->> 'diceId'            as dice_id,
       job.position_id,
       job.job_data ->> 'title'                          as job_title,
       job_source.job_source_text                        as job_source,
       (select count(distinct (job_title))
        from job_status_history
        where doc_key = job_filename)                    as NumJobTitleChanges,
       (select count(distinct (job_desc_md5_hash))
        from job_status_history
        where doc_key = job_filename)                    as NumJobDescChanges,
       concat('www.dice.com/jobs/detail/', job_filename) as "job_detail_url"
from jobsvc.job job,
     jobsvc.job_administration jobadmin,
     jobsvc.job_source
where 1 = 1
  and job_status_id = 1
  and jobadmin.job_id = job.job_id
  and jobadmin.job_source_id = job_source.job_source_id
  and first_active_date < now() - interval ' 90 days'
ORDER BY first_active_date asc, job_filename;
