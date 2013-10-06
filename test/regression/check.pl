$BuildConfig = "debug";

open (FINAL_OUTPUT, "Files") || die "cannot read Files";
@files = <FINAL_OUTPUT>;
close (FINAL_OUTPUT);

# One can give the explicit directory name to execute
# all tests in that directory

$numArgs = $#ARGV + 1;

$dirsGiven = 0;
$flags = "";
@dirs = ("");

for($cnt = 0; $cnt < $numArgs; $cnt++) {
    #print substr($ARGV[$cnt],0,1);
    if(substr($ARGV[$cnt],0,1) =~ '/') {
       $flags = "$flags $ARGV[$cnt]";
    } else {
       $dirsGiven = 1;
       unshift(@dirs, "$ARGV[$cnt]\\\\");
    }
}

foreach $line (@files) {

    # Spilt into file name and expected output
    @inp = split( / +/, $line);
    $file = $inp[0];
    # skip empty lines
    if($file eq "") {
	    next;
    }

    $out = $inp[1];
    # Remove end of line
    @tmp = split(/\n/, $out);
    $out = $tmp[0];

    # if target directories have been given, ignore other directories
    if($dirsGiven) {
	$found = 0;
	for($cnt = 0; $cnt < $#dirs; $cnt++) {
	    $dir = $dirs[$cnt];
	    #print $dir; print "\n";
	    #print $file; print "\n";
            if($file =~ m/^$dir/) {
		    $found = 1;
	    }
	}
	if($found == 0) {
		next;
	}
    }

    # get directory name from the file name
    @tmp = split(/\\/, $file);
    $dir = $tmp[0];
    
    #print "Directory given: $dir";

    # check if files exists
    open(TMP_HANDLE, $file) || die "File $file does not exist\n";
    close (TMP_HANDLE);

    $cmd = "..\\..\\bin\\$BuildConfig\\corral.exe $file /flags:$dir\\config $flags > out";
    print $cmd; print "\n";
    system($cmd);

    # Check result
    open(TMP_HANDLE, "out")  || die "Command did not produce an output\n";
    @res = <TMP_HANDLE>;
    close(TMP_HANDLE);

    $ok = 1;
    if($out eq "c") {
	    @correct = grep (/^Program has no bugs/, @res);
	    if($correct[0] =~ m/^Program has no bugs/) {
		    $ok = 1;
	    } else {
		    $ok = 0;
	    }
    } else {
	    @correct = grep (/^Program has a potential bug: True bug/, @res);
	    if($correct[0] =~ m/^Program has a potential bug: True bug/) {
		    $ok = 1;
	    } else {
		    $ok = 0;
	    }
    }

    if($ok == 0) {
	    print $correct[0];
	    die "Test $file failed\n";
    } else {
	    print $correct[0];
	    print "Test passed\n";
    }
}

	
