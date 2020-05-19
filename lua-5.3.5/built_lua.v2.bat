@echo off

title build lua

set path=I:\InstallerPackage\VisualStudio\vs2010_Compiler-2018-09-07-17-14\Compiler\VC\bin;%path%

call vcvars32.bat

set path=I:\InstallerPackage\VisualStudio\vs2010_Compiler-2018-09-07-17-14\Compiler\VC\include;%path%

mkdir bin
cd src
del l*.obj
cl /O2 /W3 /c /DLUA_BUILD_AS_DLL l*.c
del lua.obj luac.obj
link /Dll /out:../bin/lua.dll l*.obj

cl /O2 /W3 /c /DLUA_BUILD_AS_DLL lua.c luac.c
link /Dll /out:../bin/lua.exe lua.obj ../bin/lua.lib
del lua.obj

link /out:../bin/luac.exe l*.obj
del l*.obj
cd ..