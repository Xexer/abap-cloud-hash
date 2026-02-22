INTERFACE zif_hash
  PUBLIC.

  TYPES: BEGIN OF ENUM algorithms STRUCTURE algorithm,
           sha256,
           sha384,
           sha512,
         END OF ENUM algorithms STRUCTURE algorithm.

  TYPES:
    BEGIN OF hash_result,
      hashstring    TYPE string,
      hashxstring   TYPE xstring,
      hashb64string TYPE string,
    END OF hash_result.

  "! Calculate Hash for String
  "! @parameter value  | Value as string
  "! @parameter result | Different Hash values
  METHODS get_hash_for_string
    IMPORTING !value        TYPE string
    RETURNING VALUE(result) TYPE hash_result.

  "! Calculate Hash for XString
  "! @parameter value  | Value as XString
  "! @parameter result | Different Hash values
  METHODS get_hash_for_xstring
    IMPORTING !value        TYPE xstring
    RETURNING VALUE(result) TYPE hash_result.

  "! Convert a String to XString
  "! @parameter value  | Value as String
  "! @parameter result | Result as converted XString
  METHODS string_to_xstring
    IMPORTING !value        TYPE string
    RETURNING VALUE(result) TYPE xstring.
ENDINTERFACE.
