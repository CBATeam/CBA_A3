@echo off

echo === Compiling documentation ===
echo.
perl "C:\Program Files (x86)\NaturalDocs-1.4\NaturalDocs" -i "..\addons" -o HTML "..\store\function_library" -p "ndocs-project" -s Default cba

echo.
echo === Packaging documentation ===
echo.
cd "..\store"
del "function_library.tar"
tar -c function_library > function_library.tar

pause
