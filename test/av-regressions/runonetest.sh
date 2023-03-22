configuration=$1
bpl=$2
opt=$3
inst_opt=$4

HEXE="dotnet ../../source/AvHarnessInstrumentation/bin/$configuration/net6.0/AvHarnessInstrumentation.dll"
BGEXE="dotnet ../../source/AngelicVerifier/bin/$configuration/net6.0/AngelicVerifier.dll"

echo
echo "-------------------- $bpl --------------------"

hinst=${bpl%.*}_hinst.bpl
rm -f $hinst > /dev/null 2>&1
$HEXE $bpl $hinst /traceSlicing $inst_opt | grep --line-buffered AV_OUTPUT
if test -f $hinst; then
    $BGEXE $hinst $opt | grep --line-buffered AV_OUTPUT
fi
