CLASS z_ss_corso_rap DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS _m_test
      IMPORTING
        i_input         TYPE string
      RETURNING
        VALUE(r_result) TYPE char10.
ENDCLASS.



CLASS z_ss_corso_rap IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    out->write( _m_test( 'SS' )  ).
    SELECT agency_id, name, country_code FROM /dmo/agency
    INTO TABLE @DATA(lt_tab).
  ENDMETHOD.

  METHOD _m_test.
    r_result = |Ciao { i_input }|.
  ENDMETHOD.

ENDCLASS.
