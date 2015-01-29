var x = 1;
function myFunc() {
    window.alert("x is " + x);
    document.getElementById("demo").innerHTML = "Paragraph changed " + x  + " times";
    x++;
 }

//function to launch SDVDefectviewer
function launchSdvDefectViewer(execDir, srcDir, tracePath) {
    //document.getElementById("demo").innerHTML = "  execDir: " +  execDir + " srcDir: " + srcDir + "  trace: " + tracePath;
    var shell = new ActiveXObject("WScript.Shell");
    shell.CurrentDirectory = execDir;
    var cmd = "view.cmd " + srcDir + " " + tracePath + " ";
    shell.Run(cmd);
}

//enumerate over all textAreas in this document pertaining to "ex"
function enumAnnots(ex)
{
    var str = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
    var l = document.getElementById("tracesPerExample_" + ex).getElementsByClassName("traceAnnots"); //unique in html dom
    //var l = document.getElementsByName("traceAnnots");
    str += "<traces> ";
    var i = 0;
    for (; i < l.length; ++i) {
        //str += ("<trace> <tracenum> " + l[i].id.substring("traceId".length) + "</tracenum> <annot> " + l[i].value + " </annot> </trace>");
        str += "<trace> ";
        str += "<tracenum> " + l[i].id.substring("traceId".length) + "</tracenum>";
        //TODO: avoid positional indexing (0 -> <button ..>
        str += "<category> " + l[i].elements[1].value + " </category>";
        str += "<prefix> " + "<![CDATA[" + l[i].elements[2].value + "]]>" + " </prefix>"; //treat it as text to avoid special chars
        str += "<comment> " + l[i].elements[3].value + " </comment>";
        str += "</trace>";
    }
    str += "</traces>";
    document.getElementById("displayAllAnnotsFor_" + ex).value = str; //at least can copy 
}

