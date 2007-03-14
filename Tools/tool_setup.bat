@REM
@REM Copyright (c) 2007, Intel Corporation
@REM All rights reserved. This program and the accompanying materials
@REM are licensed and made available under the terms and conditions of the BSD License
@REM which accompanies this distribution.  The full text of the license may be found at
@REM http://opensource.org/licenses/bsd-license.php
@REM
@REM THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
@REM WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
@REM

@echo off

REM ##############################################################
REM # You should not have to modify anything below this line
REM #

REM
REM check the EDK_TOOLS_PATH
REM
:check_tools_path
if not defined EDK_TOOLS_PATH goto no_tools_path
if not exist %EDK_TOOLS_PATH% goto no_tools_path

:path_ok
set TOOLS_INSTALL_PATH=%~f0

if /I "%1"=="-h" goto Usage
if /I "%1"=="-help" goto Usage
if /I "%1"=="--help" goto Usage
if /I "%1"=="/h" goto Usage
if /I "%1"=="/?" goto Usage
if /I "%1"=="/help" goto Usage
if /I "%1"=="build" goto build
if /I "%1"=="rebuild" goto rebuild
if NOT "%1"=="" goto Usage

:skipbuild
goto end

:rebuild
call nmake -f %TOOLS_INSTALL_PATH%\MsMakefile cleanall

:build
REM
REM Start to build the Framework Tools
REM

echo.
echo Building the Framework Tools
echo.

call nmake -f %TOOLS_INSTALL_PATH%\MsMakefile

@REM
@REM Done!!!
@REM
goto end

:no_tools_path
echo.
echo !!!WARNING!!! No tools path found. Please set EDK_TOOLS_PATH.
echo.
goto end

:Usage
echo.
echo  Usage: %0 [build] [rebuild]
echo         build:    Incremental build, only build those updated tools; 
echo         rebuild:  Rebuild all tools neither updated or not; 
echo.

:end
@echo on

