#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_attachToBone

Description:
    Attach the child object to the a bone in the parent object, maintaining the relative orientation or matching the bone orientation.

Parameters:
    _child             - Child object to be attached to parent <OBJECT>
    _parent            - Parent object to which child will be attached <STRING>
    _bone              - Bone name <STRING>
    _matchOrientation  - Orientation <BOOLEAN> (Default: true) True: match bone orientation, False: maintain relative orientation
    _lod               - LOD in which to check for bone <BOOLEAN> (Default: 1e15 for Memory LOD)

Returns:

Examples:
    (begin example)
        [_child, _vehicle, _bone, false] call cba_fnc_attachToBone
        [drill, player, "RightForeArmRoll", false] call cba_fnc_attachToBone

        private _pylon = "cba_pylons_pylon_single_fixed" createVehicle [0, 0, 0];
        _pylon setPylonLoadout [1, "PylonRack_12Rnd_PG_missiles", true];
        _pylon setPosASL eyePos player;
        _pylon setDir (getDir player);
        [_pylon, player, "Launcher", false] call cba_fnc_attachToBone;
    (end)

Author:
    Ampersand
---------------------------------------------------------------------------- */
SCRIPT(canAddItem);

#define LOD_MEMORY 1e15

params [
    ["_child", objNull, [objNull]],
    ["_parent", objNull, [objNull]],
    ["_bone", "", [""]],
    ["_matchOrientation", true, [false]],
    ["_lod", LOD_MEMORY]
];

if (!isNull attachedTo _child) then {detach _child;}; // Get vectors in world space

private _childPos = _parent worldToModel ASLToAGL getPosWorldVisual _child;
private _childY = _parent vectorWorldToModelVisual vectorDirVisual _child;
private _childZ = _parent vectorWorldToModelVisual vectorUpVisual _child;
private _childX = _childY vectorCrossProduct _childZ;

private _bonePos = _parent selectionPosition [_bone, _lod];
private _offset = _childPos vectorDiff _bonePos;
_parent selectionVectorDirAndUp [_bone, _lod] params ["_boneY", "_boneZ"];
if (_boneY isEqualTo [0, 0, 0]) then {
    _boneY set [1, 1];
    _boneZ set [2, 1];
};
private _boneX = _boneY vectorCrossProduct _boneZ;

private _m = matrixTranspose [_boneX, _boneY, _boneZ];
private _pos = flatten ([_offset] matrixMultiply _m);
_child attachTo [_parent, _pos, _bone, true];

if (_matchOrientation) exitWith {};

// Maintain relative orientation
_m matrixMultiply [_childX, _childY, _childZ] params ["", "_vY", "_vZ"];
_child setVectorDirAndUp [_vY, _vZ];
