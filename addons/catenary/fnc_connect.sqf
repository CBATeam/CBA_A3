#include "script_component.hpp"

params [
    ["_pos0", objNull, [[], objNull]], ["_pos1", objNull, [[], objNull]],
    ["_ropeLength", "1.0001x", [0, ""]], ["_segmentCount", 100, [0]],
    ["_segmentLength", -1, [0]]
];

if (_pos0 isEqualType objNull) then {
    _pos0 = getPosWorld _pos0;
};

if (_pos1 isEqualType objNull) then {
    _pos1 = getPosWorld _pos1;
};

// assume is factor
if (_ropeLength isEqualType "") then {
    _ropeLength = parseNumber _ropeLength * (_pos0 vectorDistance _pos1);
};

private _catenary = parseSimpleArray ("CBA_catenary" callExtension ["draw", [
    _pos0, _pos1,
    _ropeLength, _segmentCount,
    _segmentLength
]] select 0);

[_catenary, _pos0, _pos1]
