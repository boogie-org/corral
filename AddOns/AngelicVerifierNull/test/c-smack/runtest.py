import os
import argparse

def arguments():

  parser = argparse.ArgumentParser()

  parser.add_argument('input_file', metavar='input-file',
    help = 'source file (*.bpl or *.c)')    

  avh_group = parser.add_argument_group("AvHarnessInstrument options")
  
  avh_group.add_argument('-aa', action='store_true', default=False,
    help = 'use alias analysis')
  avh_group.add_argument('--unknown-procs', metavar='PROC', nargs='+',
    default=['malloc'], help = 'specify angelic unknown procedures [default: %(default)s]')

  avn_group = parser.add_argument_group("AngelicVerifierNull options")

  avn_group.add_argument('--loop-unroll', metavar='N', type=int,
    default=5, help = 'loop unrolling bound [default: %(default)s]')

  avn_group.add_argument('-sdv', action='store_true', default=False, 
    help = 'use sdv output format')

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

def runsmack(args):
  print 'Running SMACK'
    
def runsi(args):
  print "Running SmackInst at: '{}'".format(args.si_exe)
  if (not os.path.exists(args.si_exe)):
    print "SmackInst not found" 
  return None

def runavh(args):
  print "Running AvHarnessInstrumentation at: '{}'".format(args.avh_exe) 
  if (not os.path.exists(args.avh_exe)):
    print "AvHarnessInstrument not found" 
  return None

def runavn(args):
  print "Running AngelicVerifierNull at: '{}'".format(args.avn_exe)
  if (not os.path.exists(args.avn_exe)):
    print "AngelicVerifierNull not found" 
  return None

if __name__ == '__main__':
  args = arguments()

  if (os.path.splitext(args.input_file)[1][1:] == 'c'):
    runsmack(args)
  
  find_exe(args)
 
  si_output = runsi(args) 
  avh_output = runavh(args)
  avn_output = runavn(args)
