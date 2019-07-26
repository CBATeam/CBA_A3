#define COMPONENT jr
#include "\x\cba\addons\main\script_mod.hpp"
#include "\x\cba\addons\main\script_macros.hpp"

#define private 0       // hidden
#define protected 1     // hidden but usable
#define public 2        // visible

#define ReadAndWrite 0      //! any modifications enabled
#define ReadAndCreate 1     //! only adding new class members is allowed
#define ReadOnly 2          //! no modifications enabled
#define ReadOnlyVerified 3  //! no modifications enabled, CRC test applied
