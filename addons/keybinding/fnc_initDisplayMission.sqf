//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_display"];

// --- add key ui eventhandlers
// Keep these short, because they are stored as strings and have to be
// recompiled every execution.
_display displayAddEventHandler ["KeyDown", {
    call ((_this select 0) getVariable QFUNC(onKeyDown));
}];

_display displayAddEventHandler ["KeyUp", {
    call ((_this select 0) getVariable QFUNC(onKeyUp));
}];

// --- add mouse ui eventhandlers
_display ctrlAddEventHandler ["MouseButtonDown", {
    call ((_this select 0) getVariable QFUNC(onMouseButtonDown));
}];

_display ctrlAddEventHandler ["MouseButtonUp", {
    call ((_this select 0) getVariable QFUNC(onMouseButtonUp));
}];

// --- key/mouse down/up ui eventhandler functions
_display setVariable [QFUNC(onKeyDown), {
    params ["", "_key", "_shift", "_control", "_alt"];

    systemChat str ["k down", _key, [_shift, _control, _alt]];
}];

_display setVariable [QFUNC(onKeyUp), {
    params ["", "_key", "_shift", "_control", "_alt"];

    systemChat str ["k up", _key, [_shift, _control, _alt]];
}];

_display setVariable [QFUNC(onMouseButtonDown), {
    params ["", "_button", "", "", "_shift", "_control", "_alt"];

    systemChat str ["m down", _button, [_shift, _control, _alt]];
}];

_display setVariable [QFUNC(onMouseButtonUp), {
    params ["", "_button", "", "", "_shift", "_control", "_alt"];

    systemChat str ["m up", _button, [_shift, _control, _alt]];
}];
