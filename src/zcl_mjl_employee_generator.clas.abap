CLASS zcl_mjl_employee_generator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.



CLASS zcl_mjl_employee_generator IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA employee  TYPE zmjl_employee.
    DATA employees TYPE TABLE OF zmjl_employee.

    DATA hrequest  TYPE zmjl_hrequest.
    DATA hrequests TYPE TABLE OF zmjl_hrequest.

    DATA hclaim  TYPE zmjl_hclaim.
    DATA hclaims TYPE TABLE OF zmjl_hclaim.

    DATA superiorHansMaier TYPE sysuuid_x16.
    DATA superiorPetraSchmid TYPE sysuuid_x16.

    "Delete Requests
    DELETE FROM zmjl_hrequest.

    "Delete Claims
    DELETE FROM zmjl_hclaim.

    " Delete Employees
    DELETE FROM zmjl_employee.
    out->write( |Deleted Employees: { sy-dbcnt }| ).


    "Create Employee: Lisa Müller

    GET TIME STAMP FIELD employee-created_at.
    GET TIME STAMP FIELD employee-last_changed_at.

    employee-employee_uuid      = cl_system_uuid=>create_uuid_x16_static(  ).
    employee-client = sy-mandt.
    employee-employee_nr        = '000002'   .
    employee-employee_firstname = 'Lisa'.
    employee-employee_lastname  = 'Müller'.
    employee-employee_entrydate = '20100701'.
    employee-created_by         = 'AdminUser'.
    employee-last_changed_by    = 'AdminUser'.

    APPEND employee TO employees.

    "HClaims Lisa Müller:

    GET TIME STAMP FIELD hclaim-created_at.
    GET TIME STAMP FIELD hclaim-last_changed_at.

    hclaim-employee_uuid = employee-employee_uuid.
    hclaim-hclaim_id = cl_system_uuid=>create_uuid_x16_static(  ).
    hclaim-client = sy-mandt.
    hclaim-hlcaim_days = 30.
    hclaim-hlcaim_year =  '2023'.
    hclaim-created_by         = 'AdminUser'.
    hclaim-last_changed_by    = 'AdminUser'.

    APPEND hclaim TO hclaims.

    superiorHansMaier = employee-employee_uuid.


    " Create Employee: Hans Maier

    GET TIME STAMP FIELD employee-created_at.
    GET TIME STAMP FIELD employee-last_changed_at.

    employee-employee_uuid      = cl_system_uuid=>create_uuid_x16_static(  ).
    employee-client = sy-mandt.
    employee-employee_nr        = '000001'.
    employee-employee_firstname = 'Hans'.
    employee-employee_lastname  = 'Maier'.
    employee-employee_entrydate = '20000501'.
    employee-created_by         = 'AdminUser'.
    employee-last_changed_by    = 'AdminUser'.

    APPEND employee TO employees.

    "HClaims Hans Mayer:

    GET TIME STAMP FIELD hclaim-created_at.
    GET TIME STAMP FIELD hclaim-last_changed_at.

    hclaim-employee_uuid = employee-employee_uuid.
    hclaim-hclaim_id = cl_system_uuid=>create_uuid_x16_static(  ).
    hclaim-client = sy-mandt.
    hclaim-hlcaim_days = 30.
    hclaim-hlcaim_year =  '2022'.
    hclaim-created_by         = 'AdminUser'.
    hclaim-last_changed_by    = 'AdminUser'.

    APPEND hclaim TO hclaims.

    GET TIME STAMP FIELD hclaim-created_at.
    GET TIME STAMP FIELD hclaim-last_changed_at.

    hclaim-employee_uuid = employee-employee_uuid.
    hclaim-hclaim_id = cl_system_uuid=>create_uuid_x16_static(  ).
    hclaim-client = sy-mandt.
    hclaim-hlcaim_days = 30.
    hclaim-hlcaim_year =  '2023'.
    hclaim-created_by         = 'AdminUser'.
    hclaim-last_changed_by    = 'AdminUser'.

    APPEND hclaim TO hclaims.

    "HRequests Hans Maier:

    GET TIME STAMP FIELD hrequest-created_at.
    GET TIME STAMP FIELD hrequest-last_changed_at.

    hrequest-applicant_uuid = employee-employee_uuid.
    hrequest-hrequest_id = cl_system_uuid=>create_uuid_x16_static(  ).
    hrequest-client = sy-mandt.
    hrequest-hrequest_comment = 'Sommerurlaub'.
    hrequest-hrequest_enddate = '20220710'.
    hrequest-hrequest_startdate = '20220701'.
    hrequest-hrequest_status = 'A'.
    hrequest-superior_uuid = superiorhansmaier.
    hrequest-created_by         = 'AdminUser'.
    hrequest-last_changed_by    = 'AdminUser'.
    hrequest-hreqeust_days = 6.

    APPEND hrequest TO hrequests.

    GET TIME STAMP FIELD hrequest-created_at.
    GET TIME STAMP FIELD hrequest-last_changed_at.

    hrequest-applicant_uuid = employee-employee_uuid.
    hrequest-hrequest_id = cl_system_uuid=>create_uuid_x16_static(  ).
    hrequest-client = sy-mandt.
    hrequest-hrequest_comment = 'Weihnachtsurlaub'.
    hrequest-hrequest_enddate = '20221230'.
    hrequest-hrequest_startdate = '20221227'.
    hrequest-hrequest_status = 'D'.
    hrequest-superior_uuid = superiorhansmaier.
    hrequest-created_by         = 'AdminUser'.
    hrequest-last_changed_by    = 'AdminUser'.
    hrequest-hreqeust_days = 4.

    APPEND hrequest TO hrequests.

    GET TIME STAMP FIELD hrequest-created_at.
    GET TIME STAMP FIELD hrequest-last_changed_at.

    hrequest-applicant_uuid = employee-employee_uuid.
    hrequest-hrequest_id = cl_system_uuid=>create_uuid_x16_static(  ).
    hrequest-client = sy-mandt.
    hrequest-hrequest_comment = 'Weihnachtsurlaub (2. Versuch)'.
    hrequest-hrequest_enddate = '20221230'.
    hrequest-hrequest_startdate = '20221228'.
    hrequest-hrequest_status = 'A'.
    hrequest-superior_uuid = superiorhansmaier.
    hrequest-created_by         = 'AdminUser'.
    hrequest-last_changed_by    = 'AdminUser'.
        hrequest-hreqeust_days = 3.


    APPEND hrequest TO hrequests.

    GET TIME STAMP FIELD hrequest-created_at.
    GET TIME STAMP FIELD hrequest-last_changed_at.

    hrequest-applicant_uuid = employee-employee_uuid.
    hrequest-hrequest_id = cl_system_uuid=>create_uuid_x16_static(  ).
    hrequest-client = sy-mandt.
    hrequest-hrequest_comment = ''.
    hrequest-hrequest_enddate = '20230614'.
    hrequest-hrequest_startdate = '20230527'.
    hrequest-hrequest_status = 'A'.
    hrequest-superior_uuid = superiorhansmaier.
    hrequest-created_by         = 'AdminUser'.
    hrequest-last_changed_by    = 'AdminUser'.
        hrequest-hreqeust_days = 12.

    APPEND hrequest TO hrequests.

    GET TIME STAMP FIELD hrequest-created_at.
    GET TIME STAMP FIELD hrequest-last_changed_at.

    hrequest-applicant_uuid = employee-employee_uuid.
    hrequest-hrequest_id = cl_system_uuid=>create_uuid_x16_static(  ).
    hrequest-client = sy-mandt.
    hrequest-hrequest_comment = 'Winterurlaub'.
    hrequest-hrequest_enddate = '20231231'.
    hrequest-hrequest_startdate = '20231220'.
    hrequest-hrequest_status = 'R'.
    hrequest-superior_uuid = superiorhansmaier.
    hrequest-created_by         = 'AdminUser'.
    hrequest-last_changed_by    = 'AdminUser'.
    hrequest-hreqeust_days = 6.

    APPEND hrequest TO hrequests.

    superiorPetraSchmid = employee-employee_uuid.


    "Create Employee: Petra Schmid

    GET TIME STAMP FIELD employee-created_at.
    GET TIME STAMP FIELD employee-last_changed_at.

    employee-employee_uuid      = cl_system_uuid=>create_uuid_x16_static(  ).
    employee-client = sy-mandt.
    employee-employee_nr        = '000003'   .
    employee-employee_firstname = 'Petra'.
    employee-employee_lastname  = 'Schmid'.
    employee-employee_entrydate = '20231001'.
    employee-created_by         = 'AdminUser'.
    employee-last_changed_by    = 'AdminUser'.

    APPEND employee TO employees.

    "HClaims Petra Schmid:

    GET TIME STAMP FIELD hclaim-created_at.
    GET TIME STAMP FIELD hclaim-last_changed_at.

    hclaim-employee_uuid = employee-employee_uuid.
    hclaim-hclaim_id = cl_system_uuid=>create_uuid_x16_static(  ).
    hclaim-client = sy-mandt.
    hclaim-hlcaim_days = 7.
    hclaim-hlcaim_year =  '2023'.
    hclaim-created_by         = 'AdminUser'.
    hclaim-last_changed_by    = 'AdminUser'.

    APPEND hclaim TO hclaims.

    "HRequests Petra Schmid:

    GET TIME STAMP FIELD hrequest-created_at.
    GET TIME STAMP FIELD hrequest-last_changed_at.

    hrequest-applicant_uuid = employee-employee_uuid.
    hrequest-hrequest_id = cl_system_uuid=>create_uuid_x16_static(  ).
    hrequest-client = sy-mandt.
    hrequest-hrequest_comment = 'Weihnachtsurlaub'.
    hrequest-hrequest_enddate = '20231231'.
    hrequest-hrequest_startdate = '20231227'.
    hrequest-hrequest_status = 'R'.
    hrequest-superior_uuid = superiorpetraschmid.
    hrequest-created_by         = 'AdminUser'.
    hrequest-last_changed_by    = 'AdminUser'.
    hrequest-hreqeust_days = 3.

    APPEND hrequest TO hrequests.

    " Insert Employees
    INSERT zmjl_employee FROM TABLE @employees.
    out->write( |Inserted Employees: { sy-dbcnt }| ).

    " Insert Requests
    INSERT zmjl_hrequest FROM TABLE @hrequests.
    out->write( |Inserted Requests: { sy-dbcnt }| ).

    " Insert Claims
    INSERT zmjl_hclaim FROM TABLE @hclaims.
    out->write( |Inserted Claims: { sy-dbcnt }| ).


  ENDMETHOD.




ENDCLASS.
