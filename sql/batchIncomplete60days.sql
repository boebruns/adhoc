select pst_grp_name,
       pst_grp_desc,
       customer_name,
       sender_email,
       reply_to_email,
       created_date_time,
       batch_comment,
       batch_size,
       successful_post_count,
       failed_post_count,
       successful_inactivate_count,
       failed_inactivate_count,
       successful_post_count,
       failed_post_count,
       successful_inactive_post_count,
       pst_grp.max_jobs,
--        batch_status_log.*,
       (select code_value from jpis.code_value where code_value_id = source_type_id)  as Source,
       (select code_value from jpis.code_value where code_value_id = product_type_id) as Product,
       (select code_value from jpis.code_value where code_value_id = file_type_id)    as FileType,
       (select code_value from jpis.code_value where code_value_id = batch_type_id)   as BatchType,
       (select code_value from jpis.code_value where code_value_id = batch_status_id) as BatchStatus
from jpis.batch_status_log,
     prvdr.pst_grp
where company_id = pst_grp_id
  AND created_date_time > now() - interval '60 days'
  and source_type_id not in (75) -- exclude POST_A_JOB
  and batch_status_id not in (4) -- exclude COMPLETED batch status
;
