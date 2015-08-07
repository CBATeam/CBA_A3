/* ----------------------------------------------------------------------------
Function: CBA_fnc_registerKeybind

This function is deprecated, please use CBA_fnc_addKeybind. This function will NOT register or save keys to the binding menu.

Author:
 Nou
---------------------------------------------------------------------------- */
//#define DEBUG_MODE_FULL
#include "\x\cba\addons\keybinding\script_component.hpp"


// Clients only.
if (isDedicated) exitWith {};
diag_log text format["[CBA Keybinding] WARNING: %1=>%2 called cba_fnc_registerKeybind is no longer a valid function and has been replaced with cba_fnc_addKeybind. Contact the developer of mod %1 to change the code to use the new function.",_this select 0,_this select 1];

_nullKeybind = [-1,false,false,false];

params ["_modName","_actionName","_code"];
DEFAULT_PARAM(3,_defaultKeybind,_nullKeybind);
DEFAULT_PARAM(4,_overwrite,false);
DEFAULT_PARAM(5,_keypressType,"KeyDown");

// Confirm correct formatting of keybind array is [DIK, shift, ctrl, alt]
if (count _defaultKeybind != 4) then {
    // See if it is a addKeyHandler style keypress array
    if (count _defaultKeybind == 2 && {typeName (_defaultKeybind select 1) == "ARRAY"} && {count (_defaultKeybind select 1) == 3}) then {
        // Convert from [DIK, [shift, ctrl, alt]] to [DIK, shift, ctrl, alt]
        _defaultKeybind = [_defaultKeybind select 0, (_defaultKeybind select 1) select 0, (_defaultKeybind select 1) select 1, (_defaultKeybind select 1) select 2];
    } else {
        // Key format is not known, set to nil and warn
        _defaultKeybind = _nullKeybind;

        _warn = ["[CBA Keybinding] ERROR: Invalid keybind format %1 for %2 %3. Using null keybind.", _defaultKeybind, _modName, _actionName];
        _warn call bis_fnc_error;
        diag_log format _warn;
    };
    diag_log Format ["Converted _defaultKeybind => %1",_defaultKeybind];
};


_dikCode = _defaultKeybind select 0;
_shift = _defaultKeybind select 1;
_ctrl = _defaultKeybind select 2;
_alt = _defaultKeybind select 3;


if(_dikCode > -1 && !isNil {_code}) then {  // A DIK code of -1 signifies "no key set"
    GVAR(ehCounter) = GVAR(ehCounter) + 1;
    if(toLower _keypressType == "keydown") then {
        [_dikCode, [_shift, _ctrl, _alt], _code, "keydown", format ["%1", GVAR(ehCounter)]] call cba_fnc_addKeyHandler;
    } else {
        [_dikCode, [_shift, _ctrl, _alt], _code, "keyup", format ["%1", GVAR(ehCounter)]] call cba_fnc_addKeyHandler;
    };
};


_defaultKeybind
