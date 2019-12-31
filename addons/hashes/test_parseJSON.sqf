// ----------------------------------------------------------------------------

#include "script_component.hpp"

SCRIPT(test_parseJSON);

// ----------------------------------------------------------------------------

private ["_expected", "_result", "_fn", "_data"];

_fn = "CBA_fnc_parseJSON";
LOG("Testing " + _fn);

TEST_DEFINED("CBA_fnc_parseJSON",_fn);

// Namespace syntax
_data = [preprocessFile "\x\cba\addons\hashes\test_parseJSON_config.json"] call CBA_fnc_parseJSON;

_result = [_data] call CBA_fnc_isHash;
TEST_FALSE(_result,_fn);

_result = allVariables _data;
_result sort true;
_expected = ["address","age","companyname","firstname","lastname","newsubscription","phonenumber"]; //all lower case
TEST_OP(_result,isEqualTo,_expected,_fn);

_result = _data getVariable "address" getVariable "city";
_expected = "New York";
TEST_OP(_result,==,_expected,_fn);

_result = _data getVariable "phoneNumber" select 0 getVariable "type";
_expected = "home";
TEST_OP(_result,==,_expected,_fn);

_result = _data getVariable "phoneNumber" select 1 getVariable "type";
_expected = "fax";
TEST_OP(_result,==,_expected,_fn);

_result = _data getVariable "newSubscription";
TEST_FALSE(_result,_fn);

_result = _data getVariable "companyName";
TEST_TRUE(isNull _result,_fn);

// Hash syntax
_data = [preprocessFile "\x\cba\addons\hashes\test_parseJSON_config.json", true] call CBA_fnc_parseJSON;

_result = [_data] call CBA_fnc_isHash;
TEST_TRUE(_result,_fn);

_result = [_data] call CBA_fnc_hashKeys;
_result sort true;
_expected = ["address","age","companyName","firstName","lastName","newSubscription","phoneNumber"]; //camel case
TEST_OP(_result,isEqualTo,_expected,_fn);

_result = [[_data, "address"] call CBA_fnc_hashGet, "city"] call CBA_fnc_hashGet;
_expected = "New York";
TEST_OP(_result,==,_expected,_fn);

_result = [[_data, "phoneNumber"] call CBA_fnc_hashGet select 0, "type"] call CBA_fnc_hashGet;
_expected = "home";
TEST_OP(_result,==,_expected,_fn);

_result = [[_data, "phoneNumber"] call CBA_fnc_hashGet select 1, "type"] call CBA_fnc_hashGet;
_expected = "fax";
TEST_OP(_result,==,_expected,_fn);

_result = [_data, "newSubscription"] call CBA_fnc_hashGet;
TEST_FALSE(_result,_fn);

_result = [_data, "companyName"] call CBA_fnc_hashGet;
TEST_TRUE(isNull _result,_fn);

/* ???
private _testCases = [
    "null",
    "true",
    "1.2",
    """Hello, World!""",
    "[]",
    "{}",
    "[null, true, 1.2, ""Hello, World!""]",
    "[{""nested"": [{""nested"": [{""nested"": [{""nested"": [{""nested"": [{""nested"": [{""nested"": []}]}]}]}]}]}]}]"
];

{
    private _useHashes = _x;

    {
        diag_log _x;
        private _input  = _x;
        private _object = [_x, _useHashes] call CBA_fnc_parseJSON;
        private _output = [_object] call CBA_fnc_encodeJSON;
        TEST_OP(_input,==,_output,_fn);
    } forEach _testCases;
} forEach [true, false];

// Special test for complex object because properties are unordered
private _json = "{""OBJECT"": null, ""BOOL"": true, ""SCALAR"": 1.2, ""STRING"": ""Hello, World!"", ""ARRAY"": [], ""LOCATION"": {}}";
private _object = [_json, false] call CBA_fnc_parseJSON;
private _properties = allVariables _object;
TEST_OP(count _properties,==,6,_fn);
{
    private _value = _object getVariable _x;
    TEST_OP(typeName _value,==,_x,_fn);
} forEach _properties;

nil
