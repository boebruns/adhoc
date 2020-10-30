select client_ip, user_agent, count(*)
from raw_dice.job_view
where 1 = 1
  and date_created > '2020-10-01'
  and client_ip like '157.97.120%'
group by 1, 2
order by count(*) desc
limit 500;

select user_agent, count(*)
from raw_dice.job_view
where job_id = '130132ca814acd04d04d7fc49f6e2bcf'
and date_created > '2020-10-01'
group by 1
order by count(*) desc


-- select company_id, client_ip, to_char(date_created, 'YYYY-MM'), count(*)
select to_char(date_created, 'YYYY-MM'), client_ip, user_agent,  count(*)
from raw_dice.job_view
where 1 = 1
-- and job_id = '8e3e6c008cf597dc21fecc854b4595ec'
  and date_created > '2020-10-01'
  and date_created < '2020-11-01'
--   and client_ip not in (select client_ip from work_dice.job_clicks_ex_client_ip)
--   and lower(user_agent) not like '%bot%'
--   and lower(user_agent) not like '%python%'
--   and lower (user_agent) like '%jersey%'
  and lower(user_agent) like 'axios%'
  and customer_id is null
-- group by 1, 2, 3
group by 1, 2, 3
having count(*) > 100
order by 1 desc, count(*) desc
limit 1000;


select people_id, count(*)
from raw_dice.job_view
where 1 = 1
  and date_created > '2020-10-01'
  and lower(user_agent) like '%jersey%'
and people_id is not null
group by 1
order by count(*) desc
limit 500;

select client_ip from work_dice.job_clicks_ex_client_ip
where client_ip = '3.208.241.178'

select * from work_dice.job_clicks_only_job_view
where user_agent like '%jersey%';

select * from work_dice.job_clicks_ex_client_ip_block
where client_ip_block like '117.255%'
