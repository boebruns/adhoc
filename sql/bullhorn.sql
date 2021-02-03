Jessie Puls
    I have 291 logins across 96 companies (the login date is their most recent login). 
    This query:
    
select
       pst_grp_desc as "Company",
       pst_user_name as "Username",
       date_created as "Login Date"
from bullhorn_token_data btd
join pst_user pu on btd.customer_id = pu.pst_user_id
join pst_grp pg on btd.company_id = pg.pst_grp_id
where date_created > '2020-02-02'
order by pst_grp_desc asc, pst_user_name asc, date_created desc


    Exported profiles are stored in the "exported_profiles" table. If auto_export is set to 0 that means it's a bullhorn export, so this query:
    
select count(*)
from exported_profile
where auto_export = 0
and date_created > '2020-02-02'

    returns 158,943

    Or broken down by company
    
select pg.pst_grp_desc, count(*)
from exported_profile ep
join pst_grp pg on ep.company_id = pg.pst_grp_id
where ep.auto_export = 0
and date_created > '2020-02-02'
group by pg.pst_grp_id


    
select *
from bullhorn_token_data btd
where date_created > '2020-02-02'


    If you just look at how many people logged in it's 290, but that's across 96 companies (which may be the more relevant thing to measure by)

