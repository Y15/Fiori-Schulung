@EndUserText.label: 'Selection Profile: Read Keys'
@ObjectModel: {
    query: {
        implementedBy: 'ABAP:ZTCS_CL_SELECTION_PROFILE'
    }
}
define root custom entity ZTCS_SELECTION_PROFILE
{
  key db_key      : /bobf/conf_key;
      SEL_PROFILE : /scmtms/vsr_sel_profile_id;
      reqprof_id  : /scmtms/vsr_sel_profile_id;
      tuprof_id   : /scmtms/vsr_sel_profile_id;
      coprof_id   : /scmtms/vsr_cosel_profile_id;
      torprof_id  : /scmtms/vsr_sel_profile_id;
      fbprof_id   : /scmtms/vsr_sel_profile_id;
      planprof_id : /scmtms/vsr_planning_prof_id;
      capaprof_id : /scmtms/vsr_capa_profile_id;
      tspsset_id  : /scmtms/vsr_tsps_prof_id;
      incset_id   : /scmtms/incomp_settings_id;
      dlvprof_id  : /scmtms/dlv_prof_id;
      created_by  : /bofu/user_id_created_by;            
      _keys       : association [1..*] to ztcs_root_query on _keys.selection_Profile = $projection.db_key;
}
