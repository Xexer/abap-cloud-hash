CLASS zcl_hash_base DEFINITION
  PUBLIC ABSTRACT
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING algorithm TYPE zif_hash=>algorithms.

  PROTECTED SECTION.
    DATA algorithm TYPE zif_hash=>algorithms.

    "! Get the chosen algorithm
    "! @parameter result | String for methods
    METHODS get_algorithm
      RETURNING VALUE(result) TYPE string.

  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_hash_base IMPLEMENTATION.
  METHOD constructor.
    me->algorithm = algorithm.
  ENDMETHOD.


  METHOD get_algorithm.
    CASE algorithm.
      WHEN zif_hash=>algorithm-sha256.
        RETURN 'SHA256'.
      WHEN zif_hash=>algorithm-sha384.
        RETURN 'SHA384'.
      WHEN zif_hash=>algorithm-sha512.
        RETURN 'SHA512'.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
