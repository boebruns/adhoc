select to_char(search_time, 'YYYY-MM-dd'), count(*) as "SearchCount"
from socialcv_search_log
where search_time > '2020-10-10'
group by 1
order by 1 desc

select to_char(view_time, 'YYYY-MM-dd'), count(*) as "ViewCount"
from socialcv_view_log
where view_time > '2020-10-10'
and view_type > 24
group by 1
order by 1 desc

select * from socialcv_search_log where search_time > '2020-10-21'
order by search_time desc
