WITH series AS (
    SELECT generate_series(0, 40000, 1000) AS char_from -- 0 = min, 21000 = max, 1000 = 1000 char count interval
),
     char_range AS (
         SELECT char_from, (char_from + 999) AS char_to
         FROM series -- 999 = interval (1000 char count) minus 1
     )
SELECT char_from,
       char_to,
       (select count(*)
        from (select CONCAT('https://www.dice.com/jobs/detail/', job_filename) as job_detail_link, desc_length
              from (select jj.job_filename,
                           regexp_replace(regexp_replace(job_data ->> 'description', E'<.*?>', '', 'g'), E'&nbsp;', '',
                                          'g')                             as description,
                           char_length(regexp_replace(regexp_replace(job_data ->> 'description', E'<.*?>', '', 'g'),
                                                      E'&nbsp;', '', 'g')) as desc_length
                    from jobsvc.job jj
                    where jj.job_status_id = 1) dl
              order by desc_length desc) as breakdown
        where desc_length between char_from and char_to) as char_ct
from char_range;
