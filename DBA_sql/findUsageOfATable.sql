select pg_user.usename, userid, query, calls
from pg_stat_statements, pg_user
where query like '%active_jobs%'
and pg_user.usesysid = userid
