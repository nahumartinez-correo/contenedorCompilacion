@ECHO OFF
:: This batch file is called automatically by SETUP.EXE as part 
:: of the MOA installation process.  There is no need for users
:: to run this program.
::
:: Arg1 is SOURCE directory (and is provided by SETUP.INS)
:: Arg2 is TARGET directory (without the trailing slash, e.g. C:\MOA )
:: Neither arg has a trailing slash.  Example of use:
::
::   PATCH  e:\testdir  c:\moa\bin 
::

::echo SOURCE = %1
::echo TARGET = %2

:: XCOPY NOTES ...
:: NT's XCOPY doesn't support the -Y switch; Win95's XCOPY needs it.
::  
:: The following switches are used for XCOPY
::    /S  -  Copies directories and subdirectories except empty ones.
::    /I  -  Assume destination is a directory if doesn't exist
::    /R  -  Overwrites READ-ONLY files
::    /D  -  Copy only files whose source time is newer than the 
::           destination time.
::    /Y  -  Overwrite without prompting. (Not supported by NT, but required
::           under Win95 to eliminate file-by-file 'Overwrite?' prompting)
::

:: DETERMINING THE OPERATING SYSTEM
:: If the %windir%\win386.swp file exists, we assume we are running
:: Windows 95. The "windir" environment variable is available under
:: both Win95 and NT40 (We initially tried using the "OS" environment 
:: variable which is defined under NT40, but not under Win95, as 
:: follows: "IF %OS%=="Windows_NT" GOTO LabelNT", but this resulted
:: in a sytnax error under Windows95).

IF EXIST %windir%\WIN386.SWP GOTO Label95
::echo *** WIN NT ***
   XCOPY /S /I /R /D %1\Patches %2
   IF ERRORLEVEL 1 GOTO ERROR
   GOTO DONE

:Label95
::echo *** Win95 ***
   XCOPY /S /I /R /D /Y %1\Patches %2
   IF ERRORLEVEL 1 GOTO ERROR
::The following is needed since this command window will not
::automatically close under Windows95.
   echo.
   echo Patch files installed.  Close this window to allow SETUP to proceed.
   echo.
   GOTO DONE


:ERROR
echo.
echo  *** Error occurred while copying patch files from the
echo  *** %1\Patches directory to the %2 directory.
echo  *** Please copy these files manually.
echo.
PAUSE
echo.

:DONE
