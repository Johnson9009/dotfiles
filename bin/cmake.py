#!/usr/bin/env python
from sys import argv
from os import path, chdir, execvp
from subprocess import check_call

build_type = {
    'cmkd'  : 'Debug',
    'cmkr'  : 'Release',
    'cmkrd' : 'RelWithDebInfo',
    'cmkmr' : 'MinSizeRel',
}[path.basename(argv[0])]

dirname = path.abspath(argv[-1])
if (len(argv) is 1):
    dirname = path.abspath(path.curdir)

if (path.isfile(path.join(dirname, 'CMakeLists.txt')) is True):
    check_call('mkdir -p %s' % path.join(dirname, 'build', build_type), shell=True)
    chdir(path.join(dirname, 'build', build_type))

execvp('cmake', ['cmake', '-DCMAKE_BUILD_TYPE=%s' % build_type] + argv[1:-1] + [dirname])


