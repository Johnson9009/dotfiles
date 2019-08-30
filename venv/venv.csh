# Get script path in order to call venv_bootstrap.py
set cmd_line = ($_)
if (${cmd_line[1]} == "source") then
    # If this script is run by source XXX/venv.csh
    set cur_script_dir = `dirname ${cmd_line[2]}`
else
    # If this script is run by alias
    setenv alias_name ${cmd_line[1]}
    set alias_output = (`alias ${alias_name}`)
    unsetenv alias_name
    set cur_script_dir = `dirname ${alias_output[2]}`
    unset alias_output
endif
unset cmd_line

set old_dir = `pwd`;
cd ${cur_script_dir}; set cur_script_dir = `pwd`; cd ${old_dir}
unset old_dir

set has_error = 0
if (! -f "${cur_script_dir}/venv_bootstrap.py") then
    if (-f "${cur_script_dir}/venv_bootstrap_generator.py") then
        ${cur_script_dir}/venv_bootstrap_generator.py
        set has_error = ${status}
    else
        # C shell don't support escape character in double quote mark, so we
        # must separate this message. In addition, what need to be paid
        # attention to is all the $, \, ` in single quote mark will not be
        # processed specially, they will be treated as normal characters. This
        # rule is common both in csh, bash, zsh. So we should prefer double
        # quote mark in shell script if we can.
        echo -n "Can't find the needed script "
        echo -n '"venv_bootstrap_generator.py" in the directory of "venv.csh", put it there and try'
        echo    " again."
        set has_error = 1
    endif
endif

if (${has_error} == 0) then
    set switch_venv_tmp_file = "/tmp/switch_venv_$$_`date +%m%d%H%M%S`"
    ${cur_script_dir}/venv_bootstrap.py ${argv} --switch-venv-tmp-file ${switch_venv_tmp_file}
    set has_error = ${status}
    if (-f ${switch_venv_tmp_file}) then
        source `cat ${switch_venv_tmp_file}`/bin/activate.csh
        rm ${switch_venv_tmp_file}
    endif
    unset switch_venv_tmp_file
endif

unset cur_script_dir
if (${has_error} == 0) then
    unset has_error
    exit 0
else
    unset has_error
    exit 1
endif
