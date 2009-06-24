@echo off

echo === Compiling documentation ===
echo.
perl "C:\Program Files (x86)\NaturalDocs-1.4\NaturalDocs" -i "..\addons" -o HTML "..\docs\function_library" -p "ndocs-project" -s Default cba

echo.
echo === Packaging documentation ===
echo.
7z a "..\docs\function_library"

pause
