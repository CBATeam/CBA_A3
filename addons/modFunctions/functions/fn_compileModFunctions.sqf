
{
    private _pboConfig = _x;
    private _pboName = (configName _pboConfig);

    {
        private _subConfig = _x;
        private _subName = (configName _x);
        private _file = getText(_subConfig >> "file");
        private _directory = getText(_subConfig >> "directory");

        switch (true) do {
            case (_directory != ""): {
                {
                    call compile (format["%1_fnc_%2 = call %3 preprocessFileLineNumbers ""%4""",
                        _pboName,
                        (configName _x),
                        (if ((getNumber(_x >> "compileFinal")) == 1) then { "compileFinal"; } else { "compile"; }),
                        (format["%1\%2", _directory, (format["fn_%1.sqf", (configName _x)])])
                    ]);
                    diag_log format["[CBA] compiling %1_fnc_%2", _pboName, (configName _x)];
                } forEach ("true" configClasses _subConfig);
            };

            case (_file != ""): {
                call compile (format["%1_fnc_%2 = call %3 preprocessFileLineNumbers ""%4""",
                    _pboName,
                    _subName,
                    (if ((getNumber(_subConfig >> "compileFinal")) == 1) then { "compileFinal"; } else { "compile"; }),
                    _file
                ]);
                diag_log format["[CBA] compiling %1_fnc_%2", _pboName, _subName];
            };

            case (_file == "" && _directory == ""): {
                {
                    call compile (format["%1_fnc_%2 = call %3 preprocessFileLineNumbers ""%4""",
                        _pboName,
                        (configName _x),
                        (if ((getNumber(_x >> "compileFinal")) == 1) then { "compileFinal"; } else { "compile"; }),
                        (getText(_x >> "file"))
                    ]);
                    diag_log format["[CBA] compiling %1_fnc_%2", _pboName, (configName _x)];
                } forEach ("true" configClasses _subConfig);
            };
        };
    } forEach ("true" configClasses _pboConfig);
} forEach ("true" configClasses (configFile >> "CfgModFunctions"));
