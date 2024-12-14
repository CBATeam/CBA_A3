switch (_this) do {
    case "__DATE_ARR__": { [__DATE_ARR__] }; // [2024,11,10,16,19,39]
    case "__DATE_STR__": { __DATE_STR__ }; // "2024/11/10, 16:19:39"
    case "__DATE_STR_ISO8601__": { __DATE_STR_ISO8601__ }; // "2024-11-10T22:19:39Z"
    case "__TIME__": { '__TIME__' }; // 16:19:39 (quoted because invalid number)
    case "__TIME_UTC__": { '__TIME_UTC__' }; // 22:19:39
    case "__TIMESTAMP_UTC__": { '__TIMESTAMP_UTC__' }; // 1731277179 (quoted because float will not have precision for 32+ bits)
    case "__DAY__": { __DAY__ }; // 10
    case "__MONTH__": { __MONTH__ }; // 11
    case "__YEAR__": { __YEAR__ }; // 2024
    case "__GAME_VER__": { '__GAME_VER__' }; // 2.18.152302 (quoted because invalid number)
    case "__GAME_VER_MAJ__": { __GAME_VER_MAJ__ }; // 2
    case "__GAME_VER_MIN__": { __GAME_VER_MIN__ }; // 18
    case "__GAME_BUILD__": { __GAME_BUILD__ }; // 152302
    case "__A3_DIAG__": { 
        #if __A3_DIAG__
        true
        #else 
        false
        #endif
    };
    case "__A3_DEBUG__": { 
        #if __A3_DEBUG__
        true
        #else 
        false
        #endif
    };
    case "__A3_EXPERIMENTAL__": { 
        #if __A3_EXPERIMENTAL__
        true
        #else 
        false
        #endif
    };
    case "__A3_PROFILING__": { 
        #if __A3_PROFILING__
        true
        #else 
        false
        #endif
    };
    default { "ERROR-invalid macro"};
}
