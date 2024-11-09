switch (_this) do {
    case "__DATE_ARR__": { [__DATE_ARR__] }; // arrayed
    case "__DATE_STR__": { __DATE_STR__ };
    case "__DATE_STR_ISO8601__": { __DATE_STR_ISO8601__ };
    case "__TIME__": { __TIME__ };
    case "__TIME_UTC__": { __TIME_UTC__ };
    case "__TIMESTAMP_UTC__": { __TIMESTAMP_UTC__ };
    case "__DAY__": { __DAY__ };
    case "__MONTH__": { __MONTH__ };
    case "__YEAR__": { __YEAR__ };
    case "__GAME_VER__": { '__GAME_VER__' }; // quote because invalid number 2.11.111
    case "__GAME_VER_MAJ__": { __GAME_VER_MAJ__ };
    case "__GAME_VER_MIN__": { __GAME_VER_MIN__ };
    case "__GAME_BUILD__": { __GAME_BUILD__ };
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
