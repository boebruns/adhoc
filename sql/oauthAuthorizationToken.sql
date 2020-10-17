select client_id,
       refresh_token_validity,
       refresh_token_validity / 60 / 60 / 24 as DaysRefreshTokenLives,
       access_token_validity,
       access_token_validity / 60 / 60 / 24  as DaysAccessTokenLives,
       client_id,
       client_secret,
       ENCODE(CONVERT_TO(concat(client_id, ':', client_secret), 'UTF-8'), 'BASE64'),
       grant_types,
       approve_scopes,
       authorities,
       additional_info,
       pst_grp_id
--        oauth2_client_details.*
from oauth.oauth2_client_details
where 1 = 1
--     and client_id like 'dice-job-posting-integration-servic%'
  and (access_token_validity is not null or refresh_token_validity is not null)
