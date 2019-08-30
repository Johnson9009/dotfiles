#!/usr/bin/env python
import os
import sys
from subprocess import check_output, CalledProcessError, STDOUT
try:
    import virtualenv
except ImportError:
    alternative_python = 'python%d' % (5 - sys.version_info.major)
    try:
        check_output('%s -c "import virtualenv"' % alternative_python, stderr=STDOUT, shell=True)
    except CalledProcessError:
        sys.stderr.write("Can't find module virtualenv in python2 nor python3, please install it first.\n"
                         'if you are in a Python virtual environment, deactivate from it maybe help.\n')
        sys.exit(1)
    os.execvp(alternative_python, [alternative_python, os.path.realpath(__file__)] + sys.argv[1:])


EXTRA_TEXT = '''
from subprocess import check_call


venvs_file = os.path.expanduser('~/.virtualenv/venvs')


def extend_parser(parser):
    parser.add_option('--switch-venv-tmp-file', dest='switch_venv_tmp_file', help=optparse.SUPPRESS_HELP)


def adjust_options(options, args):
    if ((len(sys.argv) == 3) and (len(args) == 0) and (options.switch_venv_tmp_file is not None)):
        try:
            with open(venvs_file) as f:
                valid_lines = []
                for raw_line in f.read().splitlines():
                    if (os.path.exists(raw_line) is True):
                        valid_lines.append(raw_line)
                if (len(valid_lines) == 0):
                    raise IOError
        except IOError:
            print("You haven't any Python virtual environments.")
            sys.exit(0)

        for index, line in enumerate(valid_lines):
            print('[%d] %s\\t<===>\\t%s' % (index, os.path.basename(line), line))

        try:
            new_venv_home_dir = valid_lines[int(input('\\nSelect Your Choice: '))]
        except Exception as e:
            print('Error: Please input the valid index.')
            sys.exit(1)
        except KeyboardInterrupt:
            print('')    # Just print a newline character to keep the shell prompt neat.
            sys.exit(1)

        with open(options.switch_venv_tmp_file, 'w') as f:
            f.write(new_venv_home_dir)
        sys.exit(0)
    else:
        options.search_dirs.append("''' + os.path.join(os.path.dirname(virtualenv.__file__), 'virtualenv_support') + '''")
        return


def after_install(options, home_dir):
    new_venv_dir = os.path.abspath(home_dir).strip()
    try:
        with open(venvs_file) as f:
            lines = f.read().splitlines()
            if (new_venv_dir in lines):
                lines.remove(new_venv_dir)
            lines.append(new_venv_dir)
    except IOError:
        lines = [new_venv_dir]

    cmdLine = 'mkdir -p %s' % os.path.dirname(venvs_file)
    check_call(cmdLine, shell=True)
    with open(venvs_file, 'w') as f:
        for line in lines:
            if (os.path.exists(line) is True):
                f.write('%s\\n' % line)
'''


def main():
    text = virtualenv.create_bootstrap_script(EXTRA_TEXT)
    base_dir = os.path.dirname(os.path.realpath(__file__))
    bootstrap_script = os.path.join(base_dir, 'venv_bootstrap.py')

    if (os.path.exists(bootstrap_script) is True):
        with open(bootstrap_script) as f:
            if (f.read() == text):
                print("Bootstrap script %s is up-to-date with this generator, needn't to be updated."
                      % bootstrap_script)
                return
            else:
                print('Updating bootstrap script %s ...' % bootstrap_script)
    else:
        print('Generating bootstrap script %s ...' % bootstrap_script)

    with open(bootstrap_script, 'w') as f:
        f.write(text)
    os.chmod(bootstrap_script, os.stat(bootstrap_script).st_mode | 0o111)
    print('Bootstrap script is generated as %s successfully.' % bootstrap_script)


if __name__ == '__main__':
    main()
