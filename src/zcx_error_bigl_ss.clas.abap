CLASS zcx_error_bigl_ss DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_abap_behv_message .
    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

    CONSTANTS:
      gc_mess_class TYPE sy-msgid VALUE 'ZERROR_BIGL_GF',
      BEGIN OF gc_invalid_status,
        msgid TYPE symsgid VALUE gc_mess_class,
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'GV_STATO',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF gc_invalid_status.
    DATA:
        gv_stato TYPE zr_biglietto_ss2-stato.

    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL
        !severiry type if_abap_behv_message=>t_severity
        iv_stato  TYPE zr_biglietto_ss2-Stato OPTIONAL.
PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcx_error_bigl_ss IMPLEMENTATION.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor(
    previous = previous
    ).
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
    if_abap_behv_message~m_severity = severiry.
        gv_stato = iv_stato.

  ENDMETHOD.
ENDCLASS.



