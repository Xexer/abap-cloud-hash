CLASS zcl_hash_factory DEFINITION
  PUBLIC ABSTRACT FINAL
  CREATE PUBLIC
  GLOBAL FRIENDS zcl_hash_injector.

  PUBLIC SECTION.
    "! Create new Instance for Hash Values
    "! @parameter algorithm | Hash algorithm
    "! @parameter key       | Key for encryption (XString)
    "! @parameter key_plain | Key for encryption (Plain string)
    "! @parameter result    | New instance
    CLASS-METHODS create_hash
      IMPORTING algorithm     TYPE zif_hash=>algorithms DEFAULT zif_hash=>algorithm-sha512
                !key          TYPE xstring              OPTIONAL
                key_plain     TYPE string               OPTIONAL
      RETURNING VALUE(result) TYPE REF TO zif_hash.

  PRIVATE SECTION.
    "! Double for Test runs
    CLASS-DATA double_hash TYPE REF TO zif_hash.
ENDCLASS.


CLASS zcl_hash_factory IMPLEMENTATION.
  METHOD create_hash.
    IF double_hash IS BOUND.
      RETURN double_hash.
    ELSEIF key IS INITIAL AND key_plain IS INITIAL.
      RETURN NEW zcl_hash( algorithm ).
    ELSE.
      RETURN NEW zcl_hmac( algorithm = algorithm
                           key       = key
                           key_plain = key_plain ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
