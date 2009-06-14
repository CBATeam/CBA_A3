#include "script_component.hpp"
// 6thSense.eu Mod - fRndSelect - by Sickboy (sb_at_dev-heaven.net)
// fRndSelect.sqf by Terox, part of tx_utils for OFP
private ["_list", "_ntotal", "_rnd", "_result", "_target"];

_list = _this;
_ntotal = count _list;
_rnd = random(_ntotal);
_result = _rnd - ((_rnd) mod (1));
if (_result == _ntotal) then { _result = _result-1 };

_target = _list select _result;

_target