select group_id,
       (select pst_grp_desc from prvdr.pst_grp where pst_grp_name = group_id) as GrpDesc,
       reply_to_email,
       customer_name,
       (select original_file_name
        from jpis.batch_status_log
        where group_id = bsl.group_id
          and created_date_time > '2020-10-17'
        order by created_date_time desc
        limit 1) as originalFileName,
       count(*)
from jpis.batch_status_log bsl,
     prvdr.pst_user
where created_date_time > '2020-10-17'
  and source_type_id in (77)  --email
  and batch_status_id in (15) --4
  and lower(customer_name) = lower(pst_user_name)
  and batch_comment = 'ERROR: Error getting bearer token User does not exist.'
group by group_id, reply_to_email, customer_name, 4
order by group_id

