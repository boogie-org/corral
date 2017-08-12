Keeping a copy of the config files and scripts that have to be dropped into an SMV-AV installation at %SMV_AV%
-------------------------------------------

* xcopy smv.cmd %SMV_AV%\smv.cmd 
* xcopy chakrachecks-nobuild-sf-cloud.xml %SMV_AV%\smv\analysisplugins\av\configurations\
* xcopy chakra-type-confusion-annots.txt %SMV_AV%\smv\analysisplugins\av\bin\engine\exampleProperties\
* xcopy type-confusion.avp %SMV_AV%\smv\analysisplugins\av\bin\engine\exampleProperties\