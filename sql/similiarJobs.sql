select jsl.job_id, sj.*
from jpis.job_status_log jsl , jpis.job_tracking_data jtd , jpis.similar_job sj
where jtd.current_job_status_log_id = jsl.job_status_log_id
and jtd.job_id in ('c7a219e61dea36f9bc4a8919a1c6a9ea', '4965fda9b0988187d0621866f726609d')
and jsl.job_status_log_id = sj.job_status_log_id
;
