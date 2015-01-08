var x = 1;
function myFunc() {
    window.alert("x is " + x);
    document.getElementById("demo").innerHTML = "Paragraph changed " + x  + " times";
    x++;
 }

//function to launch SDVDefectviewer
function launchSdvDefectViewer(execDir, srcDir, tracePath) {
    document.getElementById("demo").innerHTML = "  execDir: " +  execDir + " srcDir: " + srcDir + "  trace: " + tracePath;
    var shell = new ActiveXObject("WScript.Shell");
    shell.CurrentDirectory = execDir;
    var cmd = "view.cmd " + srcDir + " " + tracePath + " ";
    shell.Run(cmd);
}

//enumerate over all textAreas in this document
function enumAnnots()
{
    var l = document.getElementsByName("traceAnnots");
    var str = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>";
    str += "<traces> ";
    var i = 0;
    for(; i < l.length; ++i)
    {
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
    //document.getElementById("displayAllAnnotsHere").innerHTML = str; //doesn;t render xml tags
    //window.alert(str); //hard to copy from
    document.getElementById("displayAllAnnotsHere").value = str; //at least can copy 
    //var blob = new Blob(["foo"], { type: "text/plain;charset=utf-8" });
    //var uriContent = "text/plain;charset=utf-8," /*"data:application/octet-stream,"*/  +  encodeURIComponent(str);
    //window.open(uriContent, 'Save Your File');
}

