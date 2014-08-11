# Match bug lists of AVN and Prefix
# Last modified: June 29, 2014
# Author: Yi Li

import os
import os.path
import sys
import csv
import math
import itertools

def parseArgs (argv):
    import argparse as a

    p = a.ArgumentParser (description='AVN results matcher')
    p.add_argument ('--bench', metavar="BEN", required=True,
                    help='Path to driver BPL files')
    p.add_argument ('--avn', metavar="AVN", required=True,
                    help='Path to AVN regression test output folder')
    p.add_argument ('--prefix', metavar="PRE", required=True,
                    help='Path to Prefix bug lists')
    p.add_argument ('--out', metavar="OUT", default='matching_result.csv',
                    help='Output file of matching results')

    if '-h' in argv or '--help' in argv:
        p.print_help()
        p.exit(0)

    return p.parse_args (argv)

def checkInModule (path, src):
    root = os.path.splitext(os.path.basename(path.replace('\\results.csv','')))[0]
    prefix_dir = '..\\smv-bench\\' + root.replace('.sdxroot.','d..fbl_hyp_dev')
    prefix_path = os.path.join(prefix_dir, 'src', os.path.basename(src))
    
    if not os.path.exists(prefix_path):
        print prefix_path

# return dictionary {(src,line):description}
def getAVNResult (path):
    res = dict()
    with open(path, 'rb') as f:
        reader = csv.DictReader(f)
        for row in reader:
            srcfile = row['Src File'].strip()

            checkInModule (path, srcfile)
            
            lineno = row['Line'].strip()
            res[(srcfile,lineno)] = row['Description'].strip()

            print row['Src File'] + " : " + row['EntryPoint'] + " : " + row['Line'] + " : " + row['Procedure'] + " : " + row['Description']
            
    return res

def getPrefixResult (path):
    res = dict()
    with open(path, 'rb') as f:
        reader = csv.DictReader(f)
        for row in reader:
            # only care about NULL bugs
            if not row['Warning'] == '11':
                continue
            
            srcfile = row['Src File'].strip()

            # verify that the error location is in driver files
            checkInModule (path, srcfile)
            #print srcfile
            
            lineno = row['Line'].strip()
            res[(srcfile,lineno)] = row['Description'].strip()
    return res

# input: two (src, line) pairs p1 and p2
# output: True if p1 and p2 match approximately
# e.g., similar src file name and close line number
def approxMatch (p1, p2):
    isMatch = (os.path.basename(p1[0]) == os.path.basename(p2[0])) and (math.fabs(int(p1[1].strip()) - int(p2[1].strip())) < 3)

    return isMatch


def main (argv):
    args = parseArgs (argv[1:])

    if not (os.path.exists (args.avn)
            and os.path.exists (args.prefix)
            and os.path.exists (args.bench)):
        print "Incorrect path!"
        sys.exit (-1)

    # header
    with open (args.out.strip(), 'wb') as f:
        f.write ('base,avn,prefix,match\r\n')
    for f in open(args.bench, 'r'):
        if f.startswith('#'):
            continue
        bname = os.path.basename(f).strip()
        print "matching ", bname

        try:
            avn_res = getAVNResult (os.path.join(
                os.path.abspath(args.avn),
                bname,
                'results.csv'))
        except IOError:
            print "AVN result is not ready!"
            continue

        prefix_res = getPrefixResult (os.path.join(
            os.path.abspath(args.prefix),
            bname).replace('.bpl','.csv'))

        
        
        # print prefix_res.keys()
        #for (src,line) in avn_res.viewkeys() & prefix_res.viewkeys():
        count = 0
        for (p1, p2) in itertools.product (avn_res.keys(), prefix_res.keys()):
            if approxMatch (p1, p2):
                print p1, " : ", p2
                count += 1
        print "AVN: ", len(avn_res), " Prefix: ", len(prefix_res), " Match: ", count

        line = [bname, len(avn_res), len(prefix_res), count]
        with open (args.out.strip(), 'ab') as sf:
            writer = csv.writer (sf)
            writer.writerow(line)
            
        print ""

if __name__ == '__main__':
    sys.exit (main (sys.argv))
