# Parallel Benchmark Runner
# Last modified: June 29, 2014

import os
import os.path
import sys
import csv
import time, threading
import traceback
import math

def isexec (fpath):
    if fpath == None: return False
    return os.path.isfile(fpath) and os.access(fpath, os.X_OK)

def which(program):
    fpath, fname = os.path.split(program)
    if fpath:
        if isexec (program):
            return program
    else:
        for path in os.environ["PATH"].split(os.pathsep):
            exe_file = os.path.join(path, program)
            if isexec (exe_file):
                return exe_file
    return None

# collect stats from output file given prefix of stat line
def collectStats (stats, tag, file):
    with open (file, 'r') as f:
        try:
            for line in f:
                # Process other stats
                fld = line.replace(tag, '').strip()
                if not ':' in fld: continue
                stat_pair = fld.split (':')
                stats [stat_pair[0].strip()] = stat_pair[1].strip()
        except IndexError:
            print "Error when collecting stats!"
            traceback.print_exc()
        finally:
            f.close()
        
    return stats

# output header to stats file
def statsHeader (stats_file, flds):
    with open (stats_file, 'wb') as sf:
        writer = csv.writer (sf)
        writer.writerow (flds)

def parseArgs (argv):
    import argparse as a
    p = a.ArgumentParser (description='Angelic Verifier NULL Regression Tests Runner')
    p.add_argument ('--threads', metavar="NUM", type=int,
                    help='Number of maximum allowed threads',
                    default=1)
    p.add_argument ('--cpu', metavar='CPU',type=int, help='CPU limit',
                    default=600)
    p.add_argument ('--mem', metavar='MEM',type=int, help='Memory limit (MB)',
                    default=512)
    p.add_argument ('--bench', metavar='BENCH', required=True,
                    help='File specifies paths to benchmark files')
    p.add_argument ('--tag', default='[TAG: AV_STATS]', help='Tag prefix for stats')
    p.add_argument ('--format', required=True, help='Stats Fields')
    p.add_argument ('--out', metavar='DIR', default='brunch.out', help='Output directory')
    p.add_argument ('--debug', action="store_true",
                    default=False, help='Debugging mode')

    if '-h' in argv or '--help' in argv:
	p.print_help ()
	p.exit (0)
    try:
	k = argv.index ('--')
    except ValueError:
	p.error ("No '--' argument")

    args = p.parse_args (argv[:k])
    args.tool_args = argv[k+1:]

    return args

# thread model for running the tool
class toolThread (threading.Thread):
    def __init__(self, tool_args, tag, f, out, fmt):
        threading.Thread.__init__(self)

        self.kill_received = False
	self.tool_args = tool_args
        self.tag = tag
        self.f = f
        self.out = out
        self.fmt = fmt
        self.process = None
        
    def kill (self):
        if self.process is not None:
            self.process.terminate()
                
    def statsLine (self, stats_file, fmt, stats):
        line = list()
        for fld in fmt:
            if fld in stats:
                line.append (str (stats [fld]))
            else: line.append (None)

        with threading.Lock():
            with open (stats_file, 'ab') as sf:
                writer = csv.writer (sf)
                writer.writerow (line)

    def runTool (self, tool_args, tag, f, out, fmt):
        cpuStart = time.clock()

	fmt_tool_args = [v.format(f=f) for v in tool_args]
	fmt_tool_args[0] = which (fmt_tool_args[0])
	base = os.path.basename (f)
	outfile = os.path.join (out, base + '.stdout')
	errfile = os.path.join (out, base + '.stderr')
	bench_dir = os.path.abspath(base)

	import subprocess as sub
	if not os.path.exists(bench_dir):
            os.mkdir(bench_dir)

        self.process = sub.Popen (fmt_tool_args, stdout=open(outfile, 'w'),
                                  stderr=open(errfile, 'w'), cwd=bench_dir)

	self.process.wait ()

	cpuUsage = time.clock() - cpuStart
	
	stats = dict()
        stats['File'] = f
        stats['Base'] = base
        stats['Status'] = self.process.returncode
        stats['Cpu'] = '{:.2f}'.format (cpuUsage)
        stats['Result'] = 'UNKNOWN'

        stats = collectStats (stats, tag, outfile)
        stats = collectStats (stats, tag, errfile)
	self.statsLine (os.path.join (out, 'stats.csv'), fmt, stats)

    def run (self):
	threadLimiter.acquire()
	try:
            with threading.Lock():
                print "Starting " + self.name + " : " + self.f
	    self.runTool (self.tool_args, self.tag, self.f,
                                  self.out, self.fmt)
	    with threading.Lock():
                print "Exiting " + self.name + " : " + self.f
	except KeyboardInterrupt:
            self.kill()
        except:
	    print "Error detected when running: ", self.f
	    traceback.print_exc()
        finally:
	    threadLimiter.release()


def main (argv):
    args = parseArgs (argv[1:])

    if not os.path.exists (args.out):
	    os.mkdir (args.out)

    tag = args.tag.strip()
    fmt = args.format.strip("'").split (':')

    # recording the config details
    with open ('config.txt', 'wb') as config_file:
        config_file.write(' '.join(argv[1:]))
    
    statsHeader (os.path.join (args.out, 'stats.csv'), fmt)

    global threadLimiter
    threadLimiter = threading.BoundedSemaphore(args.threads)
    print "Starting threads ..."
    jobs = []

    try:
        benchStart = time.clock()
        # threading.stack_size(4096000*(int(math.ceil(args.mem/4))))
	for f in open(args.bench, 'rb'):
            if f.startswith('#'):
                continue
    	    job = toolThread(args.tool_args, tag,
                                 os.path.abspath(f.strip()),
                                 args.out, fmt)
    	    job.daemon = True
	    jobs.append(job)
	    job.start()

	for job in jobs:
	    if job is not None and job.isAlive():
                job.join()

	print "All jobs finished!"
	benchStart = time.clock() - benchStart
	print "Total Time: " + str(benchStart)

    except KeyboardInterrupt:
        for j in jobs:
            j.kill_received = True
        print "\nTerminate because of user keyboard interrupt!"
    except ValueError:
        print "\nUnsupported stack size!"

    return 0

if __name__ == '__main__':
    sys.exit (main (sys.argv))
