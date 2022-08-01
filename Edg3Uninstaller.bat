@echo off
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
echo Welcome to Edg3Uninstaller!
echo The best tool to uninstall Edg3 completely.
echo -------------------------------------
echo Made by ShadowTheWolf
echo Are you sure you want to remove M!crosoft Edg3 from your system? (y/n)
set /p yesorno=
if %yesorno%=n echo Process cancelled.
if %yesorno%=y echo Disabling and uninstalling Edg3.
if %yesorno%=y takeown /f C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe
if %yesorno%=y cd C:\Program Files (x86)\Microsoft\Edge\Application
if %yesorno%=y del msedge.exe