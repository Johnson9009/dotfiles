#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import sys


def ipython_entry():
    from IPython import start_ipython
    sys.exit(start_ipython())


def pudb_entry():
    from pudb.run import main
    sys.exit(main())


packages_info = {
    'pip'      : {'interpreter' : 'python',  'entry' : ['-m', 'pip']},
    'pip2'     : {'interpreter' : 'python2', 'entry' : ['-m', 'pip']},
    'pip3'     : {'interpreter' : 'python3', 'entry' : ['-m', 'pip']},
    'ipython'  : {'interpreter' : 'python',  'entry' : ipython_entry},
    'ipython2' : {'interpreter' : 'python2', 'entry' : ipython_entry},
    'ipython3' : {'interpreter' : 'python3', 'entry' : ipython_entry},
    'pudb'     : {'interpreter' : 'python',  'entry' : pudb_entry},
    'pudb2'    : {'interpreter' : 'python2', 'entry' : pudb_entry},
    'pudb3'    : {'interpreter' : 'python3', 'entry' : pudb_entry},
}


def launch_package_using_correct_interpreter(package_info, from_symlink):
    import types
    if (isinstance(package_info['entry'], types.FunctionType) is True):
        # Optimization for executed by symbolic link.
        if ((from_symlink is True) and (package_info['interpreter'] == 'python')):
            package_info['entry']()
        else:
            sys.argv.append('\n')
            os.execvp('/usr/bin/env',
                      ['/usr/bin/env', package_info['interpreter'], os.path.realpath(__file__)] + sys.argv)
    else:
        os.execv('/usr/bin/env',
                 ['/usr/bin/env', package_info['interpreter']] + package_info['entry'] + sys.argv[1:])


fuse = os.path.abspath(sys.argv[0])
# Executed by symbolic link and current Python interpreter must be '/usr/bin/env python'.
if (os.path.islink(fuse) is True):
    package = os.path.basename(fuse)
    cur_pkg_info = packages_info.get(package, {'interpreter' : None, 'entry' : None})
    if ((cur_pkg_info['interpreter'] is None) or (cur_pkg_info['entry'] is None)):
        sys.stderr.write('Error: Running from unknow symbolic link "%s",\n'
                         '       this Python package launcher script should only be run through symbolic link,\n'
                         '       please add the package support code corresponding to this symbolic link and\n'
                         '       retry.\n' % fuse)
        sys.exit(1)
    else:
        launch_package_using_correct_interpreter(cur_pkg_info, True)

# Executed by user or this Python script itself not by symbolic link.
# Executed by user and haven't provide package name.
if (len(sys.argv) == 1):
    sys.stderr.write('Error: This Python package launcher script should only be run through symbolic link,\n'
                     '       if you still want run it manually, please provide at least package name argument.\n')
    sys.exit(1)
else:
    # Remove current script name from argument list to prepare invoke the entry of target package.
    del(sys.argv[0])

package = os.path.basename(sys.argv[0])
cur_pkg_info = packages_info.get(package, {'interpreter' : None, 'entry' : None})
if ((cur_pkg_info['interpreter'] is None) or (cur_pkg_info['entry'] is None)):
    sys.stderr.write('Error: Unsupported package "%s", this Python package launcher script should only\n'
                     '       be run through symbolic link, please add the package support code corresponding to\n'
                     '       this package and retry.\n' % package)
    sys.exit(1)

# Executed by this script itself and current Python interpreter already is the correct one.
if (sys.argv[-1] == '\n'):
    del(sys.argv[-1])
    cur_pkg_info['entry']()
# Executed by user and we don't know which Python interpreter is used, so we can't do any optimization.
else:
    launch_package_using_correct_interpreter(cur_pkg_info, False)
