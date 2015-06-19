@echo off

echo === Compiling documentation ===
echo.
perl "C:\Program Files (x86)\NaturalDocs-1.52\NaturalDocs" -i "..\addons" -o HTML "..\docs" -p "ndocs-project" -s Default cba

echo.
echo === Packaging documentation ===
echo.
del /F /Q "..\store\function_library.tar"
tar -C ..\ -cf ..\store\function_library.tar docs

pause
