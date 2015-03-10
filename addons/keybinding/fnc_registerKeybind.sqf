/* ----------------------------------------------------------------------------
Function: CBA_fnc_registerKeybind

This function is deprecated, please use cba_fnc_addKeybind. This function will NOT register or save keys to the binding menu.

Author:
 Nou
---------------------------------------------------------------------------- */

#include "\x\cba\addons\keybinding\script_component.hpp"

// Clients only.
if (isDedicated) exitWith {};
diag_log text format["cba_fnc_registerKeybind is no longer a valid function and has been replaced with cba_fnc_addKeybind. Please change your code to use the new function."];

_nullKeybind = [-1,false,false,false];

PARAMS_3(_modName,_actionName,_code);
DEFAULT_PARAM(3,_defaultKeybind,_nullKeybind);
DEFAULT_PARAM(4,_overwrite,false);
DEFAULT_PARAM(5,_keypressType,"KeyDown");



_dikCode = _defaultKeybind select 0;
_shift = _defaultKeybind select 1;
_ctrl = _defaultKeybind select 2;
_alt = _defaultKeybind select 3;

if(_dikCode > -1) then {
    if(toLower _keypressType == "keydown") then {
        [_dikCode, [_shift, _ctrl, _alt], _code, "keydown", format ["%1", GVAR(ehCounter)]] call cba_fnc_addKeyHandler;
    } else {
        [_dikCode, [_shift, _ctrl, _alt], _code, "keyup", format ["%1", GVAR(ehCounter)]] call cba_fnc_addKeyHandler;
    };
};
GVAR(ehCounter) = GVAR(ehCounter) + 1;

_defaultKeybind