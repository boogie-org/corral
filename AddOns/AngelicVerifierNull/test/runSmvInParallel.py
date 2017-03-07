#!/usr/bin/pythonprin

import threading
import time
import sys
import queue
import os
from subprocess import call
import subprocess

import sys
import linecache

def traceit(frame, event, arg):
    if event == "line":
        lineno = frame.f_lineno
        filename = frame.f_globals["__file__"]
        print ("file  " + filename + " line " + str(lineno))
    return traceit


#############################
# Constants
#############################
avnPath = "e:\\temp\\smv\\smv-fastavn-11-18-2016\\analysisPlugins\\avn\\bin"
propInstPath = "e:\\corral\\AddOns\\PropInst\\PropInst\\bin\\debug\\PropInst"
propertyFile = "e:\\corral\\AddOns\\AngelicVerifierNull\\test\\c-smack\\useafterfree-windows.avp"
testBpl = "test_uaf.bpl"
bplDirRoot = "e:\\temp\\avKernel2016\\BPL.11.29\\"

NUM_THREADS = 30
MAXCNT = 1000

q = queue.Queue()

def worker_thread():
    while True:
        item = q.get()
        process_bpl(item)
        q.task_done()
        print_flush("after q.taskdone...")

# print and flush
def print_flush(s):
    print(s)
    sys.stdout.flush()

# find all the BPLs in a root director
def put_tasks_in_q(rootDir):
    cnt = 0
    os.environ["PATH"] += os.pathsep + avnPath
    print_flush("rootdir = " + rootDir)
    for root, dirs, files in os.walk(rootDir):
        for file in files:
            if cnt > MAXCNT: break
            if (file == "li2c_prog.bpl"):
                print_flush("Adding " + root + " to q with cnt = " + str(cnt))
                q.put((root,file))
                cnt  = cnt + 1

def process_bpl(f):
    process_bpl_file(f[0], f[1])

# process a li2c_prog.bpl file
def process_bpl_file(root, bplFile):
    print_flush ("+++++++++ Starting process for %s ++++++++++++++" % (root))
    p = subprocess.Popen([propInstPath, propertyFile, bplFile, testBpl], cwd = root)
    p.wait()
    process_smv_process(root, testBpl)

def process_smv_process(root, bplFile):
    try:
        p = subprocess.Popen(['avn.cmd', bplFile, '/cloud'], cwd = root)
        p.wait()
    except: 
        print_flush("process_smv_process:Failed")

# put all tasks in queue
put_tasks_in_q(bplDirRoot)

for i in range(NUM_THREADS):
    t = threading.Thread(target=worker_thread)
    t.daemon = True
    t.start()

q.join()   

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



