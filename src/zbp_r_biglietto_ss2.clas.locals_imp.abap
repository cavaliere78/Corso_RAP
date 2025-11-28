CLASS lhc_zrcomponentiss DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR ZrComponentiSs RESULT result.

ENDCLASS.

CLASS lhc_zrcomponentiss IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

ENDCLASS.

CLASS LHC_ZR_BIGLIETTO_SS2 DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR Biglietto
        RESULT result,
      earlynumbering_create FOR NUMBERING
            IMPORTING entities FOR CREATE Biglietto,
      CheckStatus FOR VALIDATE ON SAVE
            IMPORTING keys FOR Biglietto~CheckStatus,
      GetDefaultsForCreate FOR READ
            IMPORTING keys FOR FUNCTION Biglietto~GetDefaultsForCreate RESULT result,
      get_instance_features FOR INSTANCE FEATURES
            IMPORTING keys REQUEST requested_features FOR Biglietto RESULT result,
      det1 FOR DETERMINE ON SAVE
            IMPORTING keys FOR Biglietto~det1,
      LogicDel FOR MODIFY
            IMPORTING keys FOR ACTION Biglietto~LogicDel RESULT result,
      earlynumbering_cba_Componenti FOR NUMBERING
            IMPORTING entities FOR CREATE Biglietto\_Componenti.
ENDCLASS.

CLASS LHC_ZR_BIGLIETTO_SS2 IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD earlynumbering_create.
    DATA:
        lv_id TYPE zr_biglietto_gf2-IdBiglietto.
*    WITH +big AS (
*        SELECT MAX( Idbiglietto ) AS id_max
*            FROM zr_biglietto_gf2
*        UNION
*        SELECT MAX( Idbiglietto ) AS id_max
*            FROM zbiglietto_gf2_d
*        )
*        SELECT MAX( id_max )
*            FROM +big AS big
*            INTO @DATA(lv_max).
*    SELECT MAX( Idbiglietto )
*        FROM zr_biglietto_gf2
*        INTO @DATA(lv_max).
    LOOP AT entities
            INTO DATA(ls_entity).
      IF ls_entity-zid IS INITIAL.
*        DATA(lo_get_number) = cl_numberrange_buffer=>get_instance(  ).
*        lo_get_number->if_numberrange_buffer~number_get_no_buffer(
*            EXPORTING
*                iv_ignore_buffer = 'X'
*                iv_object    = 'ZID_BIG_GF'
*                iv_interval  = '01'
*                iv_quantity  = 1
*            IMPORTING
*                ev_number    = DATA(lv_max) ).
*      try.
        cl_numberrange_runtime=>number_get(
          EXPORTING
*            ignore_buffer     = ' '
            nr_range_nr       = '01'
            object            = 'ZID_BIG_SS'
            quantity          = 1
*            subobject         =
*            toyear            =
          IMPORTING
            number            = data(lv_max)
*            returncode        =
*            returned_quantity =
        ).
*        CATCH cx_nr_object_not_found.
*        CATCH cx_number_ranges.
*        endtry.
*        lv_max += 1.
        lv_id = lv_max.
      ELSE.
        lv_id = ls_entity-Zid.
      ENDIF.
      APPEND VALUE #(
              %cid = ls_entity-%cid
              %is_draft = ls_entity-%is_draft
              Zid = lv_id
          )
          TO mapped-biglietto.
    ENDLOOP.
  ENDMETHOD.

  METHOD CheckStatus.
    DATA: lt_biglietto TYPE TABLE FOR READ RESULT zr_biglietto_ss2.
    READ ENTITIES OF zr_biglietto_ss2
    IN LOCAL MODE
    ENTITY Biglietto
    FIELDS ( Stato )
    WITH CORRESPONDING #( keys )
    RESULT lt_biglietto .

    LOOP AT lt_biglietto ASSIGNING FIELD-SYMBOL(<lfs_big>)
            WHERE Stato <> 'BOZZA' and
                  Stato <> 'FINALE' and
                  Stato <> 'CANC'.
      APPEND VALUE #(
          %tky = <lfs_big>-%tky
        ) TO failed-biglietto.
      APPEND VALUE #(
          %tky = <lfs_big>-%tky
          %msg = neW zcx_error_bigl_ss(
            textid   = zcx_error_bigl_ss=>gc_invalid_status
            severiry = if_abap_behv_message=>severity-error
*        previous =
        iv_stato = <lfs_big>-stato )
        %element-Stato = if_abap_behv=>mk-on

        ) TO reported-biglietto.

    ENDLOOP.

  ENDMETHOD.

  METHOD GetDefaultsForCreate.
    result = VALUE #( FOR key IN keys (
                 %cid = key-%cid
                 %param-stato = 'BOZZA'
                  ) ).

  ENDMETHOD.

  METHOD get_instance_features.
*    DATA: lt_biglietto TYPE TABLE FOR READ RESULT zr_biglietto_ss2.
*    READ ENTITIES OF zr_biglietto_ss2
*    IN LOCAL MODE
*    ENTITY Biglietto
*    FIELDS ( Stato )
*    WITH CORRESPONDING #( keys )
*   RESULT lt_biglietto.
*
*    LOOP AT lt_biglietto ASSIGNING FIELD-SYMBOL(<lfs_big>).
*      APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<lfs_result>).
*      <lfs_result>-%tky = <lfs_big>-%tky.
*      <lfs_result>-%field-Stato = if_abap_behv=>fc-f-read_only.
*    ENDLOOP.
*
*


DATA: lt_biglietto TYPE TABLE FOR READ RESULT zr_biglietto_ss2.

  " Leggi lo stato dei record
  READ ENTITIES OF zr_biglietto_ss2
    IN LOCAL MODE
    ENTITY Biglietto
      FIELDS ( Stato )
      WITH CORRESPONDING #( keys )
    RESULT lt_biglietto.

  LOOP AT lt_biglietto ASSIGNING FIELD-SYMBOL(<lfs_big>).
    APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<lfs_result>).
    <lfs_result>-%tky = <lfs_big>-%tky.
    " Rendi il campo Stato sempre read-only
    <lfs_result>-%field-Stato = if_abap_behv=>fc-f-read_only.

    " Disabilita l'action LogicDel se Stato = 'CANC'
    IF <lfs_big>-Stato = 'CANC'.
      <lfs_result>-%action-LogicDel = if_abap_behv=>fc-o-disabled.
    ENDIF.
  ENDLOOP.



  ENDMETHOD.

  METHOD det1.

    DATA:
        lt_update TYPE TABLE FOR UPDATE zr_biglietto_ss2.
    READ ENTITIES OF zr_biglietto_ss2
        IN LOCAL MODE
        ENTITY Biglietto
        FIELDS ( Stato )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_biglietto).
    LOOP AT lt_biglietto
            INTO DATA(ls_biglietto)
            WHERE stato = 'BOZZA'.
      APPEND VALUE #(
              %tky = ls_biglietto-%tky
              Stato = 'FINALE'
              %control-Stato = if_abap_behv=>mk-on )
              TO lt_update.
    ENDLOOP.

    IF lt_update IS NOT INITIAL.
      MODIFY ENTITIES OF zr_biglietto_ss2
          IN LOCAL MODE
          ENTITY Biglietto
          UPDATE FROM lt_update.
    ENDIF.
*            UPDATE FROM VALUE #(  (
*                %tky = ls_biglietto-%tky
*                Stato = 'FINALE'
*                %control-Stato = if_abap_behv=>mk-on ) ).

  ENDMETHOD.

  METHOD LogicDel.
    DATA: lt_biglietto TYPE TABLE FOR READ RESULT zr_biglietto_ss2.
    READ ENTITIES OF zr_biglietto_ss2
    IN LOCAL MODE
    ENTITY Biglietto
    all FIELDS
    WITH CORRESPONDING #( keys )
    RESULT lt_biglietto .

" 2) Prepara l’update per la cancellazione logica
  DATA lt_update TYPE TABLE FOR UPDATE zr_biglietto_ss2.

  lt_update = VALUE #( FOR ls IN lt_biglietto
                       ( %tky  = ls-%tky
                         Stato = 'CANC'
                         %control-Stato = if_abap_behv=>mk-on
                          ) ).

  " 3) Esegui l’update con MODIFY ENTITIES
*  DATA failed   TYPE TABLE FOR FAILED   zr_biglietto_ss2.
*  DATA reported TYPE TABLE FOR REPORTED zr_biglietto_ss2.

  MODIFY ENTITIES OF zr_biglietto_ss2
    IN LOCAL MODE
    ENTITY Biglietto
      UPDATE FIELDS ( Stato )
      WITH lt_update.
*    FAILED   failed
*    REPORTED reported.

  " 4) Popola il result (chiavi dei record toccati) e il mapped (per i framework consumer)
  LOOP AT lt_biglietto ASSIGNING FIELD-SYMBOL(<lfs_big>).
  <lfs_big>-Stato = 'CANC'.
    APPEND INITIAL LINE TO result ASSIGNING FIELD-SYMBOL(<lf_res>).
    <lf_res>-%tky           = <lfs_big>-%tky.
    <lf_res>-%param   = <lfs_big>.

*    APPEND INITIAL LINE TO mapped-biglietto ASSIGNING FIELD-SYMBOL(<lf_mbi>).
*    <lf_mbi>-%tky = <lfs_big>-%tky.
  ENDLOOP.






*
*    DATA:
*      lt_update TYPE TABLE FOR UPDATE zr_biglietto_gf2,
*      ls_update LIKE LINE OF lt_update.
*
*    READ ENTITIES OF zr_biglietto_gf2
*        IN LOCAL MODE
*        ENTITY Biglietto
*        ALL FIELDS
*        WITH CORRESPONDING #( keys )
*        RESULT DATA(lt_biglietto).
*    LOOP AT lt_biglietto
*            ASSIGNING FIELD-SYMBOL(<biglietto>).
*      <biglietto>-Stato = 'CANC'.
*      APPEND VALUE #(
*              %tky = <biglietto>-%tky
*              %param = <biglietto> )
*          TO result.
*      ls_update = CORRESPONDING #( <biglietto> ).
*      ls_update-%control-Stato = if_abap_behv=>mk-on.
*      APPEND ls_update
*        TO lt_update.
*    ENDLOOP.
*
*    MODIFY ENTITIES OF zr_biglietto_gf2
*        IN LOCAL MODE
*        ENTITY Biglietto
*        UPDATE FROM lt_update.




  ENDMETHOD.

  METHOD earlynumbering_cba_Componenti.
    DATA:
        ls_mapped LIKE LINE OF mapped-zrcomponentiss.
    READ ENTITIES OF zr_biglietto_ss2
        IN LOCAL MODE
        ENTITY Biglietto BY \_Componenti
        FIELDS ( Progressivo )
        WITH
        VALUE #( FOR line
            IN entities
            (
                Zid = line-Zid
                %is_draft   = line-%is_draft
            )
             )
        RESULT DATA(travels).
    SELECT MAX( Progressivo )
       FROM @travels AS travel
       INTO @DATA(lv_progr).

    LOOP AT entities
            INTO DATA(ls_entity).
      LOOP AT ls_entity-%target
          INTO DATA(target).
        lv_progr += 1.
        CLEAR ls_mapped.
        ls_mapped-%cid        = target-%cid.
        ls_mapped-%is_draft   = target-%is_draft.
        ls_mapped-Zid = target-zid.
        ls_mapped-Progressivo = lv_progr.
        APPEND ls_mapped
            TO mapped-zrcomponentiss.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
