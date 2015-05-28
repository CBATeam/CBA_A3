/*
    CBA_actionHelper - By BigDawgKS

    Examples:
    _obj addAction ["My Action",CBA_actionHelper,_myOnActCode,1,false,true,"",""];
    Or:
    _obj addAction ["My Action 2",CBA_actionHelper,[_myOnActCode,_moreArgs],1,false,true,"",""]
*/

#include "script_component.hpp"

// #define DEBUG_MODE_FULL
private ["_param", "_code", "_args"];
_param = _this select 3;

if (typeName _param == "ARRAY")then{
    _code = _param select 0;
    _args = _param select 1;

    [_this select 0,_this select 1,_this select 2,_args] call _code;
} else {
    _code = _param;
    [_this select 0,_this select 1,_this select 2] call _code;
};
