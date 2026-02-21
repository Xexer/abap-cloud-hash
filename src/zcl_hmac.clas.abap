CLASS zcl_hmac DEFINITION
  PUBLIC
  INHERITING FROM zcl_hash_base FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_hash.

    METHODS constructor
      IMPORTING algorithm TYPE zif_hash=>algorithms
                !key      TYPE xstring.

  PRIVATE SECTION.
    DATA key  TYPE xstring.
    DATA hmac TYPE REF TO cl_abap_hmac.

ENDCLASS.


CLASS zcl_hmac IMPLEMENTATION.
  METHOD constructor.
    super->constructor( algorithm ).
    me->key = key.

    TRY.
        hmac = cl_abap_hmac=>get_instance( if_algorithm = get_algorithm( )
                                           if_key       = key ).

      CATCH cx_abap_message_digest INTO DATA(message_error).
        RAISE EXCEPTION NEW zcx_hash_error( previous = message_error ).
    ENDTRY.
  ENDMETHOD.


  METHOD zif_hash~get_hash_for_string.
    TRY.
        hmac->calculate_hmac_for_char( EXPORTING if_algorithm     = get_algorithm( )
                                                 if_key           = key
                                                 if_data          = value
                                       IMPORTING ef_hmacstring    = result-hashstring
                                                 ef_hmacxstring   = result-hashxstring
                                                 ef_hmacb64string = result-hashb64string ).

      CATCH cx_abap_message_digest INTO DATA(message_error).
        RAISE EXCEPTION NEW zcx_hash_error( previous = message_error ).
    ENDTRY.
  ENDMETHOD.


  METHOD zif_hash~get_hash_for_xstring.
    TRY.
        hmac->calculate_hmac_for_raw( EXPORTING if_algorithm     = get_algorithm( )
                                                if_key           = key
                                                if_data          = value
                                      IMPORTING ef_hmacstring    = result-hashstring
                                                ef_hmacxstring   = result-hashxstring
                                                ef_hmacb64string = result-hashb64string ).

      CATCH cx_abap_message_digest INTO DATA(message_error).
        RAISE EXCEPTION NEW zcx_hash_error( previous = message_error ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
