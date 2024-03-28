// ["vn_"] call compileScript ["\x\cba\addons\jam\dev_diagnoseMagWells.sqf"];

params ["_prefix"];
_prefix = toLower _prefix;
private _prefixSize = count _prefix;

private _cfgMagazines = configFile >> "CfgMagazines";
private _cfgMagazineWells = configFile >> "CfgMagazineWells";
private _weapons = "getNumber (_x >> 'scope') == 2" configClasses (configFile >> "CfgWeapons");
{
    private _weaponConfig = _x;
    private _weapon = configName _weaponConfig;
    if ((_weapon select [0, _prefixSize]) != _prefix) then { continue };

    {
        private _muzzle = _x;
        private _muzzleConfig = _weaponConfig;
        // diag_log text format ["%1 -> %2", _weapon, _muzzle];
        if ((_muzzle != "this") && {_muzzle != _weapon}) then {_muzzleConfig = _weaponConfig >> _muzzle };
        private _directMags = (getArray (_muzzleConfig >> "magazines")) apply {configName (configFile >> "CfgMagazines" >> _x)};
        private _allMags = compatibleMagazines [_weapon, _muzzle];
        private _cbaWellMags = [];
        {
            if ((_x select [0,3]) != "CBA") then { continue };
            private _wellConfig = _cfgMagazineWells >> _x;
            {
                _cbaWellMags append getArray _x;
            } forEach configProperties [_wellConfig, "isArray _x", false];
        } forEach (getArray (_muzzleConfig >> "magazineWell"));
        _cbaWellMags = _cbaWellMags select {isClass (_cfgMagazines >> _x)};
        _cbaWellMags = _cbaWellMags apply {configName (_cfgMagazines >> _x)};

        private _exlusiveCbaMags = _cbaWellMags - _directMags;
        if (_exlusiveCbaMags isEqualTo []) then { continue };

        private _weaponDisplay = _weapon;
        if ((_muzzle != "this") && {_muzzle != _weapon}) then {_weaponDisplay = _weaponDisplay + format ["[%1]", _muzzle] };
        diag_log text format ["%1 gained %2 mags through cba wells", _weaponDisplay, count _exlusiveCbaMags];
        diag_log text format ["  Mags %1", _exlusiveCbaMags];
        diag_log text format ["  Well %1", getArray (_muzzleConfig >> "magazineWell")];
    } forEach getArray (_x >> "muzzles");
} forEach _weapons;
