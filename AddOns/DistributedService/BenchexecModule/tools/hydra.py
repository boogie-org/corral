# This file is part of BenchExec, a framework for reliable benchmarking:
# https://github.com/sosy-lab/benchexec
#
# SPDX-FileCopyrightText: 2007-2020 Dirk Beyer <https://www.sosy-lab.org>
#
# SPDX-License-Identifier: Apache-2.0

import os
import logging
import subprocess
import re

import benchexec
import benchexec.result as result
import benchexec.util as util
import benchexec.tools.template



class Tool(benchexec.tools.template.BaseTool):

    REQUIRED_PATHS = ["corral", "smack", "smack.sh"]

    def executable(self):
        """
        Tells BenchExec to search for 'hydra.sh' as the main executable to be
        called when running HYDRA.
        """
        return util.find_executable("hydra.sh")    

    def name(self):
        """
        Sets the name for HYDRA, which gets displayed in the "Tool" row in
        BenchExec table headers.
        """
        return "HYDRA"

    def cmdline(self, executable, options, tasks, propertyfile=None, rlimits={}):
        """
        Allows us to define special actions to be taken or command line argument
        modifications to make just before calling HYDRA.
        """
                
        return [executable] + tasks + options

    def program_files(self, executable):
        """
        OPTIONAL, this method is only necessary for situations when the benchmark environment
        needs to know all files belonging to a tool
        (to transport them to a cloud service, for example).
        Returns a list of files or directories that are necessary to run the tool,
        relative to the current directory.
        The default implementation returns a list with the executable itself
        and all paths that result from expanding patterns in self.REQUIRED_PATHS,
        interpreting the latter as relative to the directory of the executable.
        @return a list of paths as strings
        """
        return [executable] + self._program_files_from_executable(
            executable, self.REQUIRED_PATHS
        )

    def _program_files_from_executable(
        self, executable, required_paths, parent_dir=False
    ):
        """
        Get a list of program files by expanding a list of path patterns
        and interpreting it as relative to the executable.
        This method can be used as helper for implementing the method program_files().
        Contrary to the default implementation of program_files(), this method does not explicitly
        add the executable to the list of returned files, it assumes that required_paths
        contains a path that covers the executable.
        @param executable: the path to the executable of the tool (typically the result of executable())
        @param required_paths: a list of required path patterns
        @param parent_dir: whether required_paths are relative to the directory of executable or the parent directory
        @return a list of paths as strings, suitable for result of program_files()
        """
        base_dir = os.path.dirname(executable)
        if parent_dir:
            base_dir = os.path.join(base_dir, os.path.pardir)
        return util.flatten(
            util.expand_filename_pattern(path, base_dir) for path in required_paths
        )
    def determine_result(self, returncode, returnsignal, output, isTimeout):
        """
        Parse the output of the tool and extract the verification result.
        If the tool gave a result, this method needs to return one of the
        benchexec.result.RESULT_* strings.
        Otherwise an arbitrary string can be returned that will be shown to the user
        and should give some indication of the failure reason
        (e.g., "CRASH", "OUT_OF_MEMORY", etc.).
        For tools that do not output some true/false result, benchexec.result.RESULT_DONE
        can be returned (this is also the default implementation).
        BenchExec will then automatically add some more information
        if the tool was killed due to a timeout, segmentation fault, etc.
        @param returncode: the exit code of the program, 0 if the program was killed
        @param returnsignal: the signal that killed the program, 0 if program exited itself
        @param output: a list of strings of output lines of the tool (both stdout and stderr)
        @param isTimeout: whether the result is a timeout
        (useful to distinguish between program killed because of error and timeout)
        @return a non-empty string, usually one of the benchexec.result.RESULT_* constants
        """
        return result.RESULT_DONE

