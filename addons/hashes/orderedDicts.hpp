#define DICT_CREATE [createHashMap, []]
#define _DICT_MAP(D) ((D) select 0)
#define _DICT_LIST(D) ((D) select 1)

#define DICT_SET(D,k,v) (call {\
    _DICT_MAP(D) set [k, v];\
    _DICT_LIST(D) pushBackUnique (k) != -1\
})

#define DICT_GET(D,k) (_DICT_MAP(D) get (k))
#define DICT_GET_DEFAULT(D,k,d) (_DICT_MAP(D) getOrDefault [k, d])
#define DICT_POP(D,k) (_DICT_MAP(D) deleteAt (_DICT_LIST(D) deleteAt (_DICT_LIST(D) find (k))))
#define DICT_CONTAINS(D,k) ((k) in _DICT_MAP(D))

#define DICT_KEYS(D) (+ _DICT_LIST(D))
#define DICT_VALUES(D) (_DICT_LIST(D) apply {_DICT_MAP(D) get _x})
#define DICT_COUNT(D) (count _DICT_LIST(D))

// note, overwrites "_this" variable
#define DICT_FOR_EACH(D) call {\
    {\
        private _y = DICT_GET(D, _x);\
        call _this;\
    } forEach DICT_KEYS(D);\
}
