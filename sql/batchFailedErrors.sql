select all_not_completed.customer_name, all_not_completed.count as errd, all_completed.count as succd
from (select customer_name, batch_status_id, count(1)
      from jpis.batch_status_log bsl
      where created_date_time > '2020-10-15'
        and source_type_id not in (75, 78)
        and batch_status_id not in (4)
      group by customer_name, batch_status_id) as all_not_completed,
     (select customer_name, batch_status_id, count(1)
      from jpis.batch_status_log bsl
      where created_date_time > '2020-10-15'
        and source_type_id not in (75, 78)
        and batch_status_id in (4)
      group by customer_name, batch_status_id
      order by customer_name) as all_completed
where all_completed.customer_name = all_not_completed.customer_name
