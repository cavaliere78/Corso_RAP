CLASS zcl_create_interval_ss DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_create_interval_ss IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  cl_numberrange_intervals=>create(
    EXPORTING
      interval  =  value #( ( nrrangenr  = '01'
                              fromnumber = '00000001'
                              tonumber   = '19999999'
                              procind    = 'I'
                           ) )



      object    = 'ZID_BIG_SS'
*      subobject =
*      option    =
*    IMPORTING
*      error     =
*      error_inf =
*      error_iv  =
*      warning   =
  ).
*  CATCH cx_nr_object_not_found.
*  CATCH cx_number_ranges.
*  CATCH cx_nr_object_not_found.
*  CATCH cx_number_ranges.


  ENDMETHOD.
ENDCLASS.
