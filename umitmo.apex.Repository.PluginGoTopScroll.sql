prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_210200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2021.10.15'
,p_release=>'21.2.0'
,p_default_workspace_id=>1478330507037203
,p_default_application_id=>103
,p_default_id_offset=>0
,p_default_owner=>'REPGEN'
);
end;
/
 
prompt APPLICATION 103 - app_dev
--
-- Application Export:
--   Application:     103
--   Name:            app_dev
--   Date and Time:   14:10 Tuesday March 28, 2023
--   Exported By:     MOKHTARI
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 46128592813910616
--   Manifest End
--   Version:         21.2.0
--   Instance ID:     697890166281865
--

begin
  -- replace components
  wwv_flow_api.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/dynamic_action/gotopscroll
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(46128592813910616)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'GOTOPSCROLL'
,p_display_name=>'umitmo.apex.Repository.PluginGoTopScroll'
,p_category=>'NAVIGATION'
,p_supported_ui_types=>'DESKTOP'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
' ',
'FUNCTION render_GoTopScroll (',
'    p_dynamic_action   IN apex_plugin.t_dynamic_action,',
'    p_plugin           IN apex_plugin.t_plugin)',
'    RETURN apex_plugin.t_dynamic_action_render_result',
'IS',
'    l_js_code   VARCHAR2 (4000) := p_dynamic_action.attribute_01;',
'    l_result      apex_plugin.t_dynamic_action_render_result;',
'BEGIN',
'    IF APEX_APPLICATION.g_debug',
'    THEN',
'        apex_plugin_util.debug_dynamic_action (',
'            p_plugin           => p_plugin,',
'            p_dynamic_action   => p_dynamic_action);',
'    END IF;',
'',
'    apex_css.add_file (p_name        => '''',',
'                       p_directory   => p_plugin.file_prefix,',
'                       p_version     => NULL);',
'    apex_javascript.add_library (p_name        => ''goTopScroll_JS'',',
'                                 p_directory   => p_plugin.file_prefix,',
'                                 p_version     => NULL);',
'                                 ',
' l_result.javascript_function := ''FncScrollTop'';',
' l_result.attribute_01 := l_js_code;',
' ',
' return l_result;',
' ',
'                           ',
'END render_GoTopScroll;'))
,p_api_version=>2
,p_render_function=>'render_GoTopScroll'
,p_standard_attributes=>'BUTTON'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'1.0'
,p_plugin_comment=>'Create dynamic action With Execute javascript code on a button for scroll up the current page.'
,p_files_version=>4
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(22968016062123217)
,p_plugin_id=>wwv_flow_api.id(46128592813910616)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Execute Javascript Code'
,p_attribute_type=>'JAVASCRIPT'
,p_is_required=>false
,p_default_value=>'$(''html,body'').animate({scrollTop: 0}, 2500);'
,p_supported_ui_types=>'DESKTOP'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(22980602726207593)
,p_plugin_id=>wwv_flow_api.id(46128592813910616)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Developer'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'Omid Mokhtari'
,p_is_translatable=>false
);
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
