select round(((viewCounts / view_limit::float) * 100)::numeric, 2) as percentageOfLimit, foo.*
from (
         select pst_grp_name,
                pst_grp_desc,
                company_id,
                max_jobs,
                (select count(*)
                 from all_jobs
                 where all_jobs.dice_id = pst_grp.pst_grp_name
                   and active = 1)                          as jobCount,
                (select view_count
                 from job_clicks_comp_cur_month_cnt
                 where company_id = ppv_company.company_id) as viewCounts,
                ppv_company.view_limit,

                (select batch_size
                 from jpis.batch_status_log
                 where company_id = ppv_company.company_id
                   and batch_size > 1
                   and created_date_time > '2020-06-20'
                 order by created_date_time desc
                 limit 1)                                   as batchSize,
                (select failed_post_count
                 from jpis.batch_status_log
                 where company_id = ppv_company.company_id
                   and batch_size > 1
                   and created_date_time > '2020-06-20'
                 order by created_date_time desc
                 limit 1)                                   as failedPostCount,
                (select successful_post_count
                 from jpis.batch_status_log
                 where company_id = ppv_company.company_id
                   and batch_size > 1
                   and created_date_time > '2020-06-20'
                 order by created_date_time desc
                 limit 1)                                   as successPostCount,
                (select created_date_time - interval '5 hours'
                 from jpis.batch_status_log
                 where company_id = ppv_company.company_id
                   and batch_size > 1
                   and created_date_time > '2020-06-20'
                 order by created_date_time desc
                 limit 1)                                   as lastestBatchPosting,

                job_limit,
                ppv_company.notify_email_list,
                ppv_company.notify_percentages,
                ppv_company.ext_notifiy_email_list,
                ppv_company.ext_notify_percentages
         from pst_grp,
              ppv_company
         where pst_grp_id = company_id
           and pst_grp_status = 1
--            and max_jobs = 0
     ) as foo
where 1 = 1
order by 1 desc
-- and jobCount < 1
