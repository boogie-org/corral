configuration=$1
bpl=$2
propfile=$3

HEXE="dotnet ../../source/AvHarnessInstrumentation/bin/$configuration/net6.0/AvHarnessInstrumentation.dll"
BGEXE="dotnet ../../source/AngelicVerifier/bin/$configuration/net6.0/AngelicVerifier.dll"
PROPEXE="dotnet ../../source/PropInst/bin/$configuration/net6.0/PropInst.dll"

echo
echo "-------------------- $bpl --------------------"

pinst=${bpl%.*}_pinst.bpl
hinst=${bpl%.*}_pinst_hinst.bpl
rm -f $pinst > /dev/null 2>&1
$PROPEXE $propfile $bpl $pinst | grep --line-buffered AV_OUTPUT
$HEXE $pinst $hinst /traceSlicing | grep --line-buffered AV_OUTPUT
if test -f $hinst; then
    $BGEXE $hinst /traceSlicing | grep --line-buffered AV_OUTPUT
fi