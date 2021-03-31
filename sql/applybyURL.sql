select to_char(date_applied, 'YYYY-MM-DD'), count(*)
from prvdr.application
where date_applied > '2021-01-01'
and to_char(date_applied, 'HH24') >= '00'
and apply_method_id = 'e9b7d08d720e4116a559046376e0ec04'
group by  1
order by 1 desc;
