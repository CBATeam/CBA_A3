// Pre and Post Init Once

// #define DEBUG_MODE_FULL
#include "script_component.hpp"

private [
	"_i", "_c", "_entry", "_entryServer", "_entryClient", "_Inits"
];

PARAMS_1(_config);

#ifdef DEBUG_MODE_FULL
	_msg = format["XEH BEG: Init %1", _config];
	XEH_LOG(_msg);
#endif

if (isClass _config) then {
	_Inits = [];

	// Collect inits
	_i = 0;
	_c = count _config;
	while { _i < _c } do {
		_entry = _config select _i;
		if (isClass _entry) then {
			_entryServer = (_entry/"serverInit");
			_entryClient = (_entry/"clientInit");
			_entry = (_entry/"init");
			if (isText _entry) then {
				_Inits set [count _Inits, compile(getText _entry)];
			};
			if (SLX_XEH_MACHINE select 3 && {isText _entryServer}) then {
				_Inits set [count _Inits, compile(getText _entryServer)];
			};
			if (!isDedicated && {isText _entryClient}) then {
				_Inits set [count _Inits, compile(getText _entryClient)];
			};
		} else {
			if (isText _entry) then {
				_Inits set [count _Inits, compile(getText _entry)];
			};
		};
		INC(_i);
	};

	// Run collected inits
	{
		#ifdef DEBUG_MODE_FULL
			XEH_LOG(_x);
		#endif
		call _x;
	} forEach _Inits;
};

#ifdef DEBUG_MODE_FULL
	_msg = format["XEH END: Init %1", _config];
	XEH_LOG(_msg);
#endif