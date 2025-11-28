CLASS zcl_insert_tipo_utente_ss DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_insert_tipo_utente_ss IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA:
        lt_tipo_utente TYPE TABLE OF ztipo_utente_ss
            WITH EMPTY KEY.

    DELETE FROM ztipo_utente_ss.
    lt_tipo_utente = VALUE #( (
        id = '00'
        descrizione = 'Bambino'
        limitazioni = 'Tra 8 e 12 anni'
        prezzo = '4'
        valuta = 'EUR' ) (
        id = '01'
        descrizione = 'Adulto'
        limitazioni = 'Tra 13 e 65 anni'
        prezzo = '8'
        valuta = 'EUR' ) (
        id = '02'
        descrizione = 'Anziano'
        limitazioni = '66+'
        prezzo = '3'
        valuta = 'EUR' ) ).
    INSERT ztipo_utente_ss
        FROM TABLE @lt_tipo_utente.
    IF sy-subrc IS INITIAL.
      COMMIT WORK AND WAIT.
      out->write(
        EXPORTING
          data   = lt_tipo_utente
          name   = 'OK'
*          RECEIVING
*            output =
      ).
    ELSE.
      ROLLBACK WORK.
      out->write(
        EXPORTING
          data   = lt_tipo_utente
          name   = 'KO'
*          RECEIVING
*            output =
      ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
