@echo off

title build lua

set path=I:\InstallerPackage\VisualStudio\vs2010_Compiler-2018-09-07-17-14\Compiler\VC\bin;%path%

call vcvars32.bat

set path=I:\InstallerPackage\VisualStudio\vs2010_Compiler-2018-09-07-17-14\Compiler\VC\include;%path%

mkdir bin
cd src
del *.obj
cl /O2 /W3 /c /DLUA_BUILD_AS_DLL *.c
del lua.obj luac.obj
link /Dll /out:../bin/lua-5.3.1.dll *.obj

cl /O2 /W3 /c /DLUA_BUILD_AS_DLL lua.c luac.c
link /Dll /out:../bin/lua-5.3.1.exe lua.obj ../bin/lua-5.3.1.lib
del lua.obj

link /out:../bin/luac-5.3.1.exe *.obj
del *.obj
cd ..