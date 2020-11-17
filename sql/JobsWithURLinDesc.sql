select *
from (select pst_grp_name,
             pst_grp_desc,
             pst_user_name,
--              job_source_text,
             JobTitle,
             JobDetailURL,
             regexp_matches(JobDescription,
                            '(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})') as URLFound,
             regexp_matches(JobDescription, '(<img[^>]*src=\"?[^\"]*)\"?([^>]*alt=\"?([^\"]*\"?)?[^>]*>)') as ImageFound
      from (select pst_grp_name,
                   pst_grp_desc,
                   pst_user_name,
                   pst_grp_cat_id,
                   pst_grp_typ_id,
                   job_source_text,
                   job_data,
                   jobsvc.job.job_data ->> 'title'                           as JobTitle,
                   lower(jobsvc.job.job_data ->> 'description')              as JobDescription,
                   jobsvc.job.job_data -> 'company' ->> 'url'                as CompanyURL,
                   concat('https://www.dice.com/jobs/detail/', job_filename) as JobDetailURL
            from jobsvc.job,
                 pst_user,
                 pst_grp,
                 pst_user_contact,
                 jobsvc.job_administration,
                 jobsvc.job_source
            where job.customer_id = pst_user.pst_user_id
              and company_id = pst_grp_id
              and pst_user_id = pst_user_contact.pstcontactid
              and job.job_status_id = 1
              and job_administration.job_id = job.job_id
              and job_source.job_source_id = job_administration.job_source_id
--   and pst_grp_cat_id = 3
--         and pst_grp_name = '90929690'
           ) as stuff
      where 1 = 1
     ) as stuff2
where
      (cast(stuff2.URLFound as varchar) not like '%w3.org%'
   or stuff2.URLFound is null)
or ImageFound is not null;
