elect "Group - Self Administered", "Group ID", "Group Name", "Group Desc", "Group Product Type", "Group Customer Type", count(*) as "NumberOfRecruiters"
from (select trim(pst_user_name) as "UserName",
       pst_user.pst_user_id as "User Id",
       trim(pst_grp_name) as "Group Name",
       pst_grp.pst_grp_id as "Group ID",
       trim(pst_grp_desc) as "Group Desc",
        pgm.pst_grp_mbr_perm,
        pgm2.pst_grp_mbr_perm,
        case PST_GRP.FEAT_ACC_PERM::int & 2
        when 2 then 'Yes'
        when 0 then 'No'
        end as "Group - Reports",
        case PST_GRP.FEAT_ACC_PERM::int & 4
        when 4 then 'Yes'
        when 0 then 'No'
        end as "Group - Web Job Entry",
        case PST_GRP.FEAT_ACC_PERM::int & 8
        when 8 then 'Yes'
        when 0 then 'No'
        end as "Group - Batch Job Entry",
        case PST_GRP.FEAT_ACC_PERM::int & 16
        when 16 then 'Yes'
        when 0 then 'No'
        end as "Group - Account Management",
        case PST_GRP.FEAT_ACC_PERM::int & 32
        when 32 then 'Yes'
        when 0 then 'No'
        end as "Group - Billing Entity",
        case PST_GRP.FEAT_ACC_PERM::int & 64
        when 64 then 'Yes'
        when 0 then 'No'
        end as "Group - Web Job Maintenance",
        case PST_GRP.FEAT_ACC_PERM::int & 128
        when 128 then 'Yes'
        when 0 then 'No'
        end as "Group - Email TM",
        case PST_GRP.FEAT_ACC_PERM::int & 256
        when 256 then 'Yes'
        when 0 then 'No'
        end as "Group - Email Hotlist",
        case PST_GRP.FEAT_ACC_PERM::int & 512
        when 512 then 'Yes'
        when 0 then 'No'
        end as "Group - Self Administered",
        case PST_GRP.FEAT_ACC_PERM::int & 1024
        when 1024 then 'Yes'
        when 0 then 'No'
        end as "Group - Allows AutoLogin",
        case PST_GRP.FEAT_ACC_PERM::int & 2048
        when 2048 then 'Yes'
        when 0 then 'No'
        end as "Group - Allows OFCCP Accounts",
        case PST_GRP.FEAT_ACC_PERM::int & 4096
        when 4096 then 'Yes'
        when 0 then 'No'
        end as "Group - Allows DTN",
        case PST_GRP.FEAT_ACC_PERM::int & 8192
        when 8192 then 'Yes'
        when 0 then 'No'
        end as "Group - Full Company Network (FCN)",
        case PST_GRP.FEAT_ACC_PERM::int & 16384
        when 16384 then 'Yes'
        when 0 then 'No'
        end as "Group - Allows View OFCCP Candidate Name",
        case PST_GRP.FEAT_ACC_PERM::int & 32768
        when 32768 then 'Yes'
        when 0 then 'No'
        end as "Group - Bold & Highlight",
        case PST_GRP.FEAT_ACC_PERM::int & 65536
        when 65536 then 'Yes'
        when 0 then 'No'
        end as "Group - Display Views",
        case PST_GRP.FEAT_ACC_PERM::int & 131072
        when 131072 then 'Yes'
        when 0 then 'No'
        end as "Group - Display View Limits",
        case PST_GRP.FEAT_ACC_PERM::int & 262144
        when 262144 then 'Yes'
        when 0 then 'No'
        end as "Group - Integrated Profile View",
        case PST_GRP.FEAT_ACC_PERM::int & 524288
        when 524288 then 'Yes'
        when 0 then 'No'
        end as "Group - Integrated Search",
        case PST_GRP.FEAT_ACC_PERM::int & 1048576
        when 1048576 then 'Yes'
        when 0 then 'No'
        end as "Group - Integrated Search",
        case pst_grp.display_contact_email
        when 1 then 'Yes'
        when 0 then 'No'
        end as "Group - Display Contact Email",
        case pst_grp.exclude_from_captcha
        when 1 then 'Yes'
        when 0 then 'No'
        end as "Group - Exclude From Captcha",
        case pst_grp.profile_export
        when 1 then 'Yes'
        when 0 then 'No'
        end as "Group - Profile Export",
        case pst_grp.can_opt_out_of_isearch
        when 1 then 'Yes'
        when 0 then 'No'
        end as "Group - Allow Opt Out of Integrated Search",
        case pst_grp.get_talent
        when 1 then 'Yes'
        when 0 then 'No'
        end as "Group - GetTalent",
        case pst_grp.dice_141
        when 1 then 'Yes'
        when 0 then 'No'
        end as "Group - Dice141",
        case pst_grp.pay_per_view
        when 1 then 'Yes'
        when 0 then 'No'
        end as "Group - Pay Per View",
        case pst_grp.employer_app_dashboard
        when 1 then 'Yes'
        when 0 then 'No'
        end as "Group - Employer App Dashboard",
        case pst_grp.freemium
        when 1 then 'Yes'
        when 0 then 'No'
        end as "Group - Freemium",
        case pst_grp.alert_display_contact
        when 1 then 'Yes'
        when 0 then 'No'
        end as "Group - Alert Display Contact",
        case pst_grp.dice_solr_search
        when 1 then 'Yes'
        when 0 then 'No'
        end as "Group - Dice SOLR Search",
        case pst_grp.alt_endeca_boolean
        when 1 then 'Yes'
        when 0 then 'No'
        end as "Group - Alt Endeca Boolean Search",
        case pst_grp.global_integrated_search
        when 1 then 'Yes'
        when 0 then 'No'
        end as "Group - Global Integrated Search",
        case pst_grp.Talent_Search_4
        when 1 then 'Yes'
        when 0 then 'No'
        end as "Group - TS 4.0",
        case pup.integrated_search_opt_out
        when 1 then 'Yes'
        when 0 then 'No'
        end as "User Pref -  OptdOut TS 2.0",
        case pgm.PST_MBR_OPEN_WEB_SEARCH
        when 1 then 'Yes'
        else 'No'
        end as "User Level - Open Web Permission",
        case pgm.PST_MBR_TALENT_MATCH_SEARCH
        when 1 then 'Yes'
        else 'No'
        end as "User Level - Dice Search Permission",
        case pgm.pst_mbr_dice_select
        when 1 then 'Yes'
        when 0 then 'No'
        end as "Dice Select",
        case pst_grp.PST_GRP_STATUS
        when 1 then 'Yes'
        else 'No'
        end as "Active Group",
        case pst_user.ACTIVE
        when 1 then 'Yes'
        else 'No'
        end as "Active User",
        case pst_grp.PST_GRP_CAT_ID
        when 0 then 'None'
        when 1 then 'Subscription'
        when 2 then 'Classified'
        when 3 then 'One Post'
        else 'Unknown'
        end as "Group Product Type",
        case pst_grp.pst_grp_typ_id
        when 0 then 'None'
        when 1 then 'Recruitment Ad Agency'
        when 2 then 'Recruiter'
        when 3 then 'Consulting'
        when 4 then 'Employer'
        when 5 then 'Premium Post'
        when 6 then 'Retail'
        else 'Unknown'
        end as "Group Customer Type",

        --from pst_user_prefs
  --edit user

  --from pst_grp_membership
  --site permissions
  case pgm.pst_mbr_site_rpt
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Site Reports",
  case pgm.pst_mbr_ad_mgmt
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Ad Management",
  case pgm.pst_mbr_part_mgmt
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Partner Management",
  case pgm.pst_mbr_metro_mgmt
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Metro Area Management",
  case pgm.pst_mbr_emp_mgmt
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Employer Management",
  case pgm.pst_mbr_skr_mgmt
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Seeker Management",
  case pgm.pst_etn_network_admin
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Etn Network Admin",
  case pgm.pst_ecp_admin
    when 1 then 'Yes'
    when 0 then 'No'
  end as "ECP Admin",
  case pgm.pst_company_network_admin
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Company Network Admin",
  case pgm.pst_recruiter_network_profile
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Recruiter Network Profile",
  case pgm.pst_company_network_tmtab
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Company Network Talent Match Tab",
  --edit permissions

  case pgm.pst_mbr_view_grp
    when 1 then 'Yes'
    when 0 then 'No'
  end as "View Group",
  case pgm.pst_mbr_edit_grp
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Edit Group",
  case pgm.pst_mbr_add_hier_grp
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Group Account Admin Add Groups",
  case pgm.pst_mbr_view_hier_grp
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Group Account Admin View Groups",
  case pgm.pst_mbr_edit_hier_grp
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Group Account Admin Edit Groups",
  case pgm.pst_mbr_del_hier_grp
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Group Account Admin Delete Groups",
  case pgm.pst_mbr_view_user
    when 1 then 'Yes'
    when 0 then 'No'
  end as "View User",
  case pgm.pst_mbr_edit_user
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Update User",
  case pgm.pst_mbr_add_pgrp_user
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Add Primary Group Users",
  case pgm.pst_mbr_view_pgrp_user
    when 1 then 'Yes'
    when 0 then 'No'
  end as "View Primary Group Users",
  case pgm.pst_mbr_edit_pgrp_user
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Edit Primary Group Users",
  case pgm.pst_mbr_del_pgrp_user
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Delete Primary Group Users",
  case pgm.pst_mbr_add_hier_user
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Add All Users",
  case pgm.pst_mbr_edit_hier_user
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Edit All Users",
  case pgm.pst_mbr_view_hier_user
    when 1 then 'Yes'
    when 0 then 'No'
  end as "View All Users",
  case pgm.pst_mbr_del_hier_user
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Delete All Users",
  case pgm.pst_mbr_add_job
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Add Jobs",
  case pgm.pst_mbr_view_job
    when 1 then 'Yes'
    when 0 then 'No'
  end as "View Jobs",
  case pgm.pst_mbr_edit_job
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Edit Jobs",
  case pgm.pst_mbr_del_job
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Delete Jobs",
  case pgm.pst_mbr_add_hier_job
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Job Listing Admin Add Jobs",
  case pgm.pst_mbr_view_hier_job
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Job Listing Admin View Jobs",
  case pgm.pst_mbr_edit_hier_job
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Job Listing Admin Edit Jobs",
  case pgm.pst_mbr_del_hier_job
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Job Listing Admin Delete Jobs",
  case pgm.pst_mbr_talent_search
    when 1 then 'Yes'
    when 0 then 'No'
  end as "Talent Search",
  case pgm2.pst_grp_mbr_perm::bigint & 1073741824
    when 1073741824 then 'Yes'
       when 0 then 'No'
  end as "User - Seeker Management Admin",
  case pgm2.pst_grp_mbr_perm::bigint & 33554432
    when 33554432 then 'Yes'
       when 0 then 'No'
  end as "User - Site Reports Admin",
  case pgm2.pst_grp_mbr_perm::bigint & 67108864
    when 67108864 then 'Yes'
       when 0 then 'No'
  end as "User - Ad Management Admin",
  case pgm2.pst_grp_mbr_perm::bigint & 134217728
    when 134217728 then 'Yes'
       when 0 then 'No'
  end as "User - Partner Management Admin",
  case pgm2.pst_grp_mbr_perm::bigint & 268435456
    when 268435456 then 'Yes'
       when 0 then 'No'
  end as "User - Metro Area Management Admin",
  case pgm2.pst_grp_mbr_perm::bigint & 536870912
      when 536870912 then 'Yes'
    when 0 then 'No'
  end as "User - Employer Management Admin",
  case pgm2.pst_grp_mbr_perm::bigint & 2147483648
      when 2147483648 then 'Yes'
    when 0 then 'No'
  end as "User - Site Admin"
from pst_user, pst_grp, pst_user_prefs pup, PST_GRP_MEMBERSHIP pgm, PST_GRP_MEMBERSHIP pgm2
where pup.PST_USER_ID = pst_user.PST_USER_ID
       and pst_user.PST_USER_PRI_GRP = pst_grp.PST_GRP_ID
       and pst_grp.PST_GRP_STATUS = 1         -- Active Groups
       and pst_user.ACTIVE = 1                -- Active Users
       and pst_grp.PST_GRP_ADMIN != pst_user.PST_USER_ID    -- Not Admin User
       and pgm.PST_GRP_MBR_ID = pst_user.PST_USER_ID
       and pgm.PST_GRP_ID = pst_user.PST_USER_PRI_GRP
       and pgm2.PST_GRP_MBR_ID = pst_user.PST_USER_ID
       and pgm2.PST_GRP_ID = pst_user.PST_USER_ID
       and pst_grp.pst_grp_id != 1        -- Not the Dice Admin Group
    ) as foo
where "Group - Self Administered" = 'Yes'
group by "Group - Self Administered", "Group ID", "Group Name", "Group Desc", "Group Product Type", "Group Customer Type"
