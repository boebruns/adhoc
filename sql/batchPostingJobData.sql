select pst_grp_name,
       pst_grp_desc,
       jobsvc.job.job_data ->> 'title'                   as JobTitle,
       job_data -> 'contact' ->> 'displayName'           as "displayName",
       job_data -> 'contact' ->> 'name'                  as "contactName",
       job_data -> 'contact' ->> 'recruiterUUID'         as "recruiterUUID",
       concat('www.dice.com/jobs/detail/', job_filename) as JobDetailURL,
       job_source_text,
       (
           select code_value.code_value
           from jpis.job_status_log,
                jpis.code_value,
                jpis.batch_status_log,
                jpis.job_tracking_data
           where 1 = 1
             and batch_status_log.source_type_id = code_value.code_value_id
             and job_status_log.batch_file_name = batch_status_log.batch_file_name
             and job_tracking_data.job_id = job_filename
             and job_tracking_data.current_job_status_log_id = job_status_log_id
       )                                                 as JPIS_SOURCE
--        job_data
from jobsvc.job,
     prvdr.pst_grp,
     jobsvc.job_administration,
     jobsvc.job_source
where company_id = pst_grp_id
  and job.job_status_id = 1
  and job.job_id = job_administration.job_id
  and job_source.job_source_id = job_administration.job_source_id
  and job_source.job_source_id = 10; -- only include batch posted jobs
