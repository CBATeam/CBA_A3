@echo off

echo === Compiling documentation ===
echo.
copy overview.txt ..\addons
copy CBA_logo_large.png ..\addons
perl "C:\Program Files (x86)\NaturalDocs-1.52\NaturalDocs" -r -i "..\addons" -o HTML "..\docs" -p "ndocs-project" -s Default cba
del /Q ..\addons\overview.txt ..\addons\CBA_logo_large.png 

echo.
echo === Packaging documentation ===
echo.
del /F /Q "..\store\function_library.tar"
del /Q ..\store\functions_library.tar
tar -C ..\ -cf ..\store\function_library.tar docs

pause
