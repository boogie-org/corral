import os
import argparse
import subprocess
import signal
import re
import sys

def arguments():

  parser = argparse.ArgumentParser()

  parser.add_argument('input_file', metavar='input-file',
    help = 'source file (*.bpl or *.c)')    
  
  parser.add_argument('-v', '--verbose', action='store_true', default=False,
    help = 'verbose mode')

  smack_group = parser.add_argument_group("SMACK options")

  smack_group.add_argument('--smack-options', metavar='OPTIONS', default='',
    help = 'additional SMACK arguments (e.g., --smack-options="-bc a.bc")')

  si_group = parser.add_argument_group("SmackInst options")

  si_group.add_argument('-init-mem', action='store_true', default=False,
    help = 'initialize memory')

  avh_group = parser.add_argument_group("AvHarnessInstrument options")
  
  avh_group.add_argument('-aa', action='store_true', default=False,
    help = 'use alias analysis')

  avh_group.add_argument('--unknown-procs', metavar='PROC', nargs='+',
    default=['malloc'], help = 'specify angelic unknown procedures [default: %(default)s]')

  avh_group.add_argument('--harness-options', metavar='OPTIONS', default='',
    help = 'additional AvHarnessInstrumentation arugments (e.g., --harness-options="x")'
  )

  avn_group = parser.add_argument_group("AngelicVerifierNull options")

  avn_group.add_argument('--unroll', metavar='N', type=int,
    default=5, help = 'loop unrolling bound [default: %(default)s]')

  avn_group.add_argument('-sdv', action='store_true', default=False, 
    help = 'use sdv output format')

  avh_group.add_argument('--verifier-options', metavar='OPTIONS', default='',
    help = 'additional AngelicVerifierNull arugments (e.g., --verifer-options="y")'
  )

  return parser.parse_args()
  
def find_exe(args):
  args.si_exe = GetBinary('SmackInst')
  args.avh_exe = GetBinary('AvHarnessInstrumentation')
  args.avn_exe = GetBinary('AngelicVerifierNull')

def GetBinary(BinaryName):
  up = os.path.dirname
  corralRoot = up(up(up(up(up(os.path.abspath('__file__'))))))
  avRoot = os.path.join(corralRoot, 'AddOns')
  root = os.path.join(avRoot, 'SmackInst') if (BinaryName == 'SmackInst') else os.path.join(avRoot, 'AngelicVerifierNull')
  return os.path.join(
          os.path.join(
           os.path.join(
            os.path.join(root, BinaryName), 'bin'),'Debug'),
             BinaryName + '.exe')

# ported from SMACK top.py
# time-out is not supoorted

def try_command(args, cmd, console = False):
  console = console or args.verbose
  output = '' 
  proc = None

  try:
    if args.verbose:
      print 'Running %s' %(' '.join(cmd))
    
    proc = subprocess.Popen(cmd,
      stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    if console:
      while True:
        line = proc.stdout.readline()
        if line:
          output += line
          print line,
        elif proc.poll() is not None:
          break
      proc.wait
    else:
      output = proc.communicate()[0]

    rc = proc.returncode
    proc = None
    if rc:
      raise RuntimeError("%s returned non-zero." % cmd[0])
    else:
      return output

  except (RuntimeError, OSError) as err:
    print >> sys.stderr, output
    sys.exit("Error invoking command:\n%s\n%s" % (" ".join(cmd), err))

  finally:
    if proc: os.killpg(os.getpgid(proc.pid), signal.SIGKILL)

def runsmack(args):
  #print 'Running SMACK'
  if os.name != 'posix':
    print 'OS not supported'

  cmd = ['smack', '--no-verify']
  cmd += [args.input_file]
  cmd += ['-bpl', args.file_name + '.bpl']
  cmd += args.smack_options.split()
  
  return try_command(args, cmd, False)  
    
def runsi(args):
  #print "Running SmackInst at: '{}'".format(args.si_exe)
  if (not os.path.exists(args.si_exe)):
    print "SmackInst not found" 

  cmd = [args.si_exe]
  if os.name == 'posix':
    cmd = ['mono'] + cmd   
  cmd += [args.file_name + '.bpl']
  cmd += [args.file_name + '.inst.bpl']
  if args.init_mem:
    cmd += ['/initMem']
  
  return try_command(args, cmd, False) 

def runavh(args):
  #print "Running AvHarnessInstrumentation at: '{}'".format(args.avh_exe) 
  if (not os.path.exists(args.avh_exe)):
    print "AvHarnessInstrument not found" 

  cmd = [args.avh_exe]
  if os.name == 'posix':
    cmd = ['mono'] + cmd
  cmd += [args.file_name + '.inst.bpl']
  cmd += [args.file_name + '.harness.bpl']
  cmd += args.harness_options.split()

  if args.aa:
    cmd += ['/noAA:0']
  else:
    cmd += ['/noAA']

  cmd += ['/unknownProc:' + proc for proc in args.unknown_procs]
  return try_command(args, cmd, True)

def runavn(args):
  #print "Running AngelicVerifierNull at: '{}'".format(args.avn_exe)
  if (not os.path.exists(args.avn_exe)):
    print "AngelicVerifierNull not found" 

  cmd = [args.avn_exe]
  if os.name == 'posix':
    cmd = ['mono'] + cmd
  cmd += [args.file_name + '.harness.bpl']
  cmd += ['/nodup']
  cmd += ['/traceSlicing']
  cmd += ['/copt:recursionBound:' + str(args.unroll)]
  cmd += ['/copt:k:1']
  if args.sdv:
    cmd += ['/sdv']
  else:
    cmd += ['/copt:tryCTrace']
  cmd += args.verifier_options.split()
  return try_command(args, cmd, False) 

def output_summary(output):
  av_output = ''

  for line in output.splitlines(True):
    if re.search('AV_OUTPUT', line):
      av_output += line
  
  return av_output

if __name__ == '__main__':
  args = arguments()
  args.file_name = os.path.splitext(args.input_file)[0]

  if (os.path.splitext(args.input_file)[1][1:] == 'c'):
    smack_output = runsmack(args)

  
  find_exe(args)
 
  si_output = runsi(args) 
  avh_output = runavh(args)
  avn_output = runavn(args)

  print output_summary(avn_output).strip()
