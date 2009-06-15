#define TYPE_HASH "#CBA_HASH#"

#define HASH_ID 0
#define HASH_KEYS 1
#define HASH_VALUES 2
#define HASH_DEFAULT_VALUE 3

#define IS_HASH(X) ((isArray (X)) and ((X) select 0) == TYPE_HASH)