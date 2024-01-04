// ----------------------------------------------------------------------------

#include "script_component.hpp"

SCRIPT(test_orderedDicts);

// ----------------------------------------------------------------------------
#define DEBUG_MODE_FULL

LOG("Testing Ordered Dicts");

// happy basic operations
private _dict = DICT_CREATE;
DICT_SET(_dict, "A", []);
DICT_SET(_dict, "B", "x");
DICT_SET(_dict, "C", 1);

private _result = DICT_GET(_dict, "A");
TEST_OP(_result,isEqualTo,[],"DICT_GET()/A");

_result = DICT_GET(_dict, "B");
TEST_OP(_result,==,"x","DICT_GET()/B");

_result = DICT_GET(_dict, "C");
TEST_OP(_result,==,1,"DICT_GET()/C");

_result = DICT_GET(_dict, "D");
TEST_TRUE(isNil "_result","DICT_GET()/missing");

DICT_SET(_dict, "A", objNull);
_result = DICT_GET(_dict, "A");
TEST_TRUE(isNull _result,"DICT_GET()/overwrite");

_result = DICT_GET_DEFAULT(_dict, "B", "");
TEST_OP(_result,==,"x","DICT_GET_DEFAULT()/defined");

_result = DICT_GET_DEFAULT(_dict, "E", -2);
TEST_OP(_result,==,-2,"DICT_GET_DEFAULT()/missing");

DICT_POP(_dict, "A");
_result = DICT_GET_DEFAULT(_dict, "A", west);
TEST_OP(_result,isEqualType,sideEmpty,"DICT_GET_DEFAULT()/removed");

_result = DICT_POP(_dict, "B");
TEST_OP(_result,==,"x","DICT_POP()/return value");

_result = DICT_POP(_dict, "D");
TEST_TRUE(isNil "_result","DICT_POP()/missing");

_result = DICT_GET(_dict, "B");
TEST_TRUE(isNil "_result","DICT_GET()/already removed before");

DICT_SET(_dict, "B", 2);
_result = DICT_GET_DEFAULT(_dict, "B", "x");
TEST_OP(_result,==,2,"DICT_GET_DEFAULT()/re-added");

_result = DICT_CONTAINS(_dict, "E");
TEST_FALSE(_result,"DICT_CONTAINS()/missing");

_result = DICT_CONTAINS(_dict, "A");
TEST_FALSE(_result,"DICT_CONTAINS()/removed");

DICT_SET(_dict, "A", 3);
_result = DICT_GET_DEFAULT(_dict, "A", west);
TEST_OP(_result,==,3,"DICT_GET_DEFAULT()/re-added");

_result = DICT_CONTAINS(_dict, "A");
TEST_TRUE(_result,"DICT_CONTAINS()/found");

_result = DICT_KEYS(_dict);
#define EXPECTED ["C","B","A"]
TEST_OP(_result,isEqualTo,EXPECTED,"DICT_KEYS()");

_result = DICT_VALUES(_dict);
#define EXPECTED [1,2,3]
TEST_OP(_result,isEqualTo,EXPECTED,"DICT_VALUES()");

_result = DICT_COUNT(_dict);
TEST_OP(_result,==,3,"DICT_COUNT()");

_result = "";
{
    _result = _result + format ["%1=%2;", _x, _y];
} DICT_FOR_EACH(_dict);
TEST_OP(_result,==,"C=1;B=2;A=3;","DICT_FOR_EACH()");


// nasty evil edge-cases
_dict = DICT_CREATE;
DICT_SET(_dict, [], "value");
(DICT_KEYS(_dict) select 0) pushBack 1;
_result = [1] in DICT_KEYS(_dict);      // uses list
TEST_FALSE(_result,"DICT array keys-list");

_result = DICT_CONTAINS(_dict, [1]);
TEST_FALSE(_result,"DICT array keys-map");

DICT_SET(_dict, "key", []);
DICT_GET(_dict, "key") pushBack 2;
_result = DICT_GET(_dict, "key");
TEST_OP(_result,isEqualTo,[2],"DICT array values");

private _resultLeft = DICT_KEYS(_dict) select 0;
_resultLeft pushBack 3;                 // [1,3]
_result = DICT_KEYS(_dict) select 0;    // [1]
TEST_OP(_resultLeft,isNotEqualTo,_result,"DICT array keys modified");

_resultLeft = DICT_GET(_dict, "key");
_resultLeft pushBack 4;                 // [2,4]
_result = DICT_GET(_dict, "key");       // [2,4]
TEST_OP(_resultLeft,isEqualTo,_result,"DICT array values modified");

_dict = DICT_CREATE;
DICT_SET(_dict, "key", nil);    // key works, value set to nil w/o error
DICT_SET(_dict, nil, "value");  // key fails silently, no additional value
_result = str DICT_KEYS(_dict);
TEST_OP(_result,==,"[""key""]","DICT nil keys");

_result = str DICT_VALUES(_dict);
TEST_OP(_result,==,"[any]","DICT nil values");

_result = DICT_GET(_dict, nil);
TEST_TRUE(isNil "_result","DICT nil values\DICT_GET");

_result = DICT_GET_DEFAULT(_dict, nil, 127);
TEST_OP(_result,==,127,"DICT nil values\DICT_GET_DEFAULT");

_dict = DICT_CREATE;
DICT_SET(_dict, "Key", true);
_result = DICT_GET_DEFAULT(_dict, "keY", false);
TEST_FALSE(_result,"DICT key case-sensitivity");

_result = "keY" in DICT_KEYS(_dict);
TEST_FALSE(_result,"DICT key case-sensitivity-list");

_result = DICT_CONTAINS(_dict, "keY");
TEST_FALSE(_result,"DICT key case-sensitivity-map");
