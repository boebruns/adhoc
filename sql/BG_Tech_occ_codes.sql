select occupation_code,
       regexp_replace(occupation_code, '[^0-9]+', '', 'g') as bgtocc,
       occupation,
       occupation_group,
       career_area,
       Case filter_type_id when 49 then 'Tech' when 50 then 'NonTech' end as "Type"
from jpis.bg_taxonomy bt,
     jpis.bgt_occ_filter bof
where bof.bg_taxonomy_id = bt.bg_taxonomy_id
  and bof.filter_type_id in (49, 50)
order by "Type" desc, occupation
