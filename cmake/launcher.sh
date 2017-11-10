#!/bin/sh
case $(basename ${0}) in
    cmkd)
        build_type="Debug"
        ;;
    cmkr)
        build_type="Release"
        ;;
    cmkrd)
        build_type="RelWithDebInfo"
        ;;
    cmkmr)
        build_type="MinSizeRel"
        ;;
    cmkb)
        exec cmake --build ${@}
        ;;
    *)
        echo "Error: Running from unknow symbolic link \"$0\", this shell script only can be"
        echo "       run through symbolic link and now 'cmkd', 'cmkr', 'cmkrd', 'cmkmr' and 'cmkb' are supported."
        exit 1
        ;;
esac

if [ ${#} -eq 0 ]; then
    target_dirname=$(pwd)
else
    eval target_dirname=\${${#}}
    case ${target_dirname} in
        /*)
            ;;
        *)
            target_dirname=$(pwd)/${target_dirname}
            ;;
    esac
    shift
fi

if [ -f "${target_dirname}/CMakeLists.txt" ]; then
    mkdir -p ${target_dirname}/build/${build_type}
    cd ${target_dirname}/build/${build_type}
fi

exec cmake -DCMAKE_BUILD_TYPE=${build_type} ${@} ${target_dirname}
