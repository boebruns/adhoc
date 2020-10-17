update pst_grp
set max_jobs = (select job_limit from ppv_company where company_id = pst_grp_id)
-- select pst_grp_name, max_jobs, pst_grp_desc
-- from pst_grp
where pst_grp_status = 1
and pst_grp_id in (select ppvc.company_id
from ppv_company ppvc
         inner join pst_grp pg
                    on (ppvc.company_id = pg.pst_grp_id)
         inner join job_clicks_comp_cur_month_cnt jcccmc
                    on (jcccmc.company_id = ppvc.company_id)
where view_limit >= view_count
and max_jobs = 0);
