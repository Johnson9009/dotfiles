from os import path

localInitFile = path.expanduser('~/.local.gdbinit')
if (path.isfile(localInitFile) is True):
    gdb.execute('source %s' % localInitFile)
    print('The local initial file %s is loaded.' % localInitFile)
else:
    print('If the local initial file %s is exist, it will be loaded automatically.' % localInitFile)
