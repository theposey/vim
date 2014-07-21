#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$1" != "" ]; then
    j=$(realpath $DIR/$1)
    $(find $j -name "*.c" -o -name "*.cpp" -o -name "*.h" > $j/cscope.files)
    $(ctags -L $j/cscope.files -o $j/tags --extra=+f)
    $(cd $j && cscope -b -q -k)
else
    for i in $( ls -d $DIR/*/ ); do
        j=$(realpath $i)
        $(find $j -name "*.c" -o -name "*.cpp" -o -name "*.h" > $j/cscope.files)
        $(ctags -L $j/cscope.files -o $j/tags --extra=+f)
        $(cd $j && cscope -b -q -k)
    done
fi

