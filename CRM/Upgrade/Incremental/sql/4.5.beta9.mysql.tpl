{* file to handle db changes in 4.5.beta9 during upgrade *}

-- CRM-15211
UPDATE `civicrm_dashboard` SET `permission` = 'access my cases and activities,access all cases and activities', `permission_operator` = 'OR' WHERE `name` = 'casedashboard';

-- CRM-15218
UPDATE `civicrm_uf_group` SET name = LOWER(name) WHERE name IN ("New_Individual", "New_Organization", "New_Household");

-- CRM-15220
UPDATE `civicrm_navigation` SET url = 'civicrm/admin/options/grant_type?reset=1' WHERE url = 'civicrm/admin/options/grant_type&reset=1';

SELECT @parent_id := `id` FROM `civicrm_navigation` WHERE `name` = 'CiviGrant' AND `domain_id` = {$domainID};
INSERT INTO civicrm_navigation
( domain_id, url, label, name, permission, permission_operator, parent_id, is_active, has_separator, weight )
VALUES
( {$domainID}, 'civicrm/admin/options/grant_status?reset=1', '{ts escape="sql" skip="true"}Grant Status{/ts}', 'Grant Status', 'access CiviGrant,administer CiviCRM', 'AND', @parent_id, '1', NULL, 2 );