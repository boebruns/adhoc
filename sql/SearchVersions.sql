select foo.pst_user_name, foo.pst_grp_name,
foo."OFCCP_GROUP",
    case
        when ("HasISearch" = 1 AND "TS 3.0" = 1 and "TS 4.0" = 0) then 'TS 3.0'
        when ("HasISearch" = 1 AND "TS 3.0" = 1 and "TS 4.0" = 1) then 'TS 3.0 & TS 4.0 Beta'
        when ("HasISearch" = 1 AND "TS 3.0" = 0 and "TS 4.0" = 0) then 'TS 2.0'
        when ("HasISearch" = 1 AND "TS 3.0" = 0 and "TS 4.0" = 1) then 'TS 2.0 & TS 4.0 Beta'
        when ("HasISearch" = 0 AND "User_Level_TM" = 1 AND "TS 4.0" = 0) then 'TS 1.0'
        when ("HasISearch" = 0 AND ("GROUP_ALLOW_Integrated_Search" = 1 OR "GROUP_ALLOW_Integrated_Profile" = 1) AND ("User_Level_TM" = 1 OR "User_Level_OpenWeb" = 1) AND "TS 4.0" = 1) then 'TS 1.0 & TS 4.0 Beta'
        when ("HasISearch" = 0 AND "GROUP_ALLOW_Integrated_Search" = 1 AND ("User_Level_TM" = 1 OR "User_Level_OpenWeb" = 1) AND "TS 4.0" = 1) then 'TS 4.0 Beta Only'
        when ("HasISearch" = 0 AND "GROUP_ALLOW_Integrated_Search" = 0 AND ("User_Level_TM" = 1 OR "User_Level_OpenWeb" = 1) AND "TS 4.0" = 1 AND "TS 3.0" = 0) then 'TS 4.0 GA'
      --  when ("HasISearch" = 0 AND "GROUP_ALLOW_Integrated_Search" = 0 AND "GROUP_ALLOW_Integrated_Profile" = 0 AND "TS 4.0" = 1 AND "TS 3.0" = 1) then 'TS 4.0 GA XXXX'
      --  when ("HasISearch" = 0 and "GROUP_ALLOW_Integrated_Search" = 0 and "GROUP_ALLOW_Integrated_Profile" = 1 and "TS 4.0" = 1 and "TS 3.0" = 1) then 'TS 4.0 GA YYYYY'
        when ("User_Level_TM" = 0 AND "User_Level_OpenWeb" = 0) then 'No Search'
        when ("HasISearch" = 0 and "User_Level_TM" = 0 AND "User_Level_OpenWeb" = 1) then 'TS 1.0 Open Web Only'
        else 'XXXXX'
    end as "Search Type",
    foo."HasISearch",
    foo."TS 3.0",
    foo."TS 4.0",
    foo."User_Level_TM",
    foo."User_Level_OpenWeb",
    foo.integrated_profile_opt_out,
    foo.integrated_search_opt_out,
    foo."GROUP_ALLOW_Integrated_Profile",
    foo."GROUP_ALLOW_Integrated_Search"

from
(select pst_user_name,
        pst_grp_name,
        case
            when (pst_mbr_talent_match_search = 1 OR pst_mbr_open_web_search = 1)
              AND (integrated_search_opt_out = 0 AND integrated_profile_opt_out = 0)
              AND (feat_acc_perm & 262144 = 262144)
              AND (feat_acc_perm & 524288 = 524288)
                then 1
            else 0
            end as "HasISearch",
        case global_integrated_search
          when 1 then 1
          when 0 then 0
            end as "TS 3.0",
        case talent_search_4
          when 1 then 1
          when 0 then 0
            end as "TS 4.0",
        pst_mbr_talent_match_search as "User_Level_TM",
        pst_mbr_open_web_search as "User_Level_OpenWeb",
        case (feat_acc_perm & 262144)
          when 262144 then 1
          when 0 then 0
            end as "GROUP_ALLOW_Integrated_Profile",
        case (feat_acc_perm & 524288)
          when 524288 then 1
          when 0 then 0
            end as "GROUP_ALLOW_Integrated_Search",
        case feat_acc_perm & 2048
          when 2048 then 'YES'
          when 0 then 'NO'
            end as "OFCCP_GROUP",
        integrated_search_opt_out,
        integrated_profile_opt_out
from pst_user,
      pst_user_prefs,
      pst_grp,
      pst_grp_membership
where pst_user.pst_user_id = pst_user_prefs.pst_user_id
   and pst_grp.pst_grp_id = pst_user_pri_grp
   and active = 1     --       Active User
   and pst_grp_status = 1 -- Active Group
   and pst_grp.external_id is null -- non UK Groups
   and pst_grp_admin != pst_user.pst_user_id   -- Not a Groups Admin User
   and pst_user.pst_user_id = pst_grp_mbr_id
   and pst_grp.pst_grp_id = pst_grp_membership.pst_grp_id
) as foo
where
    --  "TS 4.0" = 1
-- and "HasISearch" = 0
--  and "User_Level_TM" = 1
--  and "User_Level_OpenWeb" = 1
-- and
--  (integrated_search_opt_out = 0 AND integrated_profile_opt_out = 0)
-- AND
--   ("User_Level_OpenWeb" = 1 OR "User_Level_TM" = 1)
--  AND (integrated_profile_opt_out = 1 OR integrated_search_opt_out = 1)
pst_grp_name in (select groupname from ts40gamigration where wave = '2')
--  and pst_grp_name in ('91080200', '90995879', '10106532')
--and ("GROUP_ALLOW_Integrated_Profile" = 1 AND "GROUP_ALLOW_Integrated_Search" = 1)
order by pst_grp_name, "Search Type";

