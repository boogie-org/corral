#!/usr/bin/pythonprin

import threading
import time
import sys
import queue
import os
from subprocess import call
import subprocess


#############################
# Constants
#############################
avnPath = "e:\\temp\\smv\\smv-fastavn-10-21-2016\\analysisPlugins\\avn\\bin"
propInstPath = "e:\\corral\\AddOns\\PropInst\\PropInst\\bin\\debug\\PropInst"
propertyFile = "e:\\corral\\AddOns\\AngelicVerifierNull\\test\\c-smack\\useafterfree-windows.avp"
testBpl = "test_uaf.bpl"
bplDirRoot = "e:\\temp\\avKernel2016\\BPL\\onecore\\ds\\security\\appid\\runtime\\"

# print and flush
def print_flush(s):
    print(s)
    sys.stdout.flush()

# find all the BPLs in a root director
def process_bpls(rootDir):
    os.environ["PATH"] += os.pathsep + avnPath
    print_flush("rootdir = " + rootDir)
    for root, dirs, files in os.walk(rootDir):
        for file in files:
            if (file == "li2c_prog.bpl"):
                process_bpl_file(root, file)

# process a li2c_prog.bpl file
def process_bpl_file(root, bplFile):
    print_flush ("+++++++++ Starting process for %s ++++++++++++++" % (root))
    os.chdir(root)
    call ([propInstPath, 
           propertyFile, 
           bplFile, 
           testBpl])
    process_smv_process(root, testBpl)

def process_smv_process(root, bplFile):
    try:
        subprocess.Popen(['avn.cmd', bplFile, '/cloud'], cwd = root)
    except: 
        print_flush("process_smv_process:Failed")

# run_smv main
process_bpls(bplDirRoot)
    

################################################
# deprecated stuff
################################################
smvQ = queue.Queue(100)
 # using threads is hard as we need to change dir (shared across process) to root
def process_smv_thread(root,bplFile):
    try:
        t = threading.Thread(target = process_smv, args = (root, bplFile))
        smvQ.put(t)
        t.start()
        t.join() # lets just make it sequential until we can figure out the chdir issue
        os.chdir(root)
        call (["avn.cmd", "test_uaf.bpl", "/cloud"])
    except:
        print_flush ("process_smv:Failed")

def wait_for_all_threads():
    while smvQ.not_empty():
        t = smvQ.get()
        t.join()
    print_flush ("Done with all processes")

# Define a function for the thread
def print_time( threadName, delay):
   count = 0
   while count < 5:
      time.sleep(delay)
      count += 1
      print_flush ("%s : %s" % ( threadName, time.ctime(time.time())))

# Create two threads and put them in a queue
def dummy_main():
    q = queue.Queue(3)
    try:
        t1 = threading.Thread(target = print_time, args = ("Thread-1", 2,))
        q.put(t1)
        t1.start()
        t2 = threading.Thread(target = print_time, args = ("Thread-2", 4,))
        q.put(t2)
        t2.start()
    except:
        print("Error: unable to start thread")
    while not q.empty():
        t = q.get()
        t.join()



