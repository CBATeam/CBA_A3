#include "script_component.hpp"

SCRIPT(test_parseJSON);

LOG("Testing CBA_fnc_parseJSON");

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
