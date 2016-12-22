
class CfgModFunctions {

    //in function/category with directory -> compileFinal = <INTEGER>/<BOOL>/0,1;
    class <pboName/something else> {
        /***
        FIRST TYPE
        ***/
        //common BIS structure -> <pboName>_fnc_<function>
        

        -> class <category/unnamed> {
            directory = "<path\to\functions>"; //<- file directory
            class <function> {}; //functions in directory...
        };


        /***
        SECOND TYPE  -  disabled
        ***/
        //path structure for functions -> <pboName>_<subPath>_<subPath>_fnc_<function>
        

        -> class <subpath/tag\> {
            class <subpath/tag\> {
                class <function> {};
            };
        };


        /***
        THIRD TYPE
        ***/
        //common BIS structure -> <pboName>_fnc_<function>
        

        -> class <category/unnamed> {
            class <function> { file = "<path\to\functions>"; };
        };


        /***
        FOURTH TYPE
        ***/
        //common BIS structure -> <pboName>_fnc_<function>
        

        -> class <function> { file = "<path\to\function>"; };
    };
};
