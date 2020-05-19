@rem Script to build Lua under "Visual Studio .NET Command Prompt".

@rem Do not run from this directory; run it from the toplevel: etc\luavs.bat .

@rem It creates lua52.dll, lua52.lib, lua.exe, and luac.exe in src.

@rem (contributed by David Manura and Mike Pall)

title build lua

set path=I:\InstallerPackage\VisualStudio\vs2010_Compiler-2018-09-07-17-14\Compiler\VC\bin;%path%

call vcvars32.bat

set path=I:\InstallerPackage\VisualStudio\vs2010_Compiler-2018-09-07-17-14\Compiler\VC\include;%path%

mkdir bin

@setlocal

@set MYCOMPILE=cl /nologo /MD /O2 /W3 /c /D_CRT_SECURE_NO_DEPRECATE

@set MYLINK=link /nologo

@set MYMT=mt /nologo



cd src

%MYCOMPILE% /DLUA_BUILD_AS_DLL l*.c

del lua.obj luac.obj

%MYLINK% /DLL /out:../bin/lua.dll l*.obj

if exist lua52.dll.manifest^

  %MYMT% -manifest lua52.dll.manifest -outputresource:lua52.dll;2

%MYCOMPILE% /DLUA_BUILD_AS_DLL lua.c

%MYLINK% /out:../bin/lua.exe lua.obj ../bin/lua.lib

if exist lua.exe.manifest^

  %MYMT% -manifest lua.exe.manifest -outputresource:lua.exe

%MYCOMPILE% l*.c

del lua.obj linit.obj lbaselib.obj ldblib.obj liolib.obj lmathlib.obj^

    loslib.obj ltablib.obj lstrlib.obj loadlib.obj

%MYLINK% /out:../bin/luac.exe *.obj

if exist luac.exe.manifest^

  %MYMT% -manifest luac.exe.manifest -outputresource:luac.exe

del *.obj *.manifest

cd ..