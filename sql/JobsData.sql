select pst_grp_name,
       pst_grp_desc,
       pst_user_name,
       firstname,
       lastname,
       pst_grp_cat_id,
       pst_grp_typ_id,
       job_data,
       jobsvc.job.job_data ->> 'title',
       jobsvc.job.job_data -> 'company' ->> 'url'         as CompanyURL,
       jobsvc.job.job_data -> 'company' ->> 'name'        as CompanyName,
       jobsvc.job.job_data -> 'company' ->> 'location'    as CompanyLocation,
       jobsvc.job.job_data -> 'company' ->> 'url'         as CompanyURL,
       jobsvc.job.job_data -> 'contact' ->> 'name'        as ContactName,
       jobsvc.job.job_data -> 'contact' ->> 'companyName' as ContactCompanyName,
       jobsvc.job.job_data -> 'contact' ->> 'email'       as ContactEmail,
       jobsvc.job.job_data -> 'contact' ->> 'city'        as ContactCity
from jobsvc.job,
     pst_user,
     pst_grp,
     pst_user_contact
where job.customer_id = pst_user.pst_user_id
  and company_id = pst_grp_id
  and pst_user_id = pst_user_contact.pstcontactid
  and job.job_status_id = 1
  and pst_grp_cat_id = 3
  and pst_grp_name != 'appblok'
