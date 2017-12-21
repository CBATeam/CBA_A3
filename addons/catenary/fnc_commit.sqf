#include "script_component.hpp"

params ["_module"];

private _ropeLength = _module getVariable "ArcLength";
private _segmentCount = _module getVariable "SegmentCount";
private _classname = _module getVariable "Model";
private _modelPointsUpwards = _module getVariable "Upwards";
private _isSimple = _module getVariable "IsSimple";

private _segmentLength = -1;

if (_segmentCount < 0) then {
    _segmentLength = abs _segmentCount;
} else {
    _segmentCount = round _segmentCount;
};

if (_ropeLength < 0) then {
    _ropeLength = format ["%1x", abs _ropeLength];
};

private _connected = get3DENConnections (get3DENSelected "logic" select {
    typeOf _x == QGVAR(start)
} select 0) select {_x select 0 == "Sync"} apply {_x select 1};

collect3DENHistory {
    {
        private _catenary = [_module, _x, _ropeLength, _segmentCount, _segmentLength] call FUNC(connect) select 0;
        {
            private _pos0 = _x;
            private _pos1 = _catenary select (_forEachIndex + 1);

            if (isNil "_pos1") exitWith {};

            private _rope = objNull;
            if (_isSimple) then {
                _rope = createSimpleObject [_classname, _pos0];
            } else {
                _rope = create3DENEntity ["Object", _classname, ASLToAGL _pos0];
            };

            private _vdir = _pos0 vectorFromTo _pos1;
            private _vlat = vectorNormalized (_vdir vectorCrossProduct [0,0,1]);
            private _vup = _vlat vectorCrossProduct _vdir;

            if (_modelPointsUpwards) then {
                _rope setVectorDirAndUp [_vup, _vdir];
            } else {
                _rope setVectorDirAndUp [_vdir, _vup];
            };
        } forEach _catenary;
    } forEach _connected;
};
