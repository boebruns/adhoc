select *
from (select pst_user_name, pst_grp_name, pst_grp_desc, case talent_search_4
    when 1 then 'Yes'
    else 'No'
    end as "Group Level TS 4.0",
          description, search_type, case search_type
                                                                                    when 6 then 'TS 2.0'
                                                                                    when 9 then 'TS 3.0 API'
                                                                                    when 11 then 'TS 3.0 API'
                                                                                    else 'unknown'
    end as "TS Version", to_char(search_time, 'YYYY-MM') as "Search Date", count(*) as "Search Count"
      from socialcv_search_log_type,
           socialcv_search_log,
           pst_grp,
           pst_user
      where search_type = socialcv_search_log_type.id
        and socialcv_search_log_type.id < 12 -- non TS 4.0 searches
        and pst_user_id = socialcv_search_log.user_id
        and pst_user_pri_grp = pst_grp_id
        and search_time > '2019-12-20'
      GROUP by pst_user_name, pst_grp_name, pst_grp_desc, description, search_type, "Group Level TS 4.0", "TS Version",
               to_char(search_time, 'YYYY-MM')
      ORDER by "Search Date" desc, "Search Count" desc) as foo;


