-- Legacy Report Usage Detail
select foo.*,
       (select 'Yes'
        from rpts.job_activity_report
        where rpts.job_activity_report.jar_user_id =
              0 - cast(concat(cast(pst_grp_id as varchar), cast(pst_user_id as varchar)) as bigint)
          and jar_report_name = foo.reportName
           limit 1)                 as "Customer Activity Report",
       (select 'Yes'
        from rpts.job_manager_report
        where jmr_report_name = foo.reportName
          and job_manager_report.jmr_user_id = foo.pst_user_id
           and job_manager_report.jmr_group = cast(foo.pst_grp_id as text)
           limit 1) as "Customer Job Report"
from (
         select pst_user_name,
                pst_grp_name,
                pst_grp_desc,
                pst_grp_status,
                split_part(filename, substr(filename, 1, 17), 2) as reportName,
                filename,
                run_date,
                pst_user.pst_user_id,
                pst_grp.pst_grp_id
         from prvdr.report_results_folder,
              prvdr.pst_grp,
              prvdr.pst_user
         where run_date > '2021-01-01'
           and pst_grp.pst_grp_id = report_results_folder.pst_grp_id
           and pst_user.pst_user_id = report_results_folder.pst_user_id
-- and report_classification != 2
         order by run_date desc) as foo


-- Legacy Report Usage Summary
select foo2.pst_grp_desc, foo2.pst_user_name, count(*)
from (
                  select foo.*,
                         (select 'Yes'
                          from rpts.job_activity_report
                          where rpts.job_activity_report.jar_user_id =
                                0 - cast(concat(cast(pst_grp_id as varchar), cast(pst_user_id as varchar)) as bigint)
                            and jar_report_name = foo.reportName
                          limit 1) as "Customer Activity Report",
                         (select 'Yes'
                          from rpts.job_manager_report
                          where jmr_report_name = foo.reportName
                            and job_manager_report.jmr_user_id = foo.pst_user_id
                            and job_manager_report.jmr_group = cast(foo.pst_grp_id as text)
                          limit 1) as "Customer Job Report"
                  from (
                           select pst_user_name,
                                  pst_grp_name,
                                  pst_grp_desc,
                                  pst_grp_status,
                                  split_part(filename, substr(filename, 1, 17), 2) as reportName,
                                  filename,
                                  run_date,
                                  pst_user.pst_user_id,
                                  pst_grp.pst_grp_id
                           from prvdr.report_results_folder,
                                prvdr.pst_grp,
                                prvdr.pst_user
                           where run_date > '2021-01-01'
                             and pst_grp.pst_grp_id = report_results_folder.pst_grp_id
                             and pst_user.pst_user_id = report_results_folder.pst_user_id
-- and report_classification != 2
                           order by run_date desc) as foo
              ) as foo2
group by 1, 2
order by 3 desc
