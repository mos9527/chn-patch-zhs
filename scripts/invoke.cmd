@echo off
set MGS_DIR="..\.bin\MgsScriptTools"
set MGS="%MGS_DIR%\MgsScriptTools.exe"
set MGS_BANK="%MGS_DIR%\mgs-spec-bank"

IF "%1"=="" GOTO NOARG
IF "%2"=="" GOTO NOARG

%MGS% %1 --compiled-directory ..\.temp\%2 --decompiled-directory %2 --string-syntax Sc3Tools --charset chaos_head_noah-extended  --flag-set chaos_head_windows --instruction-sets base,chaos_head_noah --bank-directory %MGS_BANK%

GOTO END

:NOARG
echo Usage: invoke.cmd [compile/decompile] [mes00/mes01]
:END
