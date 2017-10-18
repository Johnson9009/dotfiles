#!/usr/bin/env python3
import sys
from os import path, linesep
from subprocess import call, check_call


dotfilesPath = path.abspath(path.dirname(path.dirname(sys.argv[0]))) + '/'


def getSymlinkAndTarget(line):
    result = []
    for pathName in line.split('->'):
        pathName = path.expandvars(path.expanduser(pathName.strip()))
        if (path.isabs(pathName) is False and pathName is not ''):
            pathName = dotfilesPath + pathName
        result.append(pathName)
    return (result[0], result[1])


def createSymlink(symlink, target, backupSymlinks):
    if (path.exists(symlink) is True):
        backupSymlink = '%s.bak' % symlink
        backupSuffix = 1
        while (True):
            if (path.exists(backupSymlink) is True):
                backupSymlink = '%s.bak%d' % (symlink, backupSuffix)
                backupSuffix += 1
            else:
                break
        cmdLine = 'mv %s %s' % (symlink, backupSymlink)
        check_call(cmdLine, shell=True)
        backupSymlinks.append((symlink, backupSymlink))
    else:
        cmdLine = 'mkdir -p %s' % path.dirname(symlink)
        call(cmdLine, shell=True)

    cmdLine = 'ln -s %s %s' % (target, symlink)
    check_call(cmdLine, shell=True)


def summary(skipedSymlinks, backupSymlinks):
    print('\nAll Done!')
    if (len(skipedSymlinks) is not 0):
        print('Below symbolic links are not created (Skiped by you):')
        print(linesep.join(skipedSymlinks))
    if (len(backupSymlinks) is not 0):
        print('\nBelow symbolic links are created and original files are backup:')
        for (symlink, backupSymlink) in backupSymlinks:
            print('%s backup to %s' % (symlink, backupSymlink))


with open(dotfilesPath + 'symbolics') as f:
    skipedSymlinks = []
    backupSymlinks = []
    for line in f.readlines():
        if (line.strip() is ''):
            continue
        symlink, target = getSymlinkAndTarget(line)
        # if target is None then read abs path from user
        if (target is ''):
            target = input('Please input the target that "%s" should be linked to,\n'
                           'leave blank to skip the creation of this symbolic link: ' % symlink).strip()
        if (target is ''):
            skipedSymlinks.append(symlink)
            continue
        createSymlink(symlink, target, backupSymlinks)
    summary(skipedSymlinks, backupSymlinks)


