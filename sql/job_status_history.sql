select doc_key,
       to_timestamp(activity_time_millis
           / 1000),
       case action
           when 0 then 'Create'
           when 1 then 'Activate'
           when 2 then 'Inactivate'
           when 3 then 'Delete'
           when 4 then 'Move'
           when 5 then 'Suspend'
           when 6 then 'Remove'
           when 7 then 'Create Or Inactivate'
           when 8 then 'CleanUp Inactivate'
           when 9 then 'CleanUp Activate'
           end as "Action",
       pst_user_id,
       dice_id,
       case source_app
           when 0 then 'JobMan'
           when 1 then 'Batch'
           when 2 then 'JobD'
           when 3 then 'JobMover'
           when 4 then 'WebStore'
           when 5 then 'PurgeActiveJobs'
           when 6 then 'JSH CleanUp'
           end as "Source App",
       case current_state
           when -1 then 'deleted'
           when 0 then 'Inactive'
           when 1 then 'Active'
           when 2 then 'Suspended'
           when 99 then 'None'
           end as "Current State",
       case previous_state
           when -1 then 'deleted'
           when 0 then 'Inactive'
           when 1 then 'Active'
           when 2 then 'Suspended'
           when 99 then 'None'
           end as "Previous State"
from job_status_history
where 1 = 1 --3600000
  and doc_key in ('e59b190db5000898a12d11f595109507')
    --and DICE_ID = 'cybercod'
--and action = 2
order by activity_time_millis;

