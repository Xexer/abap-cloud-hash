CLASS ltc_hash DEFINITION FINAL
  FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.

  PRIVATE SECTION.
    METHODS sha512_compare          FOR TESTING RAISING cx_static_check.
    METHODS sha384_compare          FOR TESTING RAISING cx_static_check.
    METHODS sha256_compare          FOR TESTING RAISING cx_static_check.
    METHODS wrong_dynamic_algorithm FOR TESTING RAISING cx_static_check.
    METHODS right_dynamic_algorithm FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltc_hash IMPLEMENTATION.
  METHOD wrong_dynamic_algorithm.
    TRY.
        zcl_hash_factory=>create_hash( algorithm = CONV #( 3 ) ).
        cl_abap_unit_assert=>fail( `Not supported` ).
      CATCH cx_root.
        cl_abap_unit_assert=>assert_true( abap_true ).
    ENDTRY.
  ENDMETHOD.


  METHOD right_dynamic_algorithm.
    TRY.
        zcl_hash_factory=>create_hash( algorithm = CONV #( 1 ) ).
        cl_abap_unit_assert=>assert_true( abap_true ).
      CATCH cx_root.
        cl_abap_unit_assert=>fail( `Not supported` ).
    ENDTRY.
  ENDMETHOD.


  METHOD sha256_compare.
    DATA(cut) = zcl_hash_factory=>create_hash( algorithm = zif_hash=>algorithm-sha256 ).

    DATA(result) = cut->get_hash_for_string( `123456` ).

    cl_abap_unit_assert=>assert_equals(
        exp = `8D969EEF6ECAD3C29A3A629280E686CF0C3F5D5A86AFF3CA12020C923ADC6C92`
        act = result-hashstring ).
  ENDMETHOD.


  METHOD sha384_compare.
    DATA(cut) = zcl_hash_factory=>create_hash( algorithm = zif_hash=>algorithm-sha384 ).

    DATA(result) = cut->get_hash_for_string( `123456` ).

    cl_abap_unit_assert=>assert_equals(
        exp = `0A989EBC4A77B56A6E2BB7B19D995D185CE44090C13E2984B7ECC6D446D4B61EA9991B76A4C2F04B1B4D244841449454`
        act = result-hashstring ).
  ENDMETHOD.


  METHOD sha512_compare.
    DATA(cut) = zcl_hash_factory=>create_hash( algorithm = zif_hash=>algorithm-sha512 ).

    DATA(result) = cut->get_hash_for_string( `123456` ).

    cl_abap_unit_assert=>assert_equals(
        exp = `BA3253876AED6BC22D4A6FF53D8406C6AD864195ED144AB5C87621B6C233B548BAEAE6956DF346EC8C17F5EA10F35EE3CBC514797ED7DDD3145464E2A0BAB413`
        act = result-hashstring ).
  ENDMETHOD.
ENDCLASS.
