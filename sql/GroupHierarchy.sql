select recruiter_id,
       recruiter_email,
       recruiter_first_name,
       recruiter_last_name,
       client_id_1,
       client_dice_id_1,
       client_description_1,
       client_status_1,
       client_id_2,
       client_dice_id_2,
       client_description_2,
       client_status_2,
       client_id_3,
       client_dice_id_3,
       client_description_3,
       client_status_3,
       (select pst_grp.pst_grp_id
        from pst_grp,
             pst_grp_membership
        where pst_grp.pst_grp_id = pst_grp_membership.pst_grp_id
          and pst_grp_mbr_id = client_id_3) as "client_id_4",
       (select pst_grp.pst_grp_name
        from pst_grp,
             pst_grp_membership
        where pst_grp.pst_grp_id = pst_grp_membership.pst_grp_id
          and pst_grp_mbr_id = client_id_3) as "client_dice_id_4",
       (select pst_grp.pst_grp_desc
        from pst_grp,
             pst_grp_membership
        where pst_grp.pst_grp_id = pst_grp_membership.pst_grp_id
          and pst_grp_mbr_id = client_id_3) as "client_description_4",
       (select pst_grp.pst_grp_status
        from pst_grp,
             pst_grp_membership
        where pst_grp.pst_grp_id = pst_grp_membership.pst_grp_id
          and pst_grp_mbr_id = client_id_3) as "client_status_4"


from (select recruiter_id,
             recruiter_email,
             recruiter_first_name,
             recruiter_last_name,
             client_id_1,
             client_dice_id_1,
             client_description_1,
             client_status_1,
             client_id_2,
             client_dice_id_2,
             client_description_2,
             client_status_2,
             (select pst_grp.pst_grp_id
              from pst_grp,
                   pst_grp_membership
              where pst_grp.pst_grp_id = pst_grp_membership.pst_grp_id
                and pst_grp_mbr_id = client_id_2) as "client_id_3",
             (select pst_grp.pst_grp_name
              from pst_grp,
                   pst_grp_membership
              where pst_grp.pst_grp_id = pst_grp_membership.pst_grp_id
                and pst_grp_mbr_id = client_id_2) as "client_dice_id_3",
             (select pst_grp.pst_grp_desc
              from pst_grp,
                   pst_grp_membership
              where pst_grp.pst_grp_id = pst_grp_membership.pst_grp_id
                and pst_grp_mbr_id = client_id_2) as "client_description_3",
             (select pst_grp.pst_grp_status
              from pst_grp,
                   pst_grp_membership
              where pst_grp.pst_grp_id = pst_grp_membership.pst_grp_id
                and pst_grp_mbr_id = client_id_2) as "client_status_3"


      from (select pst_user_id                                 as "recruiter_id",
                   pst_user_name                               as "recruiter_email",
                   firstname                                   as "recruiter_first_name",
                   lastname                                    as "recruiter_last_name",
                   pst_grp_id                                  as "client_id_1",
                   pst_grp_name                                as "client_dice_id_1",
                   pst_grp_desc                                as "client_description_1",
                   pst_grp_status                              as "client_status_1",
                   (select pg2.pst_grp_id
                    from pst_grp pg2,
                         pst_grp_membership
                    where pg2.pst_grp_id = pst_grp_membership.pst_grp_id
                      and pst_grp_mbr_id = company.pst_grp_id) as "client_id_2",
                   (select pg2.pst_grp_name
                    from pst_grp pg2,
                         pst_grp_membership
                    where pg2.pst_grp_id = pst_grp_membership.pst_grp_id
                      and pst_grp_mbr_id = company.pst_grp_id) as "client_dice_id_2",
                   (select pg2.pst_grp_desc
                    from pst_grp pg2,
                         pst_grp_membership
                    where pg2.pst_grp_id = pst_grp_membership.pst_grp_id
                      and pst_grp_mbr_id = company.pst_grp_id) as "client_description_2",
                   (select pg2.pst_grp_status
                    from pst_grp pg2,
                         pst_grp_membership
                    where pg2.pst_grp_id = pst_grp_membership.pst_grp_id
                      and pst_grp_mbr_id = company.pst_grp_id) as "client_status_2"
            from pst_user recruiter,
                 pst_grp company,
                 pst_user_contact as recruiter_contact
            where recruiter.pst_user_pri_grp = company.pst_grp_id
              and recruiter.pst_user_id = recruiter_contact.pstcontactid
              and company.pst_grp_admin != recruiter.pst_user_id  -- exclude group admins
              and company.pst_grp_status = 1 -- only active clients/companies
              and recruiter.active = 1  -- only active recruiters/users
           ) as foo) as foo2
order by client_id_4 desc, client_id_3 desc, client_id_2 desc, client_id_1 desc;


