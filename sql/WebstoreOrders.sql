select purchase_date, pst_user_name, pst_grp_name, pst_grp_desc, order_history.*, order_customer.*, order_detail.*
from webstore_Job_tokens, order_history, pst_grp, order_customer, pst_user, order_detail
where 1 = 1
 and purchase_date > '2020-10-01' and purchase_date < '2020-10-31'
 and webstore_job_tokens.pst_grp_id = pst_grp.pst_grp_id
and order_history_id = order_history.id
 and order_customer_id = order_customer.id
  and order_detail_id = order_detail.id
 and customer_id = pst_user_id
order by purchase_date desc
