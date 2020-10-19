use strict;
use warnings;

use Cwd;
use File::Basename;
use File::Find;
use File::Spec;

my $BuildConfig = $ENV{CONFIGURATION} || "Debug";

open (FINAL_OUTPUT, "Files") || die "cannot read Files";
my @files = <FINAL_OUTPUT>;
close (FINAL_OUTPUT);

# One can give the explicit directory name to execute
# all tests in that directory

my $numArgs = $#ARGV + 1;

my $dirsGiven = 0;
my $flags = "";
my @dirs = ("");

for(my $cnt = 0; $cnt < $numArgs; $cnt++) {
    #print substr($ARGV[$cnt],0,1);
    if(substr($ARGV[$cnt],0,1) =~ '/') {
       $flags = "$flags $ARGV[$cnt]";
    } else {
       $dirsGiven = 1;
       unshift(@dirs, "$ARGV[$cnt]\\\\");
    }
}

foreach my $line (@files) {
    chomp $line;

    # Spilt into file name and expected output
    my ($file, $out) = split(/ +/, $line);

    $file =~ s{\\}{/}g;

    # skip empty lines
    if($file eq "") {
	    next;
    }

    # if target directories have been given, ignore other directories
    if($dirsGiven) {
	my $found = 0;
	for(my $cnt = 0; $cnt < $#dirs; $cnt++) {
	    my $dir = $dirs[$cnt];
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
    my $dir = dirname($file);
    #print "Directory given: $dir";

    # check if files exists
    open(TMP_HANDLE, $file) || die "File $file does not exist\n";
    close (TMP_HANDLE);

    my @files;
    my $buildPath = File::Spec->catfile('..', '..', 'source', 'Corral', 'bin', $BuildConfig);
    find( sub {
        # Skip any `publish` directories
        $File::Find::prune = 1 if $File::Find::name =~ m/\bpublish\b/;

        # Only look for corral executables
        return unless -f && /^corral([.]exe)?$/i;

        push @files, $File::Find::name;
    }, $buildPath );
    die "No corral executable found" unless scalar(@files) > 0;
    warn "Multiple corral executables found: @{[ join(', ', @files) ]}" unless scalar(@files) == 1;

    my $corralPath = File::Spec->abs2rel($files[0], $dir);
    my $configPath = 'config';
    my $filePath = basename($file);
    my $outputPath = File::Spec->catfile(cwd(), 'out');
    my $cmd = join(' ', $corralPath, $filePath, "/flags:$configPath", $flags, '>', $outputPath);
    print $cmd; print "\n";
    {
        my $wd = cwd();
        chdir $dir;
        system($cmd);
        chdir $wd;
    }

    # Check result
    open(TMP_HANDLE, $outputPath)  || die "Command did not produce an output\n";
    my @res = <TMP_HANDLE>;
    close(TMP_HANDLE);

    my @correct;
    my $ok = 1;

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
