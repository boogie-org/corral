#!/usr/bin/python

# A simple python utility to summarize an fastavn run

import os
import fnmatch
import re
import sys

inp = sys.argv[1]
#print ("inp is ", inp)

for root, dir, file in os.walk(inp):
        #print ("*************** " + root + " *************")
        fm = fnmatch.filter(file, "smvexecute.log")
        if (fm):
                #find the full name
                fpath = os.path.join(root,fm[0])
                stats = [root]
                header = ["procedure"]
                for line in open(fpath,"r"):
                        if (line.__contains__("AV_STATS")):
                                r = re.compile(r'.*AV_STATS](.*) : (.*)')
                                g = re.search(r,line)
                                if (g):
                                    r1 = re.compile(r'explain.*|blocked.*|bug.count.*')
                                    g1 = re.search(r1,line)
                                    if not g1:
                                        #stats.append((g.group(1),g.group(2)))
                                        stats.append(g.group(2))
                                        header.append(g.group(1))

                if (stats.__len__() > 1):
                    print (stats)
print (header)
