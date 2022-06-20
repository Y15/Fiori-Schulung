CLASS ztcs_cl_selection_profile DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ztcs_cl_selection_profile IMPLEMENTATION.
  METHOD if_rap_query_provider~select.

    DATA lt_response TYPE STANDARD TABLE OF ztcs_selection_profile.
    DATA lt_sel_param TYPE /bobf/t_frw_query_selparam.
    DATA lO_PLS_SRV_MGR TYPE REF TO /bobf/if_tra_service_manager .
    DATA lt_pls_root TYPE /scmtms/t_pls_root_k.

    DATA(lv_top)     = io_request->get_paging( )->get_page_size( ).
    DATA(lv_skip)    = io_request->get_paging( )->get_offset( ).
    DATA(lt_fields)  = io_request->get_requested_elements( ).
    DATA(lt_sort)    = io_request->get_sort_elements( ).
    DATA(lt_parameters) = io_request->get_parameters( ).
    DATA(lt_filter) = io_request->get_filter( ).

    "/SCMTMS/CL_UI_PLS_LIST_OVW GET_PROF_LAYOUT_SETS
    APPEND VALUE /bobf/s_frw_query_selparam(
      attribute_name = /scmtms/if_pls_c=>sc_query_attribute-root-query_by_attributes-context
      sign           = /bobf/if_conf_c=>sc_sign_option_including
      option         = /bobf/if_conf_c=>sc_sign_equal
      low            = 0 ) TO lt_sel_param. "mv_context

    APPEND VALUE /bobf/s_frw_query_selparam(
      attribute_name = /scmtms/if_pls_c=>sc_query_attribute-root-query_by_attributes-user_id
      sign           = /bobf/if_conf_c=>sc_sign_option_including
      option         = /bobf/if_conf_c=>sc_sign_equal
      low            = sy-uname ) TO lt_sel_param. "Only show Selection profiles 4 user


    lo_pls_srv_mgr = /bobf/cl_tra_serv_mgr_factory=>get_service_manager( /scmtms/if_pls_c=>sc_bo_key ).

    lo_pls_srv_mgr->query(
      EXPORTING
        iv_query_key            = /scmtms/if_pls_c=>sc_query-root-query_by_attributes
        it_selection_parameters = lt_sel_param
        iv_fill_data            = abap_true
      IMPORTING
        et_data                 = lt_pls_root ).


    IF lt_pls_root[] IS NOT INITIAL.
*  /SCMTMS/CL_UI_PLS_LIST_OVW->start_planning

      lt_response = CORRESPONDING #( lt_pls_root MAPPING db_key = key
                                                         reqprof_id  = fu_sel_profile
                                                         tuprof_id   = tu_sel_profile
                                                         coprof_id   = co_sel_profile
                                                         planprof_id = pln_profile
                                                         torprof_id  = fo_sel_profile
                                                         fbprof_id   = fb_sel_profile
                                                         capaprof_id = capa_profile
                                                         tspsset_id  = tsps_settings
                                                         incset_id   = inc_profile
                                                         dlvprof_id  = dlv_profile ).

    ENDIF.

    io_response->set_total_number_of_records( lines( lt_response ) ).
    io_response->set_data( lt_response ).

  ENDMETHOD.

ENDCLASS.
