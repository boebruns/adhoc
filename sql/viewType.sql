select pst_user_name, user_id, view_type, description, pst_grp_name, pst_grp_desc, to_char(view_time, 'YYYY-MM'),  count(*)
from socialcv_view_log, socialcv_view_log_type, pst_user, pst_grp
where view_type = socialcv_view_log_type.id
and view_time > '2020-01-01'
and view_type = 14
and user_id = pst_user_id
and pst_user_pri_grp = pst_grp_id
group by 1, 2, 3, 4, 5, 6, 7
order by 7 desc, 8 desc
;
