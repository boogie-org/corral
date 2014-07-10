# Parallel Benchmark Runner
# Last modified: June 27, 2014

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

def collectStats (stats, tag, file):
    try:
        f = open (file, 'r')
        for line in f:
            if not line.startswith (tag): continue
            if not ' : ' in line: continue

            fld = line.split (' ')
            if len(fld) < 2: continue

            stat_pair = fld[1].split (':')
            stats [stat_pair[0]] = stat_pair[1].strip ()

        f.close()
    except:
        print "Error when collecting stats!"
        
    return stats

def statsHeader (stats_file, flds):
    with open (stats_file, 'w') as sf:
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
	p.add_argument ('--prefix', default='[TAG: AV_STATS]', help='Prefix for stats')
	p.add_argument ('--format', required=True, help='Stats Fields')
	p.add_argument ('--out', metavar='DIR', default='brunch.out', help='Output directory')

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
                if fld in stats: line.append (str (stats [fld]))
                else: line.append (None)

            self.lock.aquire()
            try:
                with open (stats_file, 'a') as sf:
                    writer = csv.writer (sf)
                    writer.writerow (line)
            except:
                print "Error when writing stats file!"
            finally:
                self.lock.release()

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
		stats['Cpu'] = '{:.2f}'.format (cpuUsage - cpuStart)

		stats = collectStats (stats, tag, outfile)
		stats = collectStats (stats, tag, errfile)
                stats = collectStats (stats, tag, os.path.join(bench_dir, 'results'))
		self.statsLine (os.path.join (out, 'stats'), fmt, stats)

	def run (self):
		threadLimiter.acquire()
		try:
		    print "Starting " + self.name
		    self.runTool (self.tool_args, self.tag, self.f,
                                  self.out, self.fmt)
		    print "Exiting " + self.name
		except KeyboardInterrupt:
                    self.kill()
		except:
		    print "Error detected when running: ", self.f
		    traceback.print_exc()
		    threadLimiter.release()


def main (argv):
	args = parseArgs (argv[1:])

	if not os.path.exists (args.out):
		os.mkdir (args.out)

	tag = args.prefix
	fmt = args.format.split (':')
	statsHeader (os.path.join (args.out, 'stats'), fmt)

	global threadLimiter
	threadLimiter = threading.BoundedSemaphore(args.threads)
	print "Starting threads ..."
	jobs = []

	try:
            # threading.stack_size(4096000*(int(math.ceil(args.mem/4))))
	    for f in open(args.bench, 'r'):
    		job = toolThread(args.tool_args, args.prefix,
                                 os.path.abspath(f.strip()),
                                 args.out, fmt)
    		job.daemon = True
		jobs.append(job)
		job.start()

	    for job in jobs:
		if job is not None and job.isAlive():
                    job.join()

	    print "All jobs finished!"

	except KeyboardInterrupt:
            for j in jobs:
                j.kill_received = True
            print "\nTerminate because of user keyboard interrupt!"
	except ValueError:
            print "\nUnsupported stack size!"

	return 0

if __name__ == '__main__':
    sys.exit (main (sys.argv))
