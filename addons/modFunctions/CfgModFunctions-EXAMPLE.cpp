
class CfgModFunctions {

    //in function/category with directory -> compileFinal = <INTEGER>/<BOOL>/0,1;
    class <pboName/something else> {
        /***
        FIRST TYPE
        ***/
        //common BIS structure -> <pboName>_fnc_<function>
        

        class <category/unnamed> {
            directory = "<path\to\functions>"; //<- file directory
            class <function> {}; //functions in directory...
        };


        /***
        SECOND TYPE  -  DISABLED
        ***/
        //path structure for functions -> <pboName>_<subPath>_<subPath>_fnc_<function>
        /*
        DISABLED, DISABLED, DISABLED, DISABLED, DISABLED
        class <subpath/tag\> {
            class <subpath/tag\> {
                class <function> {};
            };
        };
        DISABLED, DISABLED, DISABLED, DISABLED, DISABLED
        */


        /***
        THIRD TYPE
        ***/
        //common BIS structure -> <pboName>_fnc_<function>
        

        class <category/unnamed> {
            class <function> { file = "<path\to\function>"; };
        };


        /***
        FOURTH TYPE
        ***/
        //common BIS structure -> <pboName>_fnc_<function>
        

        class <function> { file = "<path\to\function>"; };
    };
};
