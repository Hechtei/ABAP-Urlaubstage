CLASS lhc_Employee DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Employee RESULT result.

    METHODS determinestatus FOR DETERMINE ON MODIFY
      IMPORTING keys FOR hrequest~determinestatus.

    METHODS AcceptHRequest FOR MODIFY
      IMPORTING keys FOR ACTION hrequest~AcceptHRequest RESULT result.

    METHODS get_instance_authorizations_1 FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR HREQUEST RESULT result.

    METHODS declinehrequest FOR MODIFY
      IMPORTING keys FOR ACTION hrequest~declinehrequest RESULT result.

    METHODS determineuseddays FOR DETERMINE ON MODIFY
      IMPORTING keys FOR hrequest~determineuseddays.

    METHODS validatedays FOR VALIDATE ON SAVE
      IMPORTING keys FOR hrequest~validatedays.

    METHODS validatedate FOR VALIDATE ON SAVE
      IMPORTING keys FOR hrequest~validatedate.






ENDCLASS.

CLASS lhc_Employee IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  "Automatische Status-Generierung

  METHOD determinestatus.

    "Read HRequests

    READ ENTITY IN LOCAL MODE zr_mjl_hrequest
            FIELDS ( HrequestStatus )
            WITH CORRESPONDING #( keys )
            RESULT DATA(hrequests).

    "Modify HRequests

    MODIFY ENTITY IN LOCAL MODE zr_mjl_hrequest
            UPDATE FIELDS ( HrequestStatus )
            WITH VALUE #( FOR r IN hrequests
                            ( %tky = r-%tky
                                HrequestStatus = 'R' ) ).

  ENDMETHOD.



  METHOD AcceptHRequest.

    DATA message TYPE REF TO zcm_mjl_employee.


    " Read Hrequest
    READ ENTITY IN LOCAL MODE ZR_MJL_HREQUEST
         ALL FIELDS
         WITH CORRESPONDING #( keys )
         RESULT DATA(hrequests).

    " Process Hrequest

    LOOP AT hrequests REFERENCE INTO DATA(hrequest).
      " Validate Status and Create Error Message
      IF hrequest->HrequestStatus = 'A'.
        message = NEW zcm_mjl_employee( textid = zcm_mjl_employee=>hrequest_already_accepted
                                  hrequest_id = hrequest->HRequestId ).
        APPEND VALUE #( %tky     = hrequest->%tky
                        %element = VALUE #( HrequestStatus = if_abap_behv=>mk-on )
                        %msg     = message ) TO reported-hrequest.
        APPEND VALUE #( %tky = hrequest->%tky ) TO failed-hrequest.
        DELETE hrequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

       IF hrequest->HrequestStatus = 'D'.
        message = NEW zcm_mjl_employee( textid = zcm_mjl_employee=>hrequest_already_declined
                                  hrequest_id = hrequest->HRequestId ).
        APPEND VALUE #( %tky     = hrequest->%tky
                        %element = VALUE #( HrequestStatus = if_abap_behv=>mk-on )
                        %msg     = message ) TO reported-hrequest.
        APPEND VALUE #( %tky = hrequest->%tky ) TO failed-hrequest.
        DELETE hrequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      " Set Status to Cancelled and Create Success Message
      hrequest->HrequestStatus = 'A'.
      message = NEW zcm_mjl_employee( severity = if_abap_behv_message=>severity-success
                                textid   = zcm_mjl_employee=>hrequest_accepted
                                hrequest_id   = hrequest->HRequestId ).
      APPEND VALUE #( %tky     = hrequest->%tky
                      %element = VALUE #( HrequestStatus = if_abap_behv=>mk-on )
                      %msg     = message ) TO reported-hrequest.
    ENDLOOP.

    " Modify Travels
    MODIFY ENTITY IN LOCAL MODE ZR_MJL_HREQUEST
           UPDATE FIELDS ( HrequestStatus )
           WITH VALUE #( FOR t IN hrequests
                         ( %tky = t-%tky HrequestStatus = t-HrequestStatus ) ).

    " Set Result
    result = VALUE #( FOR t IN Hrequests
                      ( %tky   = t-%tky
                        %param = t ) ).


  ENDMETHOD.

  METHOD get_instance_authorizations_1.
  ENDMETHOD.

  METHOD DeclineHRequest.

  DATA message TYPE REF TO zcm_mjl_employee.


    " Read Hrequest
    READ ENTITY IN LOCAL MODE ZR_MJL_HREQUEST
         ALL FIELDS
         WITH CORRESPONDING #( keys )
         RESULT DATA(hrequests).

    " Process Hrequest

    LOOP AT hrequests REFERENCE INTO DATA(hrequest).
      " Validate Status and Create Error Message
      IF hrequest->HrequestStatus = 'D'.
        message = NEW zcm_mjl_employee( textid = zcm_mjl_employee=>hrequest_already_declined
                                  hrequest_id = hrequest->HRequestId ).
        APPEND VALUE #( %tky     = hrequest->%tky
                        %element = VALUE #( HrequestStatus = if_abap_behv=>mk-on )
                        %msg     = message ) TO reported-hrequest.
        APPEND VALUE #( %tky = hrequest->%tky ) TO failed-hrequest.
        DELETE hrequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      IF hrequest->HrequestStatus = 'A'.
        message = NEW zcm_mjl_employee( textid = zcm_mjl_employee=>hrequest_already_accepted
                                  hrequest_id = hrequest->HRequestId ).
        APPEND VALUE #( %tky     = hrequest->%tky
                        %element = VALUE #( HrequestStatus = if_abap_behv=>mk-on )
                        %msg     = message ) TO reported-hrequest.
        APPEND VALUE #( %tky = hrequest->%tky ) TO failed-hrequest.
        DELETE hrequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      " Set Status to Cancelled and Create Success Message
      hrequest->HrequestStatus = 'D'.
      message = NEW zcm_mjl_employee( severity = if_abap_behv_message=>severity-success
                                textid   = zcm_mjl_employee=>hrequest_declined
                                hrequest_id   = hrequest->HRequestId ).
      APPEND VALUE #( %tky     = hrequest->%tky
                      %element = VALUE #( HrequestStatus = if_abap_behv=>mk-on )
                      %msg     = message ) TO reported-hrequest.
    ENDLOOP.

    " Modify Travels
    MODIFY ENTITY IN LOCAL MODE ZR_MJL_HREQUEST
           UPDATE FIELDS ( HrequestStatus )
           WITH VALUE #( FOR t IN hrequests
                         ( %tky = t-%tky HrequestStatus = t-HrequestStatus ) ).

    " Set Result
    result = VALUE #( FOR t IN Hrequests
                      ( %tky   = t-%tky
                        %param = t ) ).

  ENDMETHOD.



  METHOD DetermineUsedDays.

    try.
        data(calendar) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime( 'SAP_DE_BW' ).

    "Read Entities

  READ ENTITY IN LOCAL MODE zr_mjl_hrequest
            FIELDS ( HrequestDays HrequestStartdate HrequestEnddate )
            WITH CORRESPONDING #( keys )
            RESULT DATA(hrequests).

                MODIFY ENTITY IN LOCAL MODE zr_mjl_hrequest
                UPDATE FIELDS ( HrequestDays )
                WITH VALUE #( FOR r IN hrequests
                            (  %tky = r-%tky
                                HrequestDays = 1 + calendar->calc_workingdays_between_dates( iv_start = r-HrequestStartdate iv_end = r-HrequestEnddate ) ) ).
       catch cx_fhc_runtime.
    endtry.
  ENDMETHOD.

  METHOD ValidateDays.

     DATA message TYPE REF TO zcm_mjl_employee.

        READ ENTITY IN LOCAL MODE zr_mjl_hrequest
         FIELDS ( HrequestStartdate HrequestEnddate ApplicantUuid )
         WITH CORRESPONDING #( keys )
         RESULT DATA(hrequests).


    LOOP AT hrequests REFERENCE INTO DATA(hrequest).
      " Validate Status and Create Error Message

      try.
          DATA(calendar) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime( 'SAP_DE_BW' ).
          DATA(working_days) =  calendar->calc_workingdays_between_dates( iv_start = hrequest->HrequestStartdate iv_end = hrequest->HrequestEnddate  ).
        catch cx_fhc_runtime.
          "handle exception
      endtry.
      SELECT FROM zr_mjl_employee
            Fields UsableDays
            where EmployeeUuid = @hrequest->ApplicantUuid
            INTO @DATA(usabledays).
       ENDSELECT.


      IF usabledays <= working_days.

        message = NEW zcm_mjl_employee( textid = zcm_mjl_employee=>notenoughvacdays
                                  hrequest_id = hrequest->HRequestId ).
        APPEND VALUE #( %tky     = hrequest->%tky
                        %element = VALUE #( HrequestStatus = if_abap_behv=>mk-on )
                        %msg     = message ) TO reported-hrequest.
        APPEND VALUE #( %tky = hrequest->%tky ) TO failed-hrequest.
        DELETE hrequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD ValidateDate.
      DATA message TYPE REF TO zcm_mjl_employee.

        READ ENTITY IN LOCAL MODE zr_mjl_hrequest
         FIELDS ( HrequestStartdate HrequestEnddate )
         WITH CORRESPONDING #( keys )
         RESULT DATA(hrequests).

    LOOP AT hrequests REFERENCE INTO DATA(hrequest).
      " Validate Status and Create Error Message

      IF hrequest->HrequestEnddate < hrequest->HrequestStartdate.
        message = NEW zcm_mjl_employee( textid = zcm_mjl_employee=>endbeforestart
                                  hrequest_id = hrequest->HRequestId ).
        APPEND VALUE #( %tky     = hrequest->%tky
                        %element = VALUE #( HrequestStatus = if_abap_behv=>mk-on )
                        %msg     = message ) TO reported-hrequest.
        APPEND VALUE #( %tky = hrequest->%tky ) TO failed-hrequest.
        DELETE hrequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
