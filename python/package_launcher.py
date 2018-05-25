#!/usr/bin/env python
import os
import sys


# For now the reason why below two packages using function entry is performance optimization and
# demonstration.
def ipython_entry():
    from IPython import start_ipython
    sys.exit(start_ipython())


def pudb_entry():
    from pudb.run import main
    sys.exit(main())


packages_info = {
    'pip'      : ['-m', 'pip'],
    'bpython'  : ['-m', 'bpython'],
    'ipython'  : ipython_entry,
    'pudb'     : pudb_entry,
}


def launch_package_using_correct_interpreter(interpreter, entry):
    import types
    if (isinstance(entry, types.FunctionType) is True):
        # Optimization for executed by symbolic link.
        if (interpreter == 'python'):
            entry()
        else:
            sys.argv.append('\n')
            os.execvp('/usr/bin/env',
                      ['/usr/bin/env', interpreter, os.path.realpath(__file__)] + sys.argv)
    else:
        os.execv('/usr/bin/env', ['/usr/bin/env', interpreter] + entry + sys.argv[1:])


fuse = os.path.abspath(sys.argv[0])
# Executed by symbolic link and current Python interpreter must be '/usr/bin/env python'.
if (os.path.islink(fuse) is True):
    package = os.path.basename(fuse)
    interpreter = 'python'
    if ((package[-1] == '2') or (package[-1] == '3')):
        interpreter += package[-1]
        package = package[:-1]
    entry = packages_info.get(package, None)
    if (entry is None):
        sys.stderr.write(
            'Error: Running from unknow symbolic link "%s",\n'
            '       this Python package launcher script only can be run through symbolic link,\n'
            '       please add the package support code corresponding to this symbolic link and\n'
            '       retry.\n' % fuse)
        sys.exit(1)
    else:
        launch_package_using_correct_interpreter(interpreter, entry)

# Executed by this script itself and current Python interpreter already is the correct one.
if (sys.argv[-1] == '\n'):
    # Remove current script name and the last dummy argument from argument list to prepare invoke
    # the entry of target package.
    del(sys.argv[0])
    del(sys.argv[-1])
    # The package name here must be xx2 or xx3.
    package = os.path.basename(sys.argv[0])[:-1]
    packages_info[package]()
else:
    sys.stderr.write(
        'Error: This Python package launcher script only can be run through symbolic link,\n'
        '       please create correct symbolic link to it and retry.\n')
    sys.exit(1)
