xcopy /Y smv-av-scripts\smv.cmd %SDV%\smv.cmd 
xcopy /Y smv-av-scripts\chakrachecks-nobuild-sf-cloud.xml %SDV%\smv\analysisplugins\av\configurations\
xcopy /Y smv-av-scripts\chakra-type-confusion-annots.txt %SDV%\smv\analysisplugins\av\bin\engine\exampleProperties\
xcopy /Y smv-av-scripts\type-confusion.avp %SDV%\smv\analysisplugins\av\bin\engine\exampleProperties\
xcopy /Y ..\..\..\fastavn\fastavn\bin\debug\SmackInst* %SDV%\smv\analysisplugins\av\bin\engine\
xcopy /Y ..\..\..\fastavn\fastavn\bin\debug\PropInst* %SDV%\smv\analysisplugins\av\bin\engine\
REM xcopy /Y ..\..\..\fastavn\fastavn\bin\debug\* %SDV%\smv\analysisplugins\av\bin\engine\