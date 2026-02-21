CLASS zcl_hash_injector DEFINITION
  PUBLIC ABSTRACT FINAL
  CREATE PUBLIC
  FOR TESTING.

  PUBLIC SECTION.
    "! Inject Test-Double into Factory
    "! @parameter double | New double
    CLASS-METHODS inject_hash
      IMPORTING double TYPE REF TO zif_hash OPTIONAL.
ENDCLASS.


CLASS zcl_hash_injector IMPLEMENTATION.
  METHOD inject_hash.
    zcl_hash_factory=>double_hash = double.
  ENDMETHOD.
ENDCLASS.
