cur_script_dir=`dirname $0`;
old_dir=`pwd`;
cd ${cur_script_dir}; cur_script_dir=`pwd`; cd ${old_dir}
unset old_dir
has_error=0

if [ ! -f ${cur_script_dir}/venv_bootstrap.py ]; then
    if [ -f ${cur_script_dir}/venv_bootstrap_generator.py ]; then
        ${cur_script_dir}/venv_bootstrap_generator.py
        has_error=$?
    else
        # Although Z shell support escape character in double quote mark, in
        # order to make code clean, the message has been separated here.
        echo -n "Can't find the needed script "
        echo -n '"venv_bootstrap_generator.py" in the directory of "venv.zsh", put it there and try'
        echo    " again."
        has_error=1
    fi
fi

if (( ${has_error} == 0 )); then
    switch_venv_tmp_file="/tmp/switch_venv_$$_`date +%m%d%H%M%S`"
    ${cur_script_dir}/venv_bootstrap.py $@ --switch-venv-tmp-file ${switch_venv_tmp_file}
    has_error=$?
    if [ -f ${switch_venv_tmp_file} ]; then
        source `cat ${switch_venv_tmp_file}`/bin/activate
        rm ${switch_venv_tmp_file}
    fi
    unset switch_venv_tmp_file
fi

unset cur_script_dir

if (( ${has_error} == 0 )); then
    unset has_error
    true
else
    unset has_error
    false
fi
