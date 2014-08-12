AVN Regression Test

- Directory structure:

avn-test\
	prefix\			Prefix results in CSV format
	brunch.py		Parallel AVN benchmark runner
	drivers			Paths to individual BPL test file
	README			This file
	run.cmd			Batch script to fire the tests

- Usage:

1. Configure tool options in run.cmd
2. Execute run.cmd
3. Results and output are stored in "REGRESS.YYYY.MM.DD-HH\"