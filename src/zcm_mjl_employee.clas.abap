CLASS zcm_mjl_employee DEFINITION PUBLIC
  INHERITING FROM cx_static_check FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    " Interfaces
    INTERFACES if_abap_behv_message.
    INTERFACES if_t100_message.
    INTERFACES if_t100_dyn_msg.

    " Message Constants
    CONSTANTS:
      BEGIN OF HRequest_Accepted,
        msgid TYPE symsgid      VALUE 'Z_MJL_EMPLOYEE',
        msgno TYPE symsgno      VALUE '001',
        attr1 TYPE scx_attrname VALUE 'HRequest_Id',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF hrequest_accepted.

    CONSTANTS:
      BEGIN OF HRequest_Declined,
        msgid TYPE symsgid      VALUE 'Z_MJL_EMPLOYEE',
        msgno TYPE symsgno      VALUE '002',
        attr1 TYPE scx_attrname VALUE 'HRequest_Id',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF HRequest_Declined.

    CONSTANTS:
      BEGIN OF HRequest_Already_Accepted,
        msgid TYPE symsgid      VALUE 'Z_MJL_EMPLOYEE',
        msgno TYPE symsgno      VALUE '003',
        attr1 TYPE scx_attrname VALUE 'HRequest_Id',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF HRequest_Already_Accepted.

    CONSTANTS:
      BEGIN OF HRequest_Already_Declined,
        msgid TYPE symsgid      VALUE 'Z_MJL_EMPLOYEE',
        msgno TYPE symsgno      VALUE '004',
        attr1 TYPE scx_attrname VALUE 'HRequest_Id',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF HRequest_Already_Declined.

  CONSTANTS:
      BEGIN OF NotEnoughVacDays,
        msgid TYPE symsgid      VALUE 'Z_MJL_EMPLOYEE',
        msgno TYPE symsgno      VALUE '005',
        attr1 TYPE scx_attrname VALUE 'Employee_Id',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF NotEnoughVacDays.

       CONSTANTS:
      BEGIN OF EndBeforeStart,
        msgid TYPE symsgid      VALUE 'Z_MJL_EMPLOYEE',
        msgno TYPE symsgno      VALUE '006',
        attr1 TYPE scx_attrname VALUE 'Employee_Id',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF EndBeforeStart.



    " Constructor
    METHODS constructor
      IMPORTING
        severity    TYPE if_abap_behv_message=>t_severity DEFAULT if_abap_behv_message=>severity-error
        textid      LIKE if_t100_message=>t100key         DEFAULT if_t100_message=>default_textid
        !previous   LIKE previous                        OPTIONAL
        HRequest_Id TYPE sysuuid_x16                          OPTIONAL
        Employee_Id TYPE sysuuid_x16 OPTIONAL.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA hrequest_id TYPE sysuuid_x16.
    DATA employee_id type sysuuid_x16.

ENDCLASS.

CLASS zcm_mjl_employee IMPLEMENTATION.
  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).

    if_t100_message~t100key = textid.
    if_abap_behv_message~m_severity = severity.
    me->HRequest_Id = HRequest_Id.
    me->Employee_Id = employee_id.
  ENDMETHOD.
ENDCLASS.
