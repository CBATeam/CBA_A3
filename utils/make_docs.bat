@echo off

echo === Compiling documentation ===
echo.
perl "C:\Program Files (x86)\NaturalDocs-1.4\NaturalDocs" -i "..\addons" -o HTML "..\docs\cba_function_library" -p "ndocs-project" -s Default cba

echo.
echo === Packaging documentation ===
echo.
cd "..\docs
7z a "cba_function_library"

pause
