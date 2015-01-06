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

