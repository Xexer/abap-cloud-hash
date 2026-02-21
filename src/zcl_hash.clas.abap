CLASS zcl_hash DEFINITION
  PUBLIC
  INHERITING FROM zcl_hash_base FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_hash_factory.

  PUBLIC SECTION.
    INTERFACES zif_hash.

    METHODS constructor
      IMPORTING algorithm TYPE zif_hash=>algorithms.

  PRIVATE SECTION.
    DATA message_digest TYPE REF TO cl_abap_message_digest.
ENDCLASS.


CLASS zcl_hash IMPLEMENTATION.
  METHOD constructor.
    super->constructor( algorithm ).

    TRY.
        message_digest = cl_abap_message_digest=>get_instance( get_algorithm( ) ).

      CATCH cx_abap_message_digest INTO DATA(message_error).
        RAISE EXCEPTION NEW zcx_hash_error( previous = message_error ).
    ENDTRY.
  ENDMETHOD.


  METHOD zif_hash~get_hash_for_string.
    TRY.
        message_digest->calculate_hash_for_char( EXPORTING if_algorithm     = get_algorithm( )
                                                           if_data          = value
                                                 IMPORTING ef_hashstring    = result-hashstring
                                                           ef_hashxstring   = result-hashxstring
                                                           ef_hashb64string = result-hashb64string ).

      CATCH cx_abap_message_digest INTO DATA(message_error).
        RAISE EXCEPTION NEW zcx_hash_error( previous = message_error ).
    ENDTRY.
  ENDMETHOD.


  METHOD zif_hash~get_hash_for_xstring.
    TRY.
        message_digest->calculate_hash_for_raw( EXPORTING if_algorithm     = get_algorithm( )
                                                          if_data          = value
                                                IMPORTING ef_hashstring    = result-hashstring
                                                          ef_hashxstring   = result-hashxstring
                                                          ef_hashb64string = result-hashb64string ).

      CATCH cx_abap_message_digest INTO DATA(message_error).
        RAISE EXCEPTION NEW zcx_hash_error( previous = message_error ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
