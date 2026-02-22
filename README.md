# ABAP Cloud Hashes

ABAP Cloud Facade to create secure Hashes. Improved handling for HASH and HMAC classes.

## Why

Currently, the two classes have some minor design flaws, which we can correct with a new facade. Currently missing and/or unclear points are:

- Magic Constants - The hash algorithms used and supported are not clearly defined. There is no indication of algorithms to be avoided (MD5, SHA1).
- Instantiation - The GET_INSTANCE method accepts the algorithm, but this is only used in some of the methods; others must be populated manually.
- Methods - Numerous import and export parameters are used. Likewise, error handling is necessary, which significantly increases the code size.
- Testability - Testability with the classes is not possible without additional effort.

## Usage

Create an instance of the class ...

```ABAP
DATA(hash) = zcl_hash_factory=>create_hash( algorithm = zif_hash=>algorithm-sha256
                                            key_plain = key ).
```

... and create a hash.

```ABAP
DATA(created_hash) = hash->get_hash_for_string( value )-hashstring.
```
