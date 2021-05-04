-- Raw Views from blocked IP's with Applies from 2021-04-01 forward.

select foo.*,
       (select count(*)
        from repl_dice_skr.application_detail
        where application_detail.client_ip = foo.client_ip
          and application_date > '2021-04-01') as applyCount,
       (select country_name
        from analytics.application_geo
        where client_ip = foo.client_ip
        order by meta_load_date_time desc
        limit 1)                               as IP_Country
from (select ppv_exclusion.date_created as ip_exclusion_date,
             ppv_exclusion.client_ip,
             count(*)                   as jdvCount
      from raw_dice.job_view,
           repl_dice_prvdr.ppv_exclusion
      where raw_dice.job_view.date_created > '2021-04-01'
        and ppv_exclusion.date_created < '2021-04-01'
        and job_view.client_ip = ppv_exclusion.client_ip
        and job_view.customer_id is null
        and (job_view.job_active = 1 or job_view.job_active is null)
      group by 1, 2
      having count(*) > 100
      order by count(*) desc
      limit 1000) as foo
where applyCount > 0
order by jdvCount desc;
